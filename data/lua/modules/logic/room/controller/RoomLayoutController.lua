module("modules.logic.room.controller.RoomLayoutController", package.seeall)

local var_0_0 = class("RoomLayoutController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.clear(arg_3_0)
	return
end

function var_0_0.addConstEvents(arg_4_0)
	arg_4_0:addEventCb(RoomController.instance, RoomEvent.OnLateInitDone, arg_4_0._onEnterRoomDone, arg_4_0)
	arg_4_0:addEventCb(RoomController.instance, RoomEvent.OnSwitchModeDone, arg_4_0._onEnterRoomDone, arg_4_0)
	arg_4_0:addEventCb(RoomMapController.instance, RoomEvent.UpdateRoomLevel, arg_4_0._onUpateRoomLevel, arg_4_0)
end

function var_0_0._onEnterRoomDone(arg_5_0)
	if arg_5_0._lastSwitchbuildDegree and RoomController.instance:isObMode() then
		local var_5_0 = RoomConfig.instance:getBuildBonusByBuildDegree(arg_5_0._lastSwitchbuildDegree)
		local var_5_1 = RoomMapModel.instance:getAllBuildDegree()
		local var_5_2 = RoomConfig.instance:getBuildBonusByBuildDegree(var_5_1)

		arg_5_0._lastSwitchbuildDegree = nil

		if var_5_0 ~= var_5_2 then
			arg_5_0:dispatchEvent(RoomEvent.UISwitchLayoutPlanBuildDegree)
		end
	end
end

function var_0_0._onUpateRoomLevel(arg_6_0)
	if (CommonConfig.instance:getConstNum(ConstEnum.RoomLayoutPlanOpen) or 0) == RoomModel.instance:getRoomLevel() then
		arg_6_0:sendGetRoomPlanInfoRpc()
	end
end

function var_0_0.isOpen(arg_7_0, arg_7_1)
	local var_7_0 = CommonConfig.instance:getConstNum(ConstEnum.RoomLayoutPlanOpen) or 0

	if var_7_0 <= RoomModel.instance:getRoomLevel() then
		return true
	end

	if arg_7_1 == true then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanNotOpen, var_7_0)
	end

	return false
end

function var_0_0.openView(arg_8_0)
	local var_8_0 = false

	if arg_8_0:isOpen(true) then
		if RoomController.instance:isObMode() then
			arg_8_0:updateObInfo()
		end

		RoomLayoutListModel.instance:init()
		ViewMgr.instance:openView(ViewName.RoomLayoutView)

		var_8_0 = true
	end

	return var_8_0
end

function var_0_0.openCopyTips(arg_9_0, arg_9_1)
	local var_9_0 = luaLang("room_layoutplan_copy_tips_title")

	arg_9_0._openTipsParam = {
		showBuy = true,
		titleStr = var_9_0
	}

	arg_9_0:_onOpenTips(arg_9_1)
end

function var_0_0.openTips(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = RoomLayoutModel.instance:getById(arg_10_1)

	if not var_10_0 then
		return
	end

	arg_10_0._openTipsParam = {
		uiWorldPos = arg_10_2,
		offsetWidth = arg_10_3,
		offsetHeight = arg_10_4,
		titleStr = formatLuaLang("room_layoutplan_look_details", var_10_0.name or "")
	}

	if var_10_0:isHasBlockBuildingInfo() then
		arg_10_0:_onOpenTips(var_10_0)
	elseif arg_10_1 == RoomEnum.LayoutUsedPlanId then
		arg_10_0:updateObInfo()
		arg_10_0:_onOpenTips(var_10_0)
	else
		arg_10_0._waitingOpenPlanId = arg_10_1
		arg_10_0._waitingOpenWorldPos = arg_10_2

		RoomRpc.instance:sendGetRoomPlanDetailsRequest(arg_10_1)
	end
end

function var_0_0._onOpenTips(arg_11_0, arg_11_1)
	arg_11_0._waitingOpenPlanId = nil

	local var_11_0 = arg_11_0._openTipsParam

	arg_11_0._openTipsParam = nil

	RoomLayoutItemListModel.instance:init(arg_11_1.infos, arg_11_1.buildingInfos)

	if RoomLayoutItemListModel.instance:getCount() <= 0 then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanMapNothing)

		return
	end

	local var_11_1 = ViewName.RoomLayoutItemTips

	if not ViewMgr.instance:isOpen(var_11_1) then
		local var_11_2 = ViewMgr.instance:getSetting(var_11_1)

		if var_11_2 then
			var_11_2.bgBlur = RoomController.instance:isVisitMode() and ViewMgr.instance:isOpen(RoomLayoutCreateTipsView) and 1 or nil
		end
	end

	ViewMgr.instance:openView(var_11_1, var_11_0)
