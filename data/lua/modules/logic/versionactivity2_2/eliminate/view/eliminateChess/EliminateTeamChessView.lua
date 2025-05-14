module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateTeamChessView", package.seeall)

local var_0_0 = class("EliminateTeamChessView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._viewGO = arg_1_0.viewGO
	arg_1_0.viewGO = gohelper.findChild(arg_1_0._viewGO, "#go_cameraMain/Middle/#go_teamchess")
	arg_1_0._gostrongHolds = gohelper.findChild(arg_1_0.viewGO, "#go_strongHolds")
	arg_1_0._gostrongHold = gohelper.findChild(arg_1_0.viewGO, "#go_strongHolds/#go_strongHold")
	arg_1_0._goinfo = gohelper.findChild(arg_1_0.viewGO, "#go_strongHolds/#go_strongHold/#go_info")
	arg_1_0._imageslotBGColor = gohelper.findChildImage(arg_1_0.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#image_slotBGColor")
	arg_1_0._simageslotBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#simage_slotBG")
	arg_1_0._imageInfoTextBG = gohelper.findChildImage(arg_1_0.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#image_InfoTextBG")
	arg_1_0._txtInfo = gohelper.findChildText(arg_1_0.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#image_InfoTextBG/#scroll_ver/viewport/#txt_Info")
	arg_1_0._goEnemyPower = gohelper.findChild(arg_1_0.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#go_EnemyPower")
	arg_1_0._imageEnemyPower = gohelper.findChildImage(arg_1_0.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#go_EnemyPower/#image_EnemyPower")
	arg_1_0._imageEnemyPower2 = gohelper.findChildImage(arg_1_0.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#go_EnemyPower/#image_EnemyPower2")
	arg_1_0._txtEnemyPower = gohelper.findChildText(arg_1_0.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#go_EnemyPower/#txt_Enemy_Power")
	arg_1_0._txtEnemyPower1 = gohelper.findChildText(arg_1_0.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#go_EnemyPower/#txt_Enemy_Power1")
	arg_1_0._goPlayerPower = gohelper.findChild(arg_1_0.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#go_PlayerPower")
	arg_1_0._imagePlayerPower = gohelper.findChildImage(arg_1_0.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#go_PlayerPower/#image_PlayerPower")
	arg_1_0._imagePlayerPower2 = gohelper.findChildImage(arg_1_0.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#go_PlayerPower/#image_PlayerPower2")
	arg_1_0._txtPlayerPower = gohelper.findChildText(arg_1_0.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#go_PlayerPower/#txt_Player_Power")
	arg_1_0._txtPlayerPower1 = gohelper.findChildText(arg_1_0.viewGO, "#go_strongHolds/#go_strongHold/#go_info/#go_PlayerPower/#txt_Player_Power1")
	arg_1_0._goEnemy = gohelper.findChild(arg_1_0.viewGO, "#go_strongHolds/#go_strongHold/#go_Enemy")
	arg_1_0._goEnemyWin = gohelper.findChild(arg_1_0.viewGO, "#go_strongHolds/#go_strongHold/#go_EnemyWin")
	arg_1_0._goPlayer = gohelper.findChild(arg_1_0.viewGO, "#go_strongHolds/#go_strongHold/#go_Player")
	arg_1_0._goPlayerWin = gohelper.findChild(arg_1_0.viewGO, "#go_strongHolds/#go_strongHold/#go_PlayerWin")
	arg_1_0._goLine4 = gohelper.findChild(arg_1_0.viewGO, "#go_strongHolds/#go_strongHold/#go_Line4")
	arg_1_0._goLine6 = gohelper.findChild(arg_1_0.viewGO, "#go_strongHolds/#go_strongHold/#go_Line6")
	arg_1_0._gopower = gohelper.findChild(arg_1_0.viewGO, "#go_strongHolds/#go_power")
	arg_1_0._imagechessPower = gohelper.findChildImage(arg_1_0.viewGO, "#go_strongHolds/#go_power/#image_chessPower")
	arg_1_0._txtchessPower = gohelper.findChildText(arg_1_0.viewGO, "#go_strongHolds/#go_power/#image_chessPower/#txt_chessPower")
	arg_1_0._goHP = gohelper.findChild(arg_1_0.viewGO, "#go_strongHolds/#go_HP")
	arg_1_0._btnresult = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_result")
	arg_1_0._goreslutvx = gohelper.findChild(arg_1_0.viewGO, "#btn_result/#go_reslut_vx")
	arg_1_0._goreslutvxloop = gohelper.findChild(arg_1_0.viewGO, "#btn_result/#go_reslut_vx_loop")
	arg_1_0._goSlot = gohelper.findChild(arg_1_0.viewGO, "Bottom/#go_Slot")
	arg_1_0._goresources = gohelper.findChild(arg_1_0.viewGO, "Bottom/#go_resources")
	arg_1_0._goresource = gohelper.findChild(arg_1_0.viewGO, "Bottom/#go_resources/#go_resource")
	arg_1_0._imageQuality = gohelper.findChildImage(arg_1_0.viewGO, "Bottom/#go_resources/#go_resource/#image_Quality")
	arg_1_0._txtResourceNum = gohelper.findChildText(arg_1_0.viewGO, "Bottom/#go_resources/#go_resource/#image_Quality/#txt_ResourceNum")
	arg_1_0._goResourceTips = gohelper.findChild(arg_1_0.viewGO, "Bottom/#go_ResourceTips")
	arg_1_0._txtopt = gohelper.findChildText(arg_1_0.viewGO, "Bottom/#go_ResourceTips/#txt_opt")
	arg_1_0._goaddResources = gohelper.findChild(arg_1_0.viewGO, "Bottom/#go_ResourceTips/#go_addResources")
	arg_1_0._goaddResource = gohelper.findChild(arg_1_0.viewGO, "Bottom/#go_ResourceTips/#go_addResources/#go_addResource")
	arg_1_0._btnmask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_mask")
	arg_1_0._gomask = gohelper.findChild(arg_1_0.viewGO, "#go_mask")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnresult:AddClickListener(arg_2_0._btnresultOnClick, arg_2_0)
	arg_2_0._btnmask:AddClickListener(arg_2_0._btnmaskOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnresult:RemoveClickListener()
	arg_3_0._btnmask:RemoveClickListener()
end

function var_0_0._btnmaskOnClick(arg_4_0)
	arg_4_0:hideSoliderChessTip()
end

function var_0_0._btnresultOnClick(arg_5_0)
	if not arg_5_0._canClickResult then
		return
	end

	arg_5_0._canClickResult = false

	EliminateTeamChessController.instance:sendWarChessRoundEndRequest(function()
		arg_5_0:refreshViewByRoundState()

		arg_5_0._canClickResult = true
	end, arg_5_0)
end

function var_0_0.setTipViewParent(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._btnmask.transform:SetParent(arg_7_1.transform)
	EliminateTeamChessModel.instance:setTipViewParent(arg_7_1)

	arg_7_0._powerParent = gohelper.create2d(arg_7_1, "powerParent")

	gohelper.setAsFirstSibling(arg_7_0._powerParent)

	arg_7_0._powerParentTr = arg_7_0._powerParent.transform
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._soliderTipView = nil

	arg_8_0:hideSoliderChessTip()

	arg_8_0._teamChessViewAni = arg_8_0._viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(arg_8_0._gostrongHolds, true)
	gohelper.setActive(arg_8_0._gostrongHold, false)
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.TeamChessWarInfoInit, arg_10_0.initInfo, arg_10_0)
	arg_10_0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.EliminateRoundStateChangeEnd, arg_10_0.updateViewStateEnd, arg_10_0)
	arg_10_0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.EliminateRoundStateChange, arg_10_0.updateViewState, arg_10_0)
	arg_10_0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.TeamChessViewWatchView, arg_10_0.updateTeamChessViewWatchState, arg_10_0)
	arg_10_0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.TeamChessSelectEffectEnd, arg_10_0.onTeamChessSkillRelease, arg_10_0)
	arg_10_0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.TeamChessItemBeginModelUpdated, arg_10_0.teamChessItemDragBegin, arg_10_0)
	arg_10_0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.TeamChessItemDragModelUpdated, arg_10_0.teamChessItemDrag, arg_10_0)
	arg_10_0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.TeamChessItemDragEndModelUpdated, arg_10_0.teamChessItemDragEnd, arg_10_0)
	arg_10_0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.AddStrongholdChess, arg_10_0.addStrongholdChess, arg_10_0)
	arg_10_0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.TeamChessPowerChange, arg_10_0.teamChessPowerChange, arg_10_0)
	arg_10_0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.StrongHoldPowerChange, arg_10_0.strongHoldPowerChange, arg_10_0)
	arg_10_0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.ResourceDataChange, arg_10_0.resourceDataChange, arg_10_0)
	arg_10_0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.TeamChessOnFlowEnd, arg_10_0.flowEnd, arg_10_0)
	arg_10_0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.RemoveStrongholdChess, arg_10_0.removeStrongholdChess, arg_10_0)
	arg_10_0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.StrongHoldSettle, arg_10_0.strongHoldSettle, arg_10_0)
	arg_10_0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.SoliderChessModelClick, arg_10_0.soliderChessModelClick, arg_10_0)
	arg_10_0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.ShowChessView, arg_10_0.showSoliderChessTip, arg_10_0)
	arg_10_0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.StrongHoldPerformReduction, arg_10_0.strongHoldPerformReduction, arg_10_0)
	arg_10_0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.TeamChessUpdateActiveMoveState, arg_10_0.teamChessUpdateActiveMoveState, arg_10_0)
	arg_10_0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.TeamChessGrowUpSkillChange, arg_10_0.teamChessGrowUpValueChange, arg_10_0)
	arg_10_0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.TeamChessOnFlowStart, arg_10_0.teamChessOnFlowStart, arg_10_0)
	arg_10_0:initInfo()
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onOpenFinish(arg_12_0)
	return
