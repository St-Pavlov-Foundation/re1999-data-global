module("modules.logic.survival.view.SurvivalView", package.seeall)

local var_0_0 = class("SurvivalView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnContinue = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Continue")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Enter")
	arg_1_0._btnabort = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_abort")
	arg_1_0._btnachievement = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_achievement")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_reward")
	arg_1_0._gobooty = gohelper.findChild(arg_1_0.viewGO, "Left/#go_booty")
	arg_1_0._btnFold = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#go_booty/#btn_fold")
	arg_1_0._goImageUnFold = gohelper.findChild(arg_1_0.viewGO, "Left/#go_booty/#btn_fold/image_unfold")
	arg_1_0._goImageFold = gohelper.findChild(arg_1_0.viewGO, "Left/#go_booty/#btn_fold/image_fold")
	arg_1_0._btnCloseFold = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#go_booty/#go_fold/#btn_close")
	arg_1_0._goFold = gohelper.findChild(arg_1_0.viewGO, "Left/#go_booty/#go_fold")
	arg_1_0._gored = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_reward/#go_reddot")
	arg_1_0.goCanget = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_reward/#canget")
	arg_1_0.goNormal = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_reward/#normal")
	arg_1_0._txtDifficulty = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#btn_Continue/#go_difficult/#txt_difficult")
	arg_1_0._txtDay = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#btn_Continue/#go_difficult/#txt_days")
	arg_1_0.bootyList = {}
	arg_1_0.goBootyContent = gohelper.findChild(arg_1_0.viewGO, "Left/#go_booty/#go_fold/Scroll/Viewport/Content")
	arg_1_0.goInfo = gohelper.findChild(arg_1_0.viewGO, "Left/goinfo")

	arg_1_0:setFoldVisible(true)

	arg_1_0.btn_handbook = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_handbook")
	arg_1_0.handbook_go_red = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_handbook/#go_red")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnContinue:AddClickListener(arg_2_0._onContinueClick, arg_2_0)
	arg_2_0._btnEnter:AddClickListener(arg_2_0._onEnterClick, arg_2_0)
	arg_2_0._btnabort:AddClickListener(arg_2_0._onAbortClick, arg_2_0)
	arg_2_0._btnachievement:AddClickListener(arg_2_0._onAchievementClick, arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._onRewardClick, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnOutInfoChange, arg_2_0._refreshView, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnFold, arg_2_0.onClickFold, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnCloseFold, arg_2_0.onClickCloseFold, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btn_handbook, arg_2_0.onClickBtnHandbook, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnContinue:RemoveClickListener()
	arg_3_0._btnEnter:RemoveClickListener()
	arg_3_0._btnabort:RemoveClickListener()
	arg_3_0._btnachievement:RemoveClickListener()
	arg_3_0._btnreward:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnOutInfoChange, arg_3_0._refreshView, arg_3_0)
	arg_3_0:removeClickCb(arg_3_0._btnFold)
	arg_3_0:removeClickCb(arg_3_0._btnCloseFold)
end

function var_0_0.onClickFold(arg_4_0)
	arg_4_0:setFoldVisible(not arg_4_0._foldVisible)
end

function var_0_0.onClickCloseFold(arg_5_0)
	arg_5_0:setFoldVisible(not arg_5_0._foldVisible)
end

function var_0_0.onClickBtnHandbook(arg_6_0)
	SurvivalStatHelper.instance:statBtnClick("onClickBtnHandbook", "SurvivalView")
	SurvivalHandbookController.instance:sendOpenSurvivalHandbookView()
end

function var_0_0.onOpen(arg_7_0)
	RedDotController.instance:addRedDot(arg_7_0._gored, RedDotEnum.DotNode.V2a8Survival, false, arg_7_0._refreshRed, arg_7_0)
	TaskDispatcher.runRepeat(arg_7_0.everySecondCall, arg_7_0, 0, -1)
	arg_7_0:_refreshView()
	RedDotController.instance:addRedDot(arg_7_0.handbook_go_red, RedDotEnum.DotNode.SurvivalHandbook)
end

function var_0_0._refreshRed(arg_8_0, arg_8_1)
	arg_8_1:defaultRefreshDot()

	local var_8_0 = arg_8_1.show

	gohelper.setActive(arg_8_0.goCanget, var_8_0)
	gohelper.setActive(arg_8_0.goNormal, not var_8_0)
end

function var_0_0.everySecondCall(arg_9_0)
	if arg_9_0._txtLimitTime then
		arg_9_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(VersionActivity3_1Enum.ActivityId.Survival)
	end
end

