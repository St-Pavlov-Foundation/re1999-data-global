module("modules.logic.versionactivity2_2.lopera.view.LoperaMainView", package.seeall)

slot0 = class("LoperaMainView", BaseView)
slot1 = VersionActivity2_2Enum.ActivityId.Lopera
slot2 = {
	0.86,
	0.6,
	0.48,
	0.35,
	0.25,
	0.13,
	0
}
slot3 = 1
slot4 = 0
slot5 = -480
slot6 = 5
slot7 = 8

function slot0.onInitView(slot0)
	slot0._btntask = gohelper.findChildButtonWithAudio(slot0.viewGO, "window/righttop/reward/clickArea", AudioEnum.UI.play_ui_mission_open)
	slot0._btnEndless = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Endless")
	slot0._btnReplay = gohelper.findChildButton(slot0.viewGO, "window/title/#btn_Play")
	slot0._goscrollcontent = gohelper.findChild(slot0.viewGO, "#go_path/#go_scrollcontent")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "#go_path/#go_scrollcontent/Content")
	slot0._gostages = gohelper.findChild(slot0.viewGO, "#go_path/#go_scrollcontent/Content/#go_stages")
	slot0._txtlimittime = gohelper.findChildText(slot0.viewGO, "window/title/#txt_time")
	slot0._viewAnimator = slot0.viewGO:GetComponent(gohelper.Type_Animator)
	slot0._animPath = gohelper.findChild(slot0.viewGO, "#go_path/#go_scrollcontent/Content/path"):GetComponent(gohelper.Type_Animator)
	slot0._taskAnimator = gohelper.findChild(slot0.viewGO, "window/righttop/reward/ani"):GetComponent(gohelper.Type_Animator)
	slot0._gored = gohelper.findChild(slot0.viewGO, "window/righttop/reward/reddot")
	slot0._goEndlessRedDot = gohelper.findChild(slot0.viewGO, "#btn_Endless/#go_reddot")
end

function slot0.addEvents(slot0)
	slot0._btntask:AddClickListener(slot0._btntaskOnClick, slot0)
	slot0._btnEndless:AddClickListener(slot0._btnEndlessOnClick, slot0)
	slot0._btnReplay:AddClickListener(slot0._btnReplayOnClick, slot0)
	slot0:addEventCb(LoperaController.instance, LoperaEvent.BeforeEnterEpisode, slot0._beforeEneterEpisode, slot0)
	slot0:addEventCb(LoperaController.instance, LoperaEvent.EpisodeUpdate, slot0._onEpisodeUpdate, slot0)
	slot0:addEventCb(LoperaController.instance, LoperaEvent.EpisodeFinish, slot0._onEpisodeFinish, slot0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, slot0._refreshTask, slot0)
	RedDotController.instance:addRedDot(slot0._gored, RedDotEnum.DotNode.LoperaTaksReword)
end

function slot0.removeEvents(slot0)
	slot0._btntask:RemoveClickListener()
	slot0._btnEndless:RemoveClickListener()
	slot0._btnReplay:RemoveClickListener()
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, slot0._refreshTask, slot0)
end

function slot0._btntaskOnClick(slot0)
	LoperaController.instance:openTaskView()
end

function slot0._btnEndlessOnClick(slot0)
	LoperaController.instance:enterEpisode(LoperaEnum.EndlessEpisodeId)
	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.Version2_2LoperaEndlessNewFlag .. uv0, 1)
end

function slot0._btnReplayOnClick(slot0)
	if not ActivityModel.instance:getActMO(uv0) or not slot1.config or not slot1.config.storyId or slot2 == 0 then
		logError(string.format("act id %s dot config story id", slot0.curActId))

		return
	end

	StoryController.instance:playStory(slot2)
end

function slot0._editableInitView(slot0)
	slot0._viewAnimator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._pathAnimator = gohelper.findChild(slot0.viewGO, "#go_path/#go_scrollcontent/path/path_2"):GetComponent(typeof(UnityEngine.Animator))
	slot0._excessAnimator = slot0._goexcessive:GetComponent(typeof(UnityEngine.Animator))
	slot0._blackAnimator = slot0._goblack:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.onOpen(slot0)
	slot0:_initStages()
	slot0:_refreshBtnState()
	slot0:refreshTime()
	slot0:_refreshTask()
	slot0:_refreshPathState()
	TaskDispatcher.runRepeat(slot0.refreshTime, slot0, 60)
	slot0._viewAnimator:Play(UIAnimationName.Open, 0, 0)
end