end

function var_0_0.initInfo(arg_13_0)
	arg_13_0._canClickResult = true

	arg_13_0:initSlot()
	arg_13_0:initStrongHold()
	arg_13_0:initResource()
	arg_13_0:refreshViewByRoundState()
end

function var_0_0.updateViewState(arg_14_0)
	local var_14_0 = EliminateLevelModel.instance:getCurRoundType() == EliminateEnum.RoundType.TeamChess

	if not var_14_0 and not gohelper.isNil(arg_14_0._powerParent) then
		gohelper.setActive(arg_14_0._powerParent, var_14_0)
	end

	TeamChessUnitEntityMgr.instance:setAllEntityCanClick(var_14_0)
	TeamChessUnitEntityMgr.instance:setAllEntityCanDrag(var_14_0)
end

function var_0_0.updateViewStateEnd(arg_15_0)
	local var_15_0 = EliminateLevelModel.instance:getCurRoundType() == EliminateEnum.RoundType.TeamChess

	if var_15_0 then
		arg_15_0:updateResourceDataChange()
		arg_15_0:refreshAndSortSlot()

		if not gohelper.isNil(arg_15_0._powerParent) then
			gohelper.setActive(arg_15_0._powerParent, true)
		end

		arg_15_0:refreshViewByRoundState()
		arg_15_0:refreshActiveMoveState()
		arg_15_0:refreshTotalScoreState()

		for iter_15_0 = 1, #arg_15_0._strongHoldItems do
			arg_15_0._strongHoldItems[iter_15_0]:refreshAni(true)
		end
	end

	if var_15_0 and arg_15_0._teamChessViewAni then
		arg_15_0._teamChessViewAni:Play("open")
		TaskDispatcher.runDelay(arg_15_0.refreshViewActive, arg_15_0, 0.33)
	end

	EliminateTeamChessController.instance:setStartStepFlow(var_15_0)