end

function var_0_0.openBgSelectView(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = RoomLayoutListModel.instance:getSelectMO()

	RoomLayoutBgResListModel.instance:init(var_12_0 and var_12_0:getCoverId())
	ViewMgr.instance:openView(ViewName.RoomLayoutBgSelectView, {
		uiWorldPos = arg_12_1,
		offsetWidth = arg_12_2,
		offsetHeight = arg_12_3
	})
end

function var_0_0.openCreateTipsView(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	local var_13_0 = {
		titleStr = arg_13_1,
		isSelect = arg_13_2,
		isShowSetlect = arg_13_3,
		yesCallback = arg_13_4,
		callbockObj = arg_13_5
	}

	ViewMgr.instance:openView(ViewName.RoomLayoutCreateTipsView, var_13_0)
end

function var_0_0.openRenameView(arg_14_0)
	ViewMgr.instance:openView(ViewName.RoomLayoutRenameView)
end

function var_0_0.openCopyView(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:_getObPlanInfo()

	if var_15_0 == nil then
		return
	end

	if RoomMapBlockModel.instance:getMaxBlockCount(RoomModel.instance:getRoomLevel()) < var_15_0.blockCount then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanMax)

		return
	end

	local var_15_1 = RoomLayoutModel.instance:findDefaultName()
	local var_15_2 = {
		yesBtnNotClose = true,
		planInfo = var_15_0,
		defaultName = var_15_1,
		yesCallback = arg_15_0._onYesCopyViewCallback,
		callbockObj = arg_15_0,
		playerName = arg_15_1
	}

	ViewMgr.instance:openView(ViewName.RoomLayoutCopyView, var_15_2)
end

var_0_0.COPY_SHARE_CODE_WORD_TEST_RPC = "RoomLayoutController.COPY_SHARE_CODE_WORD_TEST_RPC"

function var_0_0._onYesCopyViewCallback(arg_16_0, arg_16_1)
	UIBlockMgr.instance:startBlock(var_0_0.COPY_SHARE_CODE_WORD_TEST_RPC)
	ChatRpc.instance:sendWordTestRequest(arg_16_1, arg_16_0._onCopyWordTestReply, arg_16_0)
	RoomLayoutModel.instance:setVisitCopyName(arg_16_1)
end

function var_0_0._onCopyWordTestReply(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	UIBlockMgr.instance:endBlock(var_0_0.COPY_SHARE_CODE_WORD_TEST_RPC)

	if arg_17_2 == 0 then
		ViewMgr.instance:closeView(ViewName.RoomLayoutCopyView)
		arg_17_0:openView()
	end
end

function var_0_0._getObPlanInfo(arg_18_0, arg_18_1)
	local var_18_0 = RoomModel.instance:getInfoByMode(arg_18_1 or RoomModel.instance:getGameMode())

	if not var_18_0 then
		return
	end

	return RoomLayoutHelper.createInfoByObInfo(var_18_0)
end

function var_0_0.updateObInfo(arg_19_0)
	local var_19_0 = arg_19_0:_getObPlanInfo(RoomEnum.GameMode.Ob)

	if var_19_0 then
		var_19_0.id = RoomEnum.LayoutUsedPlanId

		RoomLayoutModel.instance:updateRoomPlanInfoReply(var_19_0)
	end
end

function var_0_0.sendGetRoomPlanInfoRpc(arg_20_0)
	if arg_20_0:isOpen() then
		RoomRpc.instance:sendGetRoomPlanInfoRequest()
	end
end

function var_0_0.sendCreateRpc(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_1:getCoverId()

	if arg_21_1:isEmpty() then
		arg_21_1:setName(RoomLayoutModel.instance:findDefaultName())
	else
		local var_21_1 = RoomLayoutModel.instance:getById(RoomEnum.LayoutUsedPlanId)

		var_21_0 = var_21_1 and var_21_1:getCoverId() or var_21_0
	end

	RoomRpc.instance:sendSetRoomPlanRequest(arg_21_1.id, var_21_0, arg_21_1:getName())

	if arg_21_2 and arg_21_1.id ~= RoomEnum.LayoutUsedPlanId then
		arg_21_0:sendSwitchRoomPlanRequest(arg_21_1.id)
	end
end

function var_0_0.sendSwitchRoomPlanRequest(arg_22_0, arg_22_1)
	if arg_22_1 ~= RoomEnum.LayoutUsedPlanId then
		arg_22_0._hasSwitchPlan = true

		RoomRpc.instance:sendSwitchRoomPlanRequest(RoomEnum.LayoutUsedPlanId, arg_22_1, arg_22_0._onObSwitchPlanReplay, arg_22_0)
	end
end

function var_0_0._onObSwitchPlanReplay(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = arg_23_0._hasSwitchPlan

	arg_23_0._hasSwitchPlan = false

	if arg_23_2 == 0 then
		local var_23_1 = var_23_0 and RoomEnum.Toast.LayoutPlanSaveAndUse or RoomEnum.Toast.LayoutPlanUse

		GameFacade.showToast(var_23_1)

		arg_23_0._lastSwitchbuildDegree = RoomMapModel.instance:getAllBuildDegree()

		arg_23_0:_swicthPlanCritterRequest()
		RoomController.instance:enterRoom(RoomEnum.GameMode.Ob, nil, nil, nil, nil, nil, true)
	end
end

function var_0_0._swicthPlanCritterRequest(arg_24_0)
	if CritterModel.instance:isCritterUnlock() then
		CritterRpc.instance:sendCritterGetInfoRequest()
	end

	ManufactureController.instance:getManufactureServerInfo()
end

function var_0_0.sendVisitCopyRpc(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = RoomModel.instance:getVisitParam()
	local var_25_1 = arg_25_1.id
	local var_25_2 = arg_25_1:getCoverId()
	local var_25_3 = RoomLayoutModel.instance:getVisitCopyName()

	if arg_25_2 and var_25_1 ~= RoomEnum.LayoutUsedPlanId then
		arg_25_0._visitsWitchPlanId = var_25_1
	end

	if arg_25_2 or var_25_1 == RoomEnum.LayoutUsedPlanId then
		local var_25_4 = RoomLayoutModel.instance:getById(RoomEnum.LayoutUsedPlanId)

		if var_25_4 then
			arg_25_0._lastSwitchbuildDegree = var_25_4.buildingDegree
		end
	end

	if RoomController.instance:isVisitShareMode() then
		RoomRpc.instance:sendUseRoomShareRequest(var_25_0.shareCode, var_25_1, var_25_2, var_25_3, arg_25_0._onVisitCopyReply, arg_25_0)
	else
		RoomRpc.instance:sendCopyOtherRoomPlanRequest(var_25_0.userId, var_25_1, var_25_2, var_25_3, arg_25_0._onVisitCopyReply, arg_25_0)
	end
end

function var_0_0._onVisitCopyReply(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = arg_26_0._visitsWitchPlanId

	arg_26_0._visitsWitchPlanId = nil

	if arg_26_2 == 0 then
		RoomLayoutModel.instance:clearNeedRpcGet()

		if var_26_0 then
			arg_26_0._hasSwitchPlan = true

			RoomRpc.instance:sendSwitchRoomPlanRequest(RoomEnum.LayoutUsedPlanId, var_26_0, arg_26_0._onVisitSwitchPlanReplay, arg_26_0)
		end

		if RoomController.instance:isVisitMode() then
			local var_26_1 = {
				{
					viewName = ViewName.RoomLayoutView
				}
			}

			arg_26_0:_swicthPlanCritterRequest()
			RoomController.instance:enterRoom(RoomEnum.GameMode.Ob, nil, nil, nil, var_26_1, nil, true)
		end
	end
end

function var_0_0._onVisitSwitchPlanReplay(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = arg_27_0._hasSwitchPlan

	arg_27_0._hasSwitchPlan = false

	if arg_27_2 == 0 then
		local var_27_1 = var_27_0 and RoomEnum.Toast.LayoutPlanSaveAndUse or RoomEnum.Toast.LayoutPlanUse

		GameFacade.showToast(var_27_1)
	end
end

function var_0_0.copyShareCodeTxt(arg_28_0, arg_28_1)
	if not string.nilorempty(arg_28_1) then
		ZProj.UGUIHelper.CopyText(arg_28_1)
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanCopyShareCodeTxt)
	end
end

var_0_0.GET_SHARE_CODE_RPC = "RoomLayoutController.GET_SHARE_CODE_RPC"

function var_0_0.sendGetShareCodeRpc(arg_29_0, arg_29_1)
	UIBlockMgr.instance:startBlock(var_0_0.GET_SHARE_CODE_RPC)
	RoomRpc.instance:sendGetRoomShareRequest(arg_29_1, arg_29_0._getGetRoomShareReply, arg_29_0)
end

function var_0_0._getGetRoomShareReply(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	UIBlockMgr.instance:endBlock(var_0_0.GET_SHARE_CODE_RPC)

	if arg_30_2 == 0 then
		local var_30_0 = {
			userId = arg_30_3.shareUserId,
			shareCode = arg_30_3.shareCode
		}
		local var_30_1 = arg_30_3

		RoomController.instance:enterRoom(RoomEnum.GameMode.VisitShare, nil, var_30_1, var_30_0, nil, nil, true)
	end
end

function var_0_0.sendSetRoomPlanNameRpc(arg_31_0, arg_31_1, arg_31_2)
	RoomRpc.instance:sendSetRoomPlanNameRequest(arg_31_1, arg_31_2, arg_31_0._onSetRoomPlanNameReply, arg_31_0)
end

function var_0_0._onSetRoomPlanNameReply(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	if arg_32_2 == 0 then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanRename)
		ViewMgr.instance:closeView(ViewName.RoomLayoutRenameView)
	end
end

function var_0_0.getRoomPlanInfoReply(arg_33_0, arg_33_1)
	RoomLayoutModel.instance:rpcGetFinish()
	RoomLayoutModel.instance:setRoomPlanInfoReply(arg_33_1)
	arg_33_0:updateObInfo()
	RoomLayoutListModel.instance:init()

	if arg_33_1.infos then
		for iter_33_0, iter_33_1 in ipairs(arg_33_1.infos) do
			if string.nilorempty(iter_33_1.name) then
				RoomRpc.instance:sendSetRoomPlanNameRequest(iter_33_1.id, formatLuaLang("room_layoutplan_default_name", ""))
			end
		end
	end
end

function var_0_0.getRoomPlanDestailsReply(arg_34_0, arg_34_1)
	RoomLayoutModel.instance:updateRoomPlanInfoReply(arg_34_1.info)

	if arg_34_1.info.id == arg_34_0._waitingOpenPlanId then
		local var_34_0 = RoomLayoutModel.instance:getById(arg_34_1.info.id)

		arg_34_0:_onOpenTips(var_34_0, arg_34_0._waitingOpenWorldPos)
	end
end

function var_0_0.setRoomPlanReply(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0:_getObPlanInfo() or {}

	var_35_0.id = arg_35_1.id
	var_35_0.coverId = arg_35_1.coverId
	var_35_0.name = arg_35_1.name
	var_35_0.shareCode = arg_35_1.shareCode or ""

	local var_35_1 = RoomLayoutModel.instance:getById(arg_35_1.id) == nil

	RoomLayoutModel.instance:updateRoomPlanInfoReply(var_35_0)

	if arg_35_0._hasSwitchPlan ~= true then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanSave)
	end

	if var_35_1 then
		RoomLayoutListModel.instance:init()
		RoomLayoutListModel.instance:setSelect(arg_35_1.id)
		arg_35_0:dispatchEvent(RoomEvent.UISelectLayoutPlanItem)
	else
		RoomLayoutListModel.instance:refreshList()
	end
end

function var_0_0.setRoomPlanNameReply(arg_36_0, arg_36_1)
	local var_36_0 = RoomLayoutModel.instance:getById(arg_36_1.id)

	if var_36_0 then
		var_36_0.name = arg_36_1.name
	end

	RoomLayoutListModel.instance:refreshList()
end

function var_0_0.setRoomPlanCoverReply(arg_37_0, arg_37_1)
	local var_37_0 = RoomLayoutModel.instance:getById(arg_37_1.id)

	if var_37_0 then
		var_37_0.coverId = arg_37_1.coverId
	end
end

function var_0_0.useRoomPlanReply(arg_38_0, arg_38_1)
	return
end

function var_0_0.switchRoomPlanReply(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_1.infos
	local var_39_1 = RoomLayoutModel.instance

	for iter_39_0 = 1, #var_39_0 do
		var_39_1:updateRoomPlanInfoReply(var_39_0[iter_39_0])
	end
end

function var_0_0.deleteRoomPlanReply(arg_40_0, arg_40_1)
	local var_40_0 = RoomLayoutModel.instance:getById(arg_40_1.id)

	if var_40_0 then
		RoomLayoutModel.instance:remove(var_40_0)
		RoomLayoutListModel.instance:init()
		RoomLayoutListModel.instance:setSelect(arg_40_1.id)
		arg_40_0:dispatchEvent(RoomEvent.UISelectLayoutPlanItem)
	end

	GameFacade.showToast(RoomEnum.Toast.LayoutPlanDelete)
end

function var_0_0.copyOtherRoomPlanReply(arg_41_0, arg_41_1)
	RoomLayoutModel.instance:updateRoomPlanInfoReply(arg_41_1)

	if not arg_41_1.buildDegree or not arg_41_1.blockCount then
		local var_41_0 = arg_41_0:_getObPlanInfo()

		if var_41_0 then
			var_41_0.id = arg_41_1.id

			RoomLayoutModel.instance:updateRoomPlanInfoReply(var_41_0)
		end
	end

	RoomLayoutListModel.instance:init()
	RoomLayoutModel.instance:clearNeedRpcGet()

	if arg_41_0._hasSwitchPlan ~= true then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanCopy)
	end
end

function var_0_0.useRoomShareReply(arg_42_0, arg_42_1)
	RoomLayoutModel.instance:updateRoomPlanInfoReply(arg_42_1)
	RoomLayoutModel.instance:setCanUseShareCount(arg_42_1.canUseShareCount)
	RoomLayoutListModel.instance:init()
end

function var_0_0.shareRoomPlanReply(arg_43_0, arg_43_1)
	RoomLayoutModel.instance:updateRoomPlanInfoReply(arg_43_1)
	RoomLayoutModel.instance:setCanShareCount(arg_43_1.canShareCount)
	RoomLayoutListModel.instance:init()
end

function var_0_0.deleteRoomShareReply(arg_44_0, arg_44_1)
	RoomLayoutModel.instance:updateRoomPlanInfoReply({
		shareCode = "",
		id = arg_44_1.id,
		useCount = arg_44_1.useCount or 0
	})
	RoomLayoutListModel.instance:init()
end

var_0_0.instance = var_0_0.New()

return var_0_0