function slot0._onGetEpisodeInfo(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		ViewMgr.instance:openView(ViewName.LoperaLevelView)
	end
end

function slot0.onClose(slot0)
end

function slot0._initStages(slot0)
	if slot0._stageItemList then
		return
	end

	slot1 = slot0.viewContainer:getSetting().otherRes[1]
	slot0._stageItemList = {}
	slot0._curOpenEpisodeCount = Activity168Model.instance:getFinishedCount() + 1
	slot2 = VersionActivity2_2Enum.ActivityId.Lopera
	slot3 = Activity168Config.instance:getEpisodeCfgList(slot2)

	Activity168Model.instance:setCurEpisodeId((slot3[Mathf.Clamp(tonumber(GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.Version2_2LoperaSelect .. slot2, "1")) or 1, 1, #slot3)] and slot3[slot4] or slot3[1]).id)

	for slot10 = 1, #slot3 do
		if slot3[slot10].episodeType == LoperaEnum.EpisodeType.ExploreEndless then
			break
		end

		slot14 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot1, gohelper.findChild(slot0._gostages, "stage" .. slot10)), LoperaMainViewStageItem, slot0)

		slot14:refreshItem(slot11, slot10)
		table.insert(slot0._stageItemList, slot14)
	end

	slot0:_setContentOffset(slot4)
end

function slot0._setContentOffset(slot0, slot1)
	recthelper.setAnchor(slot0._goContent.transform, slot1 < uv0 and uv1 or uv2, 0)
end

function slot0._refreshBtnState(slot0)
	gohelper.setActive(slot0._goEndlessRedDot, slot0._checkEnterEndlessMode())
	gohelper.setActive(slot0._btnEndless.gameObject, uv0 <= Activity168Model.instance:getFinishedCount())

	if uv0 <= slot1 then
		LoperaController.instance:dispatchEvent(LoperaEvent.EndlessUnlock)
	end
end

function slot0._refreshPathState(slot0)
	slot0._pathEffectValue = Activity168Model.instance:getFinishedCount() > 0 and uv0[slot1] or 1

	slot0:_setPathMatEffectValue(slot0._pathEffectValue)
end

function slot0._setPathMatEffectValue(slot0, slot1)
	if not slot0._pathMat then
		slot0._pathMat = gohelper.findChild(slot0.viewGO, "#go_path/#go_scrollcontent/Content/path/luxian_light"):GetComponent(typeof(UIMesh)).material
	end

	slot0._pathMat:SetVector("_DissolveControl", Vector4.New(slot1, 0.05, 0, 0))
end

function slot0._onEpisodeFinish(slot0, slot1)
	slot0:_refreshTask()
end

function slot0.tryShowFinishUnlockView(slot0)
	if Activity168Model.instance:getFinishedCount() < slot0._curOpenEpisodeCount then
		return
	end

	if Activity168Model.instance:getCurEpisodeId() and slot2 == LoperaEnum.EndlessEpisodeId then
		return
	end

	slot0._curOpenEpisodeCount = slot1 + 1
	slot0._playingUnlockNextLevel = true

	slot0:_destroyFlow()

	slot0.unlockAniflow = FlowSequence.New()

	slot0.unlockAniflow:addWork(DelayFuncWork.New(slot0._playFinishAni, slot0, 1))
	slot0.unlockAniflow:addWork(DelayFuncWork.New(slot0._playNewPathAni, slot0, 1))
	slot0.unlockAniflow:addWork(DelayFuncWork.New(slot0._playUnlockAni, slot0, 1))
	slot0.unlockAniflow:addWork(DelayFuncWork.New(slot0._playChessMoveAni, slot0, 1))
	slot0.unlockAniflow:start()
end

function slot0._playFinishAni(slot0)
	if slot0._stageItemList[Activity168Model.instance:getFinishedCount()] then
		slot0._stageItemList[slot1]:playFinishAni()
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Lopera.play_ui_molu_jlbn_level_pass)
end

function slot0._playNewPathAni(slot0)
	if slot0._pathEffectValue == (Activity168Model.instance:getFinishedCount() > 0 and uv0[slot1] or 1) then
		return
	end

	slot3 = slot0._pathEffectValue
	slot0._pathEffectValue = slot2
	slot0._pathAnimTweenId = ZProj.TweenHelper.DOTweenFloat(1, slot2, uv1, slot0._onPathFrame, nil, slot0, nil, EaseType.Linear)
end

function slot0._onPathFrame(slot0, slot1)
	slot0:_setPathMatEffectValue(slot1)
end

function slot0._playUnlockAni(slot0)
	if slot0._stageItemList[Activity168Model.instance:getFinishedCount() + 1] then
		slot0._stageItemList[slot1 + 1]:playUnlockAni()
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Lopera.play_ui_molu_jlbn_level_unlock)
	end
end

function slot0._playChessMoveAni(slot0)
end

function slot0._beforeEneterEpisode(slot0)
	slot0._viewAnimator:Play(UIAnimationName.Click, 0, 0)
end

function slot0._onEpisodeUpdate(slot0)
	slot0:_refreshBtnState()
end

function slot0.refreshTime(slot0)
	slot0._txtlimittime.text = slot0.getLimitTimeStr()
end

function slot0.getLimitTimeStr()
	if not ActivityModel.instance:getActMO(VersionActivity2_2Enum.ActivityId.Lopera) then
		return ""
	end

	if slot0:getRealEndTimeStamp() - ServerTime.now() > 0 then
		return TimeUtil.SecondToActivityTimeFormat(slot1)
	end

	return ""
end

function slot0._checkEnterEndlessMode(slot0)
	return GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.Version2_2LoperaEndlessNewFlag .. uv0, 0) == 0
end

function slot0._refreshTask(slot0)
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.LoperaTaksReword, 0) then
		slot0._taskAnimator:Play(UIAnimationName.Loop, 0, 0)
	else
		slot0._taskAnimator:Play(UIAnimationName.Idle, 0, 0)
	end
end

function slot0._destroyFlow(slot0)
	if slot0.unlockAniflow then
		slot0.unlockAniflow:destroy()

		slot0.unlockAniflow = nil
	end
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.refreshTime, slot0)
	slot0:_destroyFlow()
end

return slot0
