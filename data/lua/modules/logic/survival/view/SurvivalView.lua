module("modules.logic.survival.view.SurvivalView", package.seeall)

local var_0_0 = class("SurvivalView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnContinue = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Continue")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Enter")
	arg_1_0._btnabort = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_abort")
	arg_1_0._btnachievement = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_achievement")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_reward")
	arg_1_0._btntalent = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_talent")
	arg_1_0._gotalentRed = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_talent/#go_red")
	arg_1_0._imagetalentskill = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/#btn_talent/#image_skill")
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
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnContinue:AddClickListener(arg_2_0._onContinueClick, arg_2_0)
	arg_2_0._btnEnter:AddClickListener(arg_2_0._onEnterClick, arg_2_0)
	arg_2_0._btnabort:AddClickListener(arg_2_0._onAbortClick, arg_2_0)
	arg_2_0._btnachievement:AddClickListener(arg_2_0._onAchievementClick, arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._onRewardClick, arg_2_0)
	arg_2_0._btntalent:AddClickListener(arg_2_0._onTalentClick, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnOutInfoChange, arg_2_0._refreshView, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnTalentGroupBoxUpdate, arg_2_0.updateTalentRed, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnFold, arg_2_0.onClickFold, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnCloseFold, arg_2_0.onClickCloseFold, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnContinue:RemoveClickListener()
	arg_3_0._btnEnter:RemoveClickListener()
	arg_3_0._btnabort:RemoveClickListener()
	arg_3_0._btnachievement:RemoveClickListener()
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0._btntalent:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnOutInfoChange, arg_3_0._refreshView, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnTalentGroupBoxUpdate, arg_3_0.updateTalentRed, arg_3_0)
	arg_3_0:removeClickCb(arg_3_0._btnFold)
	arg_3_0:removeClickCb(arg_3_0._btnCloseFold)
end

function var_0_0.onClickFold(arg_4_0)
	arg_4_0:setFoldVisible(not arg_4_0._foldVisible)
end

function var_0_0.onClickCloseFold(arg_5_0)
	arg_5_0:setFoldVisible(not arg_5_0._foldVisible)
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._imagetalentskill:LoadImage(ResUrl.getSurvivalTalentIcon("suit_01/icon_1"))
	RedDotController.instance:addRedDot(arg_6_0._gored, RedDotEnum.DotNode.V2a8Survival, false, arg_6_0._refreshRed, arg_6_0)
	TaskDispatcher.runRepeat(arg_6_0.everySecondCall, arg_6_0, 0, -1)
	arg_6_0:_refreshView()
end

function var_0_0._refreshRed(arg_7_0, arg_7_1)
	arg_7_1:defaultRefreshDot()

	local var_7_0 = arg_7_1.show

	gohelper.setActive(arg_7_0.goCanget, var_7_0)
	gohelper.setActive(arg_7_0.goNormal, not var_7_0)
end

function var_0_0.everySecondCall(arg_8_0)
	if arg_8_0._txtLimitTime then
		arg_8_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(VersionActivity2_8Enum.ActivityId.Survival)
	end
end

function var_0_0._refreshView(arg_9_0)
	local var_9_0 = SurvivalModel.instance:getOutSideInfo()

	gohelper.setActive(arg_9_0._btnabort, var_9_0.inWeek)
	gohelper.setActive(arg_9_0._btnContinue, var_9_0.inWeek)
	gohelper.setActive(arg_9_0._btnEnter, not var_9_0.inWeek)

	if var_9_0.inWeek then
		local var_9_1 = SurvivalShelterModel.instance:getWeekInfo()
		local var_9_2 = var_9_1 and var_9_1.difficulty or var_9_0.currMod
		local var_9_3 = var_9_1 and var_9_1.day or var_9_0.currDay
		local var_9_4 = lua_survival_hardness_mod.configDict[var_9_2]

		arg_9_0._txtDifficulty.text = var_9_4 and var_9_4.name
		arg_9_0._txtDay.text = formatLuaLang("versionactivity_1_2_114daydes", var_9_3)
	end

	arg_9_0:refreshEndBg()
	arg_9_0:refreshBooty()
	arg_9_0:updateTalentRed()
end

function var_0_0.refreshEndBg(arg_10_0)
	if not arg_10_0.endPart then
		local var_10_0 = {
			view = arg_10_0
		}

		arg_10_0.endPart = MonoHelper.addNoUpdateLuaComOnceToGo(arg_10_0.viewGO, SurvivalEndPart, var_10_0)
	end

	arg_10_0.endPart:refreshView()
end

