-- chunkname: @modules/logic/versionactivity2_6/xugouji/view/XugoujiMainView2.lua

module("modules.logic.versionactivity2_6.xugouji.view.XugoujiMainView2", package.seeall)

local XugoujiMainView = class("XugoujiMainView", BaseView)
local actId = VersionActivity2_6Enum.ActivityId.Xugouji
local pathStageValues = {
	0.86,
	0.6,
	0.48,
	0.35,
	0.25,
	0.13,
	0
}
local pathEffectDuration = 1
local stage1ContentRectOffset = 0
local stage2ContentRectOffset = -480
local stage2Idx = 5
local showEndlessCount = 8

function XugoujiMainView:onInitView()
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "window/righttop/reward/clickArea", AudioEnum.UI.play_ui_mission_open)
	self._btnEndless = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Endless")
	self._btnReplay = gohelper.findChildButton(self.viewGO, "window/title/#btn_Play")
	self._goscrollcontent = gohelper.findChild(self.viewGO, "#go_path/#go_scrollcontent")
	self._goContent = gohelper.findChild(self.viewGO, "#go_path/#go_scrollcontent/Content")
	self._gostages = gohelper.findChild(self.viewGO, "#go_path/#go_scrollcontent/Content/#go_stages")
	self._txtlimittime = gohelper.findChildText(self.viewGO, "window/title/#txt_time")

	local goPath = gohelper.findChild(self.viewGO, "#go_path/#go_scrollcontent/Content/path")

	self._viewAnimator = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._animPath = goPath:GetComponent(gohelper.Type_Animator)
	self._taskAnimator = gohelper.findChild(self.viewGO, "window/righttop/reward/ani"):GetComponent(gohelper.Type_Animator)
	self._gored = gohelper.findChild(self.viewGO, "window/righttop/reward/reddot")
	self._goEndlessRedDot = gohelper.findChild(self.viewGO, "#btn_Endless/#go_reddot")
end

function XugoujiMainView:addEvents()
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btnEndless:AddClickListener(self._btnEndlessOnClick, self)
	self._btnReplay:AddClickListener(self._btnReplayOnClick, self)
	self:addEventCb(LoperaController.instance, LoperaEvent.BeforeEnterEpisode, self._beforeEneterEpisode, self)
	self:addEventCb(LoperaController.instance, LoperaEvent.EpisodeUpdate, self._onEpisodeUpdate, self)
	self:addEventCb(LoperaController.instance, LoperaEvent.EpisodeFinish, self._onEpisodeFinish, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self._refreshTask, self)
	RedDotController.instance:addRedDot(self._gored, RedDotEnum.DotNode.LoperaTaksReword)
end

function XugoujiMainView:removeEvents()
	self._btntask:RemoveClickListener()
	self._btnEndless:RemoveClickListener()
	self._btnReplay:RemoveClickListener()
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self._refreshTask, self)
end

function XugoujiMainView:_btntaskOnClick()
	LoperaController.instance:openTaskView()
end

function XugoujiMainView:_btnEndlessOnClick()
	LoperaController.instance:enterEpisode(LoperaEnum.EndlessEpisodeId)
	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.Version2_2LoperaEndlessNewFlag .. actId, 1)
end

function XugoujiMainView:_btnReplayOnClick()
	local activityMo = ActivityModel.instance:getActMO(actId)
	local storyId = activityMo and activityMo.config and activityMo.config.storyId

	if not storyId or storyId == 0 then
		logError(string.format("act id %s dot config story id", self.curActId))

		return
	end

	StoryController.instance:playStory(storyId)
end

function XugoujiMainView:_editableInitView()
	self._viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	local gopath2 = gohelper.findChild(self.viewGO, "#go_path/#go_scrollcontent/path/path_2")

	self._pathAnimator = gopath2:GetComponent(typeof(UnityEngine.Animator))
	self._excessAnimator = self._goexcessive:GetComponent(typeof(UnityEngine.Animator))
	self._blackAnimator = self._goblack:GetComponent(typeof(UnityEngine.Animator))