function var_0_0._refreshView(arg_10_0)
	local var_10_0 = SurvivalModel.instance:getOutSideInfo()

	gohelper.setActive(arg_10_0._btnabort, var_10_0.inWeek)
	gohelper.setActive(arg_10_0._btnContinue, var_10_0.inWeek)
	gohelper.setActive(arg_10_0._btnEnter, not var_10_0.inWeek)

	if var_10_0.inWeek then
		local var_10_1 = SurvivalShelterModel.instance:getWeekInfo()
		local var_10_2 = var_10_1 and var_10_1.difficulty or var_10_0.currMod
		local var_10_3 = var_10_1 and var_10_1.day or var_10_0.currDay
		local var_10_4 = lua_survival_hardness_mod.configDict[var_10_2]

		arg_10_0._txtDifficulty.text = var_10_4 and var_10_4.name
		arg_10_0._txtDay.text = formatLuaLang("versionactivity_1_2_114daydes", var_10_3)
	end

	arg_10_0:refreshEndBg()
	arg_10_0:refreshBooty()
end

function var_0_0.refreshEndBg(arg_11_0)
	if not arg_11_0.endPart then
		local var_11_0 = {
			view = arg_11_0
		}

		arg_11_0.endPart = MonoHelper.addNoUpdateLuaComOnceToGo(arg_11_0.viewGO, SurvivalEndPart, var_11_0)
	end

	arg_11_0.endPart:refreshView()
end

function var_0_0.refreshBooty(arg_12_0)
	gohelper.setActive(arg_12_0._gobooty, false)
end

function var_0_0.setFoldVisible(arg_13_0, arg_13_1)
	if arg_13_0._foldVisible == arg_13_1 then
		return
	end

	arg_13_0._foldVisible = arg_13_1

	gohelper.setActive(arg_13_0._goFold, arg_13_1)
	gohelper.setActive(arg_13_0._goImageFold, not arg_13_1)
	gohelper.setActive(arg_13_0._goImageUnFold, arg_13_1)
end

function var_0_0._onContinueClick(arg_14_0)
	SurvivalController.instance:enterShelterMap()
	SurvivalStatHelper.instance:statBtnClick("_onContinueClick", "SurvivalView")
end

function var_0_0._onEnterClick(arg_15_0)
	if not SurvivalModel.instance:getOutSideInfo() then
		return
	end

	arg_15_0:_enterSurvival()
	SurvivalStatHelper.instance:statBtnClick("_onEnterClick", "SurvivalView")
end

function var_0_0._enterSurvival(arg_16_0)
	if SurvivalModel.instance:getOutSideInfo():isFirstPlay() then
		local var_16_0 = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.StoryFirstEnter)
		local var_16_1

		var_16_1 = tonumber(var_16_0) or 0

		if var_16_1 > 0 and not StoryModel.instance:isStoryFinished(var_16_1) then
			StoryController.instance:playStory(var_16_1, nil, arg_16_0._firstEnterSurvival, arg_16_0)
		else
			arg_16_0:_firstEnterSurvival()
		end
	else
		local var_16_2 = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.StoryPassEnter)
		local var_16_3

		var_16_3 = tonumber(var_16_2) or 0

		if var_16_3 > 0 and not StoryModel.instance:isStoryFinished(var_16_3) then
			StoryController.instance:playStory(var_16_3, nil, arg_16_0._noFirstEnterSurvival, arg_16_0)
		else
			arg_16_0:_noFirstEnterSurvival()
		end
	end
end

function var_0_0._firstEnterSurvival(arg_17_0)
	SurvivalWeekRpc.instance:sendSurvivalStartWeekChooseDiff(SurvivalConst.FirstPlayDifficulty)
end

function var_0_0._noFirstEnterSurvival(arg_18_0)
	ViewMgr.instance:openView(ViewName.SurvivalHardView)
end

function var_0_0._onAbortClick(arg_19_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalGiveUpWeek, MsgBoxEnum.BoxType.Yes_No, arg_19_0._sendGiveUp, nil, nil, arg_19_0, nil, nil)
	SurvivalStatHelper.instance:statBtnClick("_onAbortClick", "SurvivalView")
end

function var_0_0._sendGiveUp(arg_20_0)
	SurvivalWeekRpc.instance:sendSurvivalGetWeekInfo(arg_20_0._onRecvWeekInfo, arg_20_0)
end

function var_0_0._onRecvWeekInfo(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	if arg_21_2 == 0 then
		SurvivalWeekRpc.instance:sendSurvivalAbandonWeek()
	end
end

function var_0_0._onAchievementClick(arg_22_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		local var_22_0 = ActivityConfig.instance:getActivityCo(VersionActivity3_1Enum.ActivityId.Survival).achievementJumpId

		JumpController.instance:jump(var_22_0)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
	end

	SurvivalStatHelper.instance:statBtnClick("_onAchievementClick", "SurvivalView")
end

function var_0_0._onRewardClick(arg_23_0)
	ViewMgr.instance:openView(ViewName.SurvivalShelterRewardView)
	SurvivalStatHelper.instance:statBtnClick("_onRewardClick", "SurvivalView")
end

function var_0_0.onClose(arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0.everySecondCall, arg_24_0)
end

return var_0_0