function var_0_0.refreshBooty(arg_11_0)
	local var_11_0 = SurvivalModel.instance:getOutSideInfo()

	if var_11_0.inWeek then
		gohelper.setActive(arg_11_0._gobooty, false)

		return
	end

	local var_11_1 = var_11_0:getBootyList()
	local var_11_2 = #var_11_1 == 0

	gohelper.setActive(arg_11_0._gobooty, not var_11_2)

	if var_11_2 then
		return
	end

	gohelper.setActive(arg_11_0._gobooty, true)

	local var_11_3 = arg_11_0.viewContainer:getSetting().otherRes.itemRes
	local var_11_4 = arg_11_0.goBootyContent

	for iter_11_0 = 1, math.max(#var_11_1, #arg_11_0.bootyList) do
		local var_11_5 = arg_11_0.bootyList[iter_11_0]

		if not var_11_5 then
			local var_11_6 = arg_11_0.viewContainer:getResInst(var_11_3, var_11_4, tostring(iter_11_0))

			var_11_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_6, SurvivalBagItem)

			var_11_5:setClickCallback(arg_11_0.onClickBootyItem, arg_11_0)

			arg_11_0.bootyList[iter_11_0] = var_11_5
		end

		var_11_5:updateMo(var_11_1[iter_11_0])
		var_11_5:setShowNum(false)
		var_11_5:setItemSize(100, 100)
	end
end

function var_0_0.updateTalentRed(arg_12_0)
	local var_12_0 = SurvivalModel.instance:getOutSideInfo()

	if not var_12_0 then
		return
	end

	gohelper.setActive(arg_12_0._gotalentRed, not var_12_0.talentBox:isEquipAll())
end

function var_0_0.onClickBootyItem(arg_13_0, arg_13_1)
	ViewMgr.instance:openView(ViewName.SurvivalItemInfoView, {
		itemMo = arg_13_1._mo,
		goPanel = arg_13_0.goInfo
	})
end

function var_0_0.setFoldVisible(arg_14_0, arg_14_1)
	if arg_14_0._foldVisible == arg_14_1 then
		return
	end

	arg_14_0._foldVisible = arg_14_1

	gohelper.setActive(arg_14_0._goFold, arg_14_1)
	gohelper.setActive(arg_14_0._goImageFold, not arg_14_1)
	gohelper.setActive(arg_14_0._goImageUnFold, arg_14_1)
end

function var_0_0._onContinueClick(arg_15_0)
	SurvivalController.instance:enterShelterMap()
	SurvivalStatHelper.instance:statBtnClick("_onContinueClick", "SurvivalView")
end

function var_0_0._onEnterClick(arg_16_0)
	local var_16_0 = SurvivalModel.instance:getOutSideInfo()

	if not var_16_0 then
		return
	end

	if not var_16_0.talentBox:isEquipAll() then
		GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalHaveNoEquipTalent, MsgBoxEnum.BoxType.Yes_No, arg_16_0._enterSurvival, nil, nil, arg_16_0, nil, nil)
	else
		arg_16_0:_enterSurvival()
	end

	SurvivalStatHelper.instance:statBtnClick("_onEnterClick", "SurvivalView")
end

function var_0_0._enterSurvival(arg_17_0)
	if SurvivalModel.instance:getOutSideInfo():isFirstPlay() then
		SurvivalWeekRpc.instance:sendSurvivalStartWeekChooseDiff(SurvivalEnum.FirstPlayDifficulty)
	else
		ViewMgr.instance:openView(ViewName.SurvivalHardView)
	end
end

function var_0_0._onAbortClick(arg_18_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalGiveUpWeek, MsgBoxEnum.BoxType.Yes_No, arg_18_0._sendGiveUp, nil, nil, arg_18_0, nil, nil)
	SurvivalStatHelper.instance:statBtnClick("_onAbortClick", "SurvivalView")
end

function var_0_0._sendGiveUp(arg_19_0)
	SurvivalWeekRpc.instance:sendSurvivalGetWeekInfo(arg_19_0._onRecvWeekInfo, arg_19_0)
end

function var_0_0._onRecvWeekInfo(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_2 == 0 then
		SurvivalWeekRpc.instance:sendSurvivalAbandonWeek()
	end
end

function var_0_0._onAchievementClick(arg_21_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		local var_21_0 = ActivityConfig.instance:getActivityCo(VersionActivity2_8Enum.ActivityId.Survival).achievementJumpId

		JumpController.instance:jump(var_21_0)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
	end

	SurvivalStatHelper.instance:statBtnClick("_onAchievementClick", "SurvivalView")
end

function var_0_0._onRewardClick(arg_22_0)
	ViewMgr.instance:openView(ViewName.SurvivalShelterRewardView)
	SurvivalStatHelper.instance:statBtnClick("_onRewardClick", "SurvivalView")
end

function var_0_0._onTalentClick(arg_23_0)
	ViewMgr.instance:openView(ViewName.SurvivalTalentView)
	SurvivalStatHelper.instance:statBtnClick("_onTalentClick", "SurvivalView")
end

function var_0_0.onClose(arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0.everySecondCall, arg_24_0)
end

return var_0_0
