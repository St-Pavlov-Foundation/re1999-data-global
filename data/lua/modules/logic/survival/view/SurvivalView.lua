-- chunkname: @modules/logic/survival/view/SurvivalView.lua

module("modules.logic.survival.view.SurvivalView", package.seeall)

local SurvivalView = class("SurvivalView", BaseView)

function SurvivalView:onInitView()
	self._btnContinue = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Continue")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Enter")
	self._btnabort = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_abort")
	self._btnachievement = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_achievement")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_reward")
	self._gobooty = gohelper.findChild(self.viewGO, "Left/#go_booty")
	self._btnFold = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_booty/#btn_fold")
	self._goImageUnFold = gohelper.findChild(self.viewGO, "Left/#go_booty/#btn_fold/image_unfold")
	self._goImageFold = gohelper.findChild(self.viewGO, "Left/#go_booty/#btn_fold/image_fold")
	self._btnCloseFold = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_booty/#go_fold/#btn_close")
	self._goFold = gohelper.findChild(self.viewGO, "Left/#go_booty/#go_fold")
	self._gored = gohelper.findChild(self.viewGO, "Left/#btn_reward/#go_reddot")
	self.goCanget = gohelper.findChild(self.viewGO, "Left/#btn_reward/#canget")
	self.goNormal = gohelper.findChild(self.viewGO, "Left/#btn_reward/#normal")
	self._txtDifficulty = gohelper.findChildTextMesh(self.viewGO, "Right/#btn_Continue/#go_difficult/#txt_difficult")
	self._txtDay = gohelper.findChildTextMesh(self.viewGO, "Right/#btn_Continue/#go_difficult/#txt_days")
	self.bootyList = {}
	self.goBootyContent = gohelper.findChild(self.viewGO, "Left/#go_booty/#go_fold/Scroll/Viewport/Content")
	self.goInfo = gohelper.findChild(self.viewGO, "Left/goinfo")

	self:setFoldVisible(true)

	self.btn_handbook = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_handbook")
	self.handbook_go_red = gohelper.findChild(self.viewGO, "Left/#btn_handbook/#go_red")
	self.btn_tech = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_tech")
	self.tech_go_red = gohelper.findChild(self.viewGO, "Left/#btn_tech/#go_red")
end

function SurvivalView:addEvents()
	self._btnContinue:AddClickListener(self._onContinueClick, self)
	self._btnEnter:AddClickListener(self._onEnterClick, self)
	self._btnabort:AddClickListener(self._onAbortClick, self)
	self._btnachievement:AddClickListener(self._onAchievementClick, self)
	self._btnreward:AddClickListener(self._onRewardClick, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnOutInfoChange, self._refreshView, self)
	self:addClickCb(self._btnFold, self.onClickFold, self)
	self:addClickCb(self._btnCloseFold, self.onClickCloseFold, self)
	self:addClickCb(self.btn_handbook, self.onClickBtnHandbook, self)
	self:addClickCb(self.btn_tech, self.onClickBtnTech, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function SurvivalView:removeEvents()
	self._btnContinue:RemoveClickListener()
	self._btnEnter:RemoveClickListener()
	self._btnabort:RemoveClickListener()
	self._btnachievement:RemoveClickListener()
	self._btnreward:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnOutInfoChange, self._refreshView, self)
	self:removeClickCb(self._btnFold)
	self:removeClickCb(self._btnCloseFold)
end

function SurvivalView:onClickFold()
	self:setFoldVisible(not self._foldVisible)
end

function SurvivalView:onClickCloseFold()
	self:setFoldVisible(not self._foldVisible)
end

function SurvivalView:onClickBtnHandbook()
	SurvivalStatHelper.instance:statBtnClick("onClickBtnHandbook", "SurvivalView")
	SurvivalHandbookController.instance:sendOpenSurvivalHandbookView()
end

function SurvivalView:onClickBtnTech()
	SurvivalStatHelper.instance:statBtnClick("onClickBtnTech", "SurvivalView")
	ViewMgr.instance:openView(ViewName.SurvivalTechView)
end

function SurvivalView:_onCloseViewFinish(viewName)
	if viewName == ViewName.SurvivalCeremonyClosingView then
		self:tryTriggerTechGuild()
	end
end

function SurvivalView:onOpen()
	RedDotController.instance:addRedDot(self._gored, RedDotEnum.DotNode.V2a8Survival, false, self._refreshRed, self)
	TaskDispatcher.runRepeat(self.everySecondCall, self, 0, -1)
	self:_refreshView()
	RedDotController.instance:addRedDot(self.handbook_go_red, RedDotEnum.DotNode.SurvivalHandbook)
	RedDotController.instance:addRedDot(self.tech_go_red, RedDotEnum.DotNode.SurvivalOutSideTeach)
	self:tryTriggerTechGuild()
end

function SurvivalView:tryTriggerTechGuild()
	local survivalOutSideTechMo = SurvivalModel.instance:getOutSideInfo().survivalOutSideTechMo

	if survivalOutSideTechMo:haveTechPoint() then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideMainViewTech)
	end
end