end

function XugoujiMainView:onOpen()
	self:_initStages()
	self:_refreshBtnState()
	self:refreshTime()
	self:_refreshTask()
	self:_refreshPathState()
	TaskDispatcher.runRepeat(self.refreshTime, self, 60)
	self._viewAnimator:Play(UIAnimationName.Open, 0, 0)
end

function XugoujiMainView:_onGetEpisodeInfo(cmd, resultCode, msg)
	if resultCode == 0 then
		ViewMgr.instance:openView(ViewName.LoperaLevelView)
	end
end

function XugoujiMainView:onClose()
	return
end

function XugoujiMainView:_initStages()
	if self._stageItemList then
		return
	end

	local stagePrefabPath = self.viewContainer:getSetting().otherRes[1]

	self._stageItemList = {}
	self._curOpenEpisodeCount = Activity168Model.instance:getFinishedCount() + 1

	local actId = VersionActivity2_2Enum.ActivityId.Lopera
	local episodeCfgList = Activity168Config.instance:getEpisodeCfgList(actId)
	local selectIndex = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.Version2_2LoperaSelect .. actId, "1")

	selectIndex = tonumber(selectIndex) or 1
	selectIndex = Mathf.Clamp(selectIndex, 1, #episodeCfgList)

	local selectedEpisode = episodeCfgList[selectIndex] and episodeCfgList[selectIndex] or episodeCfgList[1]
	local selectedEpisodeId = selectedEpisode.id

	Activity168Model.instance:setCurEpisodeId(selectedEpisodeId)

	for i = 1, #episodeCfgList do
		local cfg = episodeCfgList[i]

		if cfg.episodeType == LoperaEnum.EpisodeType.ExploreEndless then
			break
		end

		local nodeRoot = gohelper.findChild(self._gostages, "stage" .. i)
		local cloneGo = self:getResInst(stagePrefabPath, nodeRoot)
		local stageItem = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, XugoujiLevelViewStageItem, self)

		stageItem:refreshItem(cfg, i)
		table.insert(self._stageItemList, stageItem)
	end

	self:_setContentOffset(selectIndex)
end

function XugoujiMainView:_setContentOffset(selectIndex)
	recthelper.setAnchor(self._goContent.transform, selectIndex < stage2Idx and stage1ContentRectOffset or stage2ContentRectOffset, 0)
end

function XugoujiMainView:_refreshBtnState()
	local finishedCount = Activity168Model.instance:getFinishedCount()

	gohelper.setActive(self._goEndlessRedDot, self._checkEnterEndlessMode())
	gohelper.setActive(self._btnEndless.gameObject, finishedCount >= showEndlessCount)

	if finishedCount >= showEndlessCount then
		LoperaController.instance:dispatchEvent(LoperaEvent.EndlessUnlock)
	end
end

function XugoujiMainView:_refreshPathState()
	local finishedCount = Activity168Model.instance:getFinishedCount()

	self._pathEffectValue = finishedCount > 0 and pathStageValues[finishedCount] or 1

	self:_setPathMatEffectValue(self._pathEffectValue)
end

function XugoujiMainView:_setPathMatEffectValue(value)
	if not self._pathMat then
		local pathGo = gohelper.findChild(self.viewGO, "#go_path/#go_scrollcontent/Content/path/luxian_light")
		local UIMesh = pathGo:GetComponent(typeof(UIMesh))

		self._pathMat = UIMesh.material
	end

	local vector = Vector4.New(value, 0.05, 0, 0)

	self._pathMat:SetVector("_DissolveControl", vector)
end

function XugoujiMainView:_onEpisodeFinish(resultData)
	self:_refreshTask()
end