end

function var_0_0.refreshViewActive(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0.refreshViewActive, arg_16_0)
	EliminateTeamChessController.instance:startSeqStepFlow()
end

function var_0_0.updateInfo(arg_17_0)
	return
end

function var_0_0.initSlot(arg_18_0)
	arg_18_0._slotList = arg_18_0:getUserDataTb_()

	local var_18_0 = EliminateTeamChessModel.instance:getSlotIds()
	local var_18_1 = arg_18_0.viewContainer:getSetting().otherRes[1]

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		local var_18_2 = arg_18_0:getResInst(var_18_1, arg_18_0._goSlot)
		local var_18_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_18_2, EliminateTeamChessItem)

		table.insert(arg_18_0._slotList, var_18_3)
		var_18_3:setSoliderId(iter_18_1)
	end

	arg_18_0:refreshAndSortSlot()
end

function var_0_0.refreshAndSortSlot(arg_19_0)
	if arg_19_0._slotList == nil or #arg_19_0._slotList < 1 then
		return
	end

	for iter_19_0 = 1, #arg_19_0._slotList do
		local var_19_0 = arg_19_0._slotList[iter_19_0]

		var_19_0:refreshView()
		var_19_0:setChildIndex(iter_19_0 - 1)
	end
end

function var_0_0.initStrongHold(arg_20_0)
	local var_20_0 = EliminateTeamChessModel.instance:getStrongholds()

	arg_20_0._strongHoldItems = arg_20_0:getUserDataTb_()

	local var_20_1 = #var_20_0

	for iter_20_0 = 1, var_20_1 do
		local var_20_2 = var_20_0[iter_20_0]
		local var_20_3 = var_20_2.id
		local var_20_4 = gohelper.clone(arg_20_0._gostrongHold, arg_20_0._gostrongHolds, var_20_3)
		local var_20_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_20_4, EliminateStrongHoldItem)

		var_20_5:initData(var_20_2, iter_20_0, var_20_1)

		local var_20_6 = var_20_2:getStrongholdConfig()

		if var_20_6 then
			local var_20_7 = arg_20_0:_getResPathByCapacity(var_20_6.friendCapacity)
			local var_20_8 = arg_20_0:getResInst(var_20_7, var_20_5._goPlayer)
			local var_20_9 = arg_20_0:_getResPathByCapacity(var_20_6.enemyCapacity)
			local var_20_10 = arg_20_0:getResInst(var_20_9, var_20_5._goEnemy)

			var_20_5:initStrongHoldChess(var_20_8, var_20_10, arg_20_0._gopower, arg_20_0._goHP)
		end

		gohelper.setActive(var_20_4, true)

		arg_20_0._strongHoldItems[#arg_20_0._strongHoldItems + 1] = var_20_5
	end

	ZProj.UGUIHelper.RebuildLayout(arg_20_0._gostrongHolds.transform)

	for iter_20_1, iter_20_2 in ipairs(arg_20_0._strongHoldItems) do
		if iter_20_2 then
			iter_20_2:setPowerTrParent(arg_20_0._powerParentTr)
		end
	end
end

function var_0_0.initResource(arg_21_0)
	local var_21_0 = EliminateTeamChessEnum.ResourceType

	arg_21_0._resourceItem = arg_21_0:getUserDataTb_()

	for iter_21_0, iter_21_1 in pairs(var_21_0) do
		local var_21_1 = gohelper.clone(arg_21_0._goresource, arg_21_0._goresources, iter_21_0)
		local var_21_2 = gohelper.findChildImage(var_21_1, "#image_Quality")
		local var_21_3 = gohelper.findChildText(var_21_1, "#image_Quality/#txt_ResourceNum")
		local var_21_4 = var_21_1:GetComponent(typeof(UnityEngine.Animator))
		local var_21_5 = EliminateTeamChessModel.instance:getResourceNumber(iter_21_0)
		local var_21_6 = var_21_5 and var_21_5 or 0

		UISpriteSetMgr.instance:setV2a2EliminateSprite(var_21_2, EliminateTeamChessEnum.ResourceTypeToImagePath[iter_21_0], false)
		gohelper.setActive(var_21_1, true)

		var_21_3.text = var_21_6
		arg_21_0._resourceItem[iter_21_0] = {
			item = var_21_1,
			resourceImage = var_21_2,
			resourceNumberText = var_21_3,
			ani = var_21_4
		}
	end
end

function var_0_0._getResPathByCapacity(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.viewContainer:getSetting().otherRes
	local var_22_1 = var_22_0[2]

	if arg_22_1 > 4 and arg_22_1 <= 6 then
		var_22_1 = var_22_0[3]
	end

	if arg_22_1 > 6 then
		var_22_1 = var_22_0[7]
	end

	return var_22_1
end

function var_0_0.teamChessItemDragBegin(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = TeamChessUnitEntityMgr.instance:getEmptyEntity(nil, arg_23_1)
end

function var_0_0.teamChessItemDrag(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5)
	local var_24_0 = arg_24_0:_checkStrongHoldInRect(arg_24_4, arg_24_5)
	local var_24_1 = false

	if var_24_0 and arg_24_3 and var_24_0 == arg_24_3 then
		-- block empty
	end

	arg_24_0:setStrongHoldSelect(arg_24_1, var_24_0)

	local var_24_2 = TeamChessUnitEntityMgr.instance:getEmptyEntity(nil, arg_24_1)

	if var_24_2 then
		if arg_24_2 == nil then
			if var_24_0 then
				var_24_1 = not EliminateTeamChessModel.instance:strongHoldIsFull(var_24_0)
			end

			arg_24_0:updateViewPositionByEntity(arg_24_1, EliminateTeamChessEnum.ChessTipType.showDragTip, var_24_2, nil, var_24_1)
		end

		local var_24_3 = (var_24_0 ~= nil or arg_24_3 ~= nil) and EliminateTeamChessEnum.ModeType.Outline or EliminateTeamChessEnum.ModeType.Normal

		var_24_2:setShowModeType(var_24_3)
	end

	arg_24_0:setViewCanvasGroupActive(var_24_0 ~= nil)
end

function var_0_0.teamChessItemDragEnd(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5)
	local var_25_0 = arg_25_0:_checkStrongHoldInRect(arg_25_4, arg_25_5)

	if var_25_0 and arg_25_3 and var_25_0 == arg_25_3 then
		var_25_0 = nil
	end

	if var_25_0 ~= nil and (EliminateTeamChessModel.instance:isCanPlaceByStrongHoldRule(var_25_0, arg_25_1) or arg_25_2 ~= nil) then
		EliminateTeamChessController.instance:createPlaceSkill(arg_25_1, arg_25_2, var_25_0)

		arg_25_0._placeSkillReleaseSuccess = EliminateTeamChessController.instance:checkAndReleasePlaceSkill()

		if not arg_25_0._placeSkillReleaseSuccess then
			EliminateTeamChessController.instance:addTempChessAndPlace(arg_25_1, arg_25_2, var_25_0)

			local var_25_1 = arg_25_0._gostrongHolds.transform
			local var_25_2 = recthelper.getHeight(var_25_1)
			local var_25_3 = recthelper.getWidth(var_25_1)

			EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.TeamChessSelectEffectBegin, var_25_3, var_25_2)
		end
	end

	local var_25_4 = TeamChessUnitEntityMgr.instance:getEmptyEntity(nil, arg_25_1)

	if var_25_4 then
		var_25_4:setShowModeType(EliminateTeamChessEnum.ModeType.Normal)
	end

	arg_25_0:teamChessUpdateActiveMoveState(arg_25_2)
	arg_25_0:setStrongHoldSelect(arg_25_1, nil)
	arg_25_0:hideSoliderChessTip()
end

function var_0_0._checkStrongHoldInRect(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_0._strongHoldItems == nil then
		return nil
	end

	local var_26_0

	for iter_26_0, iter_26_1 in pairs(arg_26_0._strongHoldItems) do
		if iter_26_1:checkInPlayerChessRect(arg_26_1, arg_26_2) and iter_26_1._data then
			var_26_0 = iter_26_1._data.id

			break
		end
	end

	return var_26_0
end

function var_0_0.setStrongHoldSelect(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_0._strongHoldItems == nil then
		return
	end

	for iter_27_0 = 1, #arg_27_0._strongHoldItems do
		arg_27_0._strongHoldItems[iter_27_0]:setStrongHoldSelect(arg_27_1, arg_27_2)
	end
end

function var_0_0.addStrongholdChess(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	if arg_28_0._strongHoldItems == nil then
		return
	end

	for iter_28_0 = 1, #arg_28_0._strongHoldItems do
		arg_28_0._strongHoldItems[iter_28_0]:addStrongholdChess(arg_28_1, arg_28_2, arg_28_3)
	end

	arg_28_0:refreshTotalScoreState()
end

function var_0_0.removeStrongholdChess(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	if arg_29_0._strongHoldItems == nil then
		return
	end

	for iter_29_0 = 1, #arg_29_0._strongHoldItems do
		arg_29_0._strongHoldItems[iter_29_0]:removeStrongholdChess(arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	end

	arg_29_0:refreshTotalScoreState()
end

function var_0_0.strongHoldSettle(arg_30_0, arg_30_1)
	if arg_30_0._strongHoldItems == nil then
		return
	end

	for iter_30_0 = 1, #arg_30_0._strongHoldItems do
		arg_30_0._strongHoldItems[iter_30_0]:strongHoldSettle(arg_30_1)
	end
end

function var_0_0.strongHoldPerformReduction(arg_31_0)
	if arg_31_0._strongHoldItems == nil then
		return
	end

	for iter_31_0 = 1, #arg_31_0._strongHoldItems do
		arg_31_0._strongHoldItems[iter_31_0]:strongHoldSettleResetShow()
	end
end

function var_0_0.teamChessUpdateActiveMoveState(arg_32_0, arg_32_1)
	if arg_32_0._strongHoldItems == nil then
		return
	end

	for iter_32_0 = 1, #arg_32_0._strongHoldItems do
		arg_32_0._strongHoldItems[iter_32_0]:teamChessUpdateActiveMoveState(arg_32_1)
	end
end

function var_0_0.refreshActiveMoveState(arg_33_0)
	TeamChessUnitEntityMgr.instance:refreshShowModeStateByTeamType(EliminateTeamChessEnum.TeamChessTeamType.player)
end

function var_0_0.teamChessPowerChange(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_0._strongHoldItems == nil then
		return
	end

	for iter_34_0 = 1, #arg_34_0._strongHoldItems do
		arg_34_0._strongHoldItems[iter_34_0]:teamChessPowerChange(arg_34_1, arg_34_2)
	end
end

function var_0_0.teamChessGrowUpValueChange(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	if arg_35_0._strongHoldItems == nil then
		return
	end

	for iter_35_0 = 1, #arg_35_0._strongHoldItems do
		arg_35_0._strongHoldItems[iter_35_0]:teamChessGrowUpValueChange(arg_35_1, arg_35_2, arg_35_3)
	end
end

function var_0_0.strongHoldPowerChange(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	if arg_36_0._strongHoldItems == nil then
		return
	end

	for iter_36_0 = 1, #arg_36_0._strongHoldItems do
		arg_36_0._strongHoldItems[iter_36_0]:strongHoldPowerChange(arg_36_1, arg_36_2, arg_36_3)
	end

	arg_36_0:refreshTotalScoreState()
end

function var_0_0.resourceDataChange(arg_37_0, arg_37_1)
	for iter_37_0, iter_37_1 in pairs(arg_37_1) do
		if not arg_37_0._resourceItem or not arg_37_0._resourceItem[iter_37_0] then
			return
		end
	end

	arg_37_0:showAddResourceView(arg_37_0.updateResourceDataChange, arg_37_0, arg_37_1)
	arg_37_0:refreshAndSortSlot()
	arg_37_0:refreshTotalScoreState()
end

function var_0_0.showAddResourceView(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = tabletool.len(arg_38_3)
	local var_38_1 = 1

	if arg_38_0._addResourceItem == nil then
		arg_38_0._addResourceItem = arg_38_0:getUserDataTb_()
	end

	for iter_38_0, iter_38_1 in pairs(arg_38_3) do
		arg_38_0._txtopt.text = iter_38_1 > 0 and "＋" or "－"

		local var_38_2 = arg_38_0._addResourceItem[var_38_1]

		if var_38_2 == nil then
			var_38_2 = gohelper.clone(arg_38_0._goaddResource, arg_38_0._goaddResources, iter_38_0)

			local var_38_3 = gohelper.findChildImage(var_38_2, "#image_Quality")
			local var_38_4 = gohelper.findChildText(var_38_2, "#image_Quality/#txt_ResourceNum")

			UISpriteSetMgr.instance:setV2a2EliminateSprite(var_38_3, EliminateTeamChessEnum.ResourceTypeToImagePath[iter_38_0], false)

			var_38_4.text = math.abs(iter_38_1 and iter_38_1 or 0)

			gohelper.setActive(var_38_2, true)
			table.insert(arg_38_0._addResourceItem, {
				item = var_38_2,
				resourceImage = var_38_3,
				resourceNumberText = var_38_4
			})
		elseif var_38_2.resourceImage and var_38_2.resourceNumberText then
			UISpriteSetMgr.instance:setV2a2EliminateSprite(var_38_2.resourceImage, EliminateTeamChessEnum.ResourceTypeToImagePath[iter_38_0], false)

			var_38_2.resourceNumberText.text = math.abs(iter_38_1 and iter_38_1 or 0)

			gohelper.setActive(var_38_2.item, true)
		end

		var_38_1 = var_38_1 + 1
	end

	gohelper.setActive(arg_38_0._goResourceTips, true)
	TaskDispatcher.runDelay(function()
		gohelper.setActive(arg_38_0._goResourceTips, false)

		for iter_39_0 = 1, #arg_38_0._addResourceItem do
			gohelper.setActive(arg_38_0._addResourceItem[iter_39_0].item, false)
		end

		if arg_38_1 then
			arg_38_1(arg_38_2, arg_38_3)
		end
	end, nil, EliminateTeamChessEnum.addResourceTipTime)
end

function var_0_0.updateResourceDataChange(arg_40_0, arg_40_1)
	if arg_40_0._resourceItem == nil then
		return
	end

	if arg_40_1 ~= nil then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_sources_lit)
	end

	for iter_40_0, iter_40_1 in pairs(arg_40_0._resourceItem) do
		local var_40_0 = EliminateTeamChessModel.instance:getResourceNumber(iter_40_0)

		if iter_40_1.resourceNumberText then
			iter_40_1.resourceNumberText.text = var_40_0
		end
	end

	if arg_40_1 then
		for iter_40_2, iter_40_3 in pairs(arg_40_1) do
			local var_40_1 = arg_40_0._resourceItem[iter_40_2]

			if var_40_1 and var_40_1.ani then
				var_40_1.ani:Play("add", 0, 0)
			end
		end
	end
end

function var_0_0.showSoliderChessTip(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4, arg_41_5, arg_41_6)
	if arg_41_0._soliderTipView == nil then
		local var_41_0 = arg_41_0.viewContainer:getSetting().otherRes[6]
		local var_41_1 = arg_41_0:getResInst(var_41_0, arg_41_0._btnmask.gameObject)

		arg_41_0._soliderTipView = MonoHelper.addNoUpdateLuaComOnceToGo(var_41_1, EliminateChessTipView)

		arg_41_0._soliderTipView:setSellCb(arg_41_0.hideSoliderChessTip, arg_41_0)
	end

	arg_41_0._soliderTipView:setChessUidAndStrongHoldId(arg_41_2, arg_41_3)
	arg_41_0._soliderTipView:setSoliderIdAndShowType(arg_41_1, arg_41_4)

	if arg_41_0._soliderTipView then
		arg_41_0._soliderTipView:updateViewPositionByEntity(arg_41_5, arg_41_6)
	end

	gohelper.setActive(arg_41_0._btnmask, true)
end

function var_0_0.updateViewPositionByEntity(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4, arg_42_5)
	if arg_42_0._soliderTipView == nil or not arg_42_0._btnmask.gameObject.activeSelf then
		arg_42_0:showSoliderChessTip(arg_42_1, nil, nil, arg_42_2, arg_42_3, arg_42_4)
	end

	if arg_42_0._soliderTipView then
		arg_42_0._soliderTipView:updateViewPositionByEntity(arg_42_3, arg_42_4, arg_42_5)
	end
end

function var_0_0.setViewCanvasGroupActive(arg_43_0, arg_43_1)
	if arg_43_0._soliderTipView then
		arg_43_0._soliderTipView:setViewActive(arg_43_1)
	end
end

function var_0_0.hideSoliderChessTip(arg_44_0)
	if arg_44_0._soliderTipView then
		arg_44_0._soliderTipView:hideView()
	end

	gohelper.setActive(arg_44_0._btnmask, false)
end

function var_0_0.refreshViewByRoundState(arg_45_0)
	local var_45_0 = EliminateTeamChessModel.instance:getCurTeamRoundStepState()

	gohelper.setActive(arg_45_0._goSlot, var_45_0 == EliminateTeamChessEnum.TeamChessRoundType.player)
	gohelper.setActive(arg_45_0._goresources, var_45_0 == EliminateTeamChessEnum.TeamChessRoundType.player)
	gohelper.setActive(arg_45_0._btnresult, var_45_0 == EliminateTeamChessEnum.TeamChessRoundType.player)

	if arg_45_0._strongHoldItems == nil then
		return
	end

	for iter_45_0 = 1, #arg_45_0._strongHoldItems do
		arg_45_0._strongHoldItems[iter_45_0]:refreshViewByRoundState(var_45_0)
	end
end

function var_0_0.updateTeamChessViewWatchState(arg_46_0, arg_46_1)
	gohelper.setActive(arg_46_0._goSlot, not arg_46_1)
	gohelper.setActive(arg_46_0._goresources, not arg_46_1)
	gohelper.setActive(arg_46_0._btnresult, not arg_46_1)

	if not gohelper.isNil(arg_46_0._powerParent) then
		gohelper.setActive(arg_46_0._powerParent, arg_46_1)
	end

	if not arg_46_1 then
		arg_46_0:hideSoliderChessTip()
	end

	for iter_46_0 = 1, #arg_46_0._strongHoldItems do
		arg_46_0._strongHoldItems[iter_46_0]:refreshAni(arg_46_1)
	end
end

function var_0_0.soliderChessModelClick(arg_47_0, arg_47_1, arg_47_2, arg_47_3, arg_47_4, arg_47_5, arg_47_6)
	if arg_47_0._placeSkillReleaseSuccess == nil or arg_47_0._placeSkillReleaseSuccess then
		arg_47_0:showSoliderChessTip(arg_47_1, arg_47_2, arg_47_3, arg_47_4, arg_47_5, arg_47_6)

		return
	end

	local var_47_0 = EliminateTeamChessController.instance:getPlaceSkill()

	if var_47_0 and var_47_0:setSelectSoliderId(arg_47_2) then
		arg_47_0._placeSkillReleaseSuccess = EliminateTeamChessController.instance:checkAndReleasePlaceSkill()
	end
end

function var_0_0.onTeamChessSkillRelease(arg_48_0)
	arg_48_0._placeSkillReleaseSuccess = nil
end

function var_0_0.flowEnd(arg_49_0)
	local var_49_0 = EliminateLevelModel.instance:getLevelId()
	local var_49_1 = EliminateTeamChessModel.instance:getAllPlayerSoliderCount()
	local var_49_2 = string.format("%s_%s", var_49_0, var_49_1)

	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.TeamChessRoundBeginAndPlayerSoliderCount, var_49_2)
	arg_49_0:setClickMaskState(false)
end

function var_0_0.teamChessOnFlowStart(arg_50_0)
	arg_50_0:setClickMaskState(true)
end

function var_0_0.setClickMaskState(arg_51_0, arg_51_1)
	if EliminateTeamChessModel.instance:getWarFightResult() ~= nil then
		return
	end

	TeamChessUnitEntityMgr.instance:setAllEntityCanClick(not arg_51_1)
	TeamChessUnitEntityMgr.instance:setAllEntityCanDrag(not arg_51_1)
	gohelper.setActive(arg_51_0._gomask.gameObject, arg_51_1)
end

function var_0_0.refreshTotalScoreState(arg_52_0)
	if EliminateTeamChessModel.instance:getCurTeamRoundStepState() == EliminateTeamChessEnum.TeamChessRoundType.player then
		local var_52_0 = false

		if not EliminateTeamChessModel.instance:allStrongHoldIsIsFull() then
			local var_52_1 = EliminateTeamChessModel.instance:haveEnoughResource()
			local var_52_2 = EliminateTeamChessModel.instance:canReleaseSkillAddResource()

			logNormal("haveEnoughResource", tostring(var_52_1), "canReleaseSkillAddResource", tostring(var_52_2))

			var_52_0 = not var_52_1 and not var_52_2
		end

		gohelper.setActive(arg_52_0._goreslutvxloop, var_52_0)
	end
end

function var_0_0.onDestroyView(arg_53_0)
	arg_53_0._powerParentTr = nil

	if arg_53_0._powerParent then
		gohelper.destroy(arg_53_0._powerParent)

		arg_53_0._powerParent = nil
	end

	TaskDispatcher.cancelTask(arg_53_0.refreshViewActive, arg_53_0)

	if arg_53_0._soliderTipView then
		arg_53_0._soliderTipView:onDestroy()

		arg_53_0._soliderTipView = nil
	end
end

return var_0_0