function SurvivalView:_refreshRed(redDot)
	redDot:defaultRefreshDot()

	local isShow = redDot.show

	gohelper.setActive(self.goCanget, isShow)
	gohelper.setActive(self.goNormal, not isShow)
end

function SurvivalView:everySecondCall()
	if self._txtLimitTime then
		local curVersionActivityId = SurvivalModel.instance:getCurVersionActivityId()

		self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(curVersionActivityId)
	end
end

function SurvivalView:_refreshView()
	local outSideInfo = SurvivalModel.instance:getOutSideInfo()

	gohelper.setActive(self._btnabort, outSideInfo.inWeek)
	gohelper.setActive(self._btnContinue, outSideInfo.inWeek)
	gohelper.setActive(self._btnEnter, not outSideInfo.inWeek)

	if outSideInfo.inWeek then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
		local difficulty = weekInfo and weekInfo.difficulty or outSideInfo.currMod
		local curDay = weekInfo and weekInfo.day or outSideInfo.currDay
		local config = lua_survival_hardness_mod.configDict[difficulty]

		self._txtDifficulty.text = config and config.name
		self._txtDay.text = formatLuaLang("versionactivity_1_2_114daydes", curDay)
	end

	self:refreshEndBg()
	self:refreshBooty()
end

function SurvivalView:refreshEndBg()
	if not self.endPart then
		local param = {}

		param.view = self
		self.endPart = MonoHelper.addNoUpdateLuaComOnceToGo(self.viewGO, SurvivalEndPart, param)
	end

	self.endPart:refreshView()
end

function SurvivalView:refreshBooty()
	gohelper.setActive(self._gobooty, false)
end

function SurvivalView:setFoldVisible(visible)
	if self._foldVisible == visible then
		return
	end

	self._foldVisible = visible

	gohelper.setActive(self._goFold, visible)
	gohelper.setActive(self._goImageFold, not visible)
	gohelper.setActive(self._goImageUnFold, visible)
end

function SurvivalView:_onContinueClick()
	SurvivalController.instance:enterShelterMap()
	SurvivalStatHelper.instance:statBtnClick("_onContinueClick", "SurvivalView")
end

function SurvivalView:_onEnterClick()
	local outSideInfo = SurvivalModel.instance:getOutSideInfo()

	if not outSideInfo then
		return
	end

	self:_enterSurvival()
	SurvivalStatHelper.instance:statBtnClick("_onEnterClick", "SurvivalView")
end

function SurvivalView:_enterSurvival()
	local outSideInfo = SurvivalModel.instance:getOutSideInfo()

	if outSideInfo:isFirstPlay() then
		local storyId = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.StoryFirstEnter)

		storyId = tonumber(storyId) or 0

		if storyId > 0 and not StoryModel.instance:isStoryFinished(storyId) then
			StoryController.instance:playStory(storyId, nil, self._firstEnterSurvival, self)
		else
			self:_firstEnterSurvival()
		end
	elseif outSideInfo:isEndUnLock(3001) or outSideInfo:isEndUnLock(3002) then
		local storyId = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.StoryPassEnter)

		storyId = tonumber(storyId) or 0

		if storyId > 0 and not StoryModel.instance:isStoryFinished(storyId) then
			StoryController.instance:playStory(storyId, nil, self._noFirstEnterSurvival, self)
		else
			self:_noFirstEnterSurvival()
		end
	else
		self:_noFirstEnterSurvival()
	end
end

function SurvivalView:_firstEnterSurvival()
	local roleId = SurvivalModel.instance:getDefaultRoleId()

	SurvivalWeekRpc.instance:sendSurvivalStartWeekChooseDiff(SurvivalConst.FirstPlayDifficulty, nil, roleId)
end

function SurvivalView:_noFirstEnterSurvival()
	ViewMgr.instance:openView(ViewName.SurvivalHardView)
end

function SurvivalView:_onAbortClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalGiveUpWeek, MsgBoxEnum.BoxType.Yes_No, self._sendGiveUp, nil, nil, self, nil, nil)
	SurvivalStatHelper.instance:statBtnClick("_onAbortClick", "SurvivalView")
end

function SurvivalView:_sendGiveUp()
	SurvivalWeekRpc.instance:sendSurvivalGetWeekInfo(self._onRecvWeekInfo, self)
end

function SurvivalView:_onRecvWeekInfo(cmd, resultCode, msg)
	if resultCode == 0 then
		SurvivalWeekRpc.instance:sendSurvivalAbandonWeek()
	end
end

function SurvivalView:_onAchievementClick()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		local curVersionActivityId = SurvivalModel.instance:getCurVersionActivityId()
		local config = ActivityConfig.instance:getActivityCo(curVersionActivityId)
		local jumpId = config.achievementJumpId

		JumpController.instance:jump(jumpId)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
	end

	SurvivalStatHelper.instance:statBtnClick("_onAchievementClick", "SurvivalView")
end

function SurvivalView:_onRewardClick()
	ViewMgr.instance:openView(ViewName.SurvivalShelterRewardView)
	SurvivalStatHelper.instance:statBtnClick("_onRewardClick", "SurvivalView")
end

function SurvivalView:onClose()
	TaskDispatcher.cancelTask(self.everySecondCall, self)
end

return SurvivalView