function XugoujiMainView:tryShowFinishUnlockView()
	local finishCount = Activity168Model.instance:getFinishedCount()

	if finishCount < self._curOpenEpisodeCount then
		return
	end

	local episodeId = Activity168Model.instance:getCurEpisodeId()

	if episodeId and episodeId == LoperaEnum.EndlessEpisodeId then
		return
	end

	self._curOpenEpisodeCount = finishCount + 1
	self._playingUnlockNextLevel = true

	self:_destroyFlow()

	self.unlockAniflow = FlowSequence.New()

	self.unlockAniflow:addWork(DelayFuncWork.New(self._playFinishAni, self, 1))
	self.unlockAniflow:addWork(DelayFuncWork.New(self._playNewPathAni, self, 1))
	self.unlockAniflow:addWork(DelayFuncWork.New(self._playUnlockAni, self, 1))
	self.unlockAniflow:addWork(DelayFuncWork.New(self._playChessMoveAni, self, 1))
	self.unlockAniflow:start()
end

function XugoujiMainView:_playFinishAni()
	local finishCount = Activity168Model.instance:getFinishedCount()

	if self._stageItemList[finishCount] then
		self._stageItemList[finishCount]:playFinishAni()
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Lopera.play_ui_molu_jlbn_level_pass)
end

function XugoujiMainView:_playNewPathAni()
	local finishCount = Activity168Model.instance:getFinishedCount()
	local targetPathEffectValue = finishCount > 0 and pathStageValues[finishCount] or 1

	if self._pathEffectValue == targetPathEffectValue then
		return
	end

	local oriValue = self._pathEffectValue

	oriValue = 1
	self._pathEffectValue = targetPathEffectValue

	local duration = pathEffectDuration

	self._pathAnimTweenId = ZProj.TweenHelper.DOTweenFloat(oriValue, targetPathEffectValue, duration, self._onPathFrame, nil, self, nil, EaseType.Linear)
end

function XugoujiMainView:_onPathFrame(t)
	self:_setPathMatEffectValue(t)
end

function XugoujiMainView:_playUnlockAni()
	local finishCount = Activity168Model.instance:getFinishedCount()

	if self._stageItemList[finishCount + 1] then
		self._stageItemList[finishCount + 1]:playUnlockAni()
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Lopera.play_ui_molu_jlbn_level_unlock)
	end
end

function XugoujiMainView:_playChessMoveAni()
	return
end

function XugoujiMainView:_beforeEneterEpisode()
	self._viewAnimator:Play(UIAnimationName.Click, 0, 0)
end

function XugoujiMainView:_onEpisodeUpdate()
	self:_refreshBtnState()
end

function XugoujiMainView:refreshTime()
	self._txtlimittime.text = self.getLimitTimeStr()
end

function XugoujiMainView.getLimitTimeStr()
	local actInfoMo = ActivityModel.instance:getActMO(VersionActivity2_2Enum.ActivityId.Lopera)

	if not actInfoMo then
		return ""
	end

	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	if offsetSecond > 0 then
		return TimeUtil.SecondToActivityTimeFormat(offsetSecond)
	end

	return ""
end

function XugoujiMainView:_checkEnterEndlessMode()
	local endlessNewFlag = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.Version2_2LoperaEndlessNewFlag .. actId, 0)

	return endlessNewFlag == 0
end

function XugoujiMainView:_refreshTask()
	local hasRewards = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.LoperaTaksReword, 0)

	if hasRewards then
		self._taskAnimator:Play(UIAnimationName.Loop, 0, 0)
	else
		self._taskAnimator:Play(UIAnimationName.Idle, 0, 0)
	end
end

function XugoujiMainView:_destroyFlow()
	if self.unlockAniflow then
		self.unlockAniflow:destroy()

		self.unlockAniflow = nil
	end
end

function XugoujiMainView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshTime, self)
	self:_destroyFlow()
end

return XugoujiMainView
