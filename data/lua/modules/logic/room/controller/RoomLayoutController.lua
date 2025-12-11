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

	if var_15_0.changeColorCount and var_15_0.changeColorCount > 0 then
		local var_15_1 = UnlockVoucherConfig.instance:getRoomColorConst(UnlockVoucherEnum.ConstId.RoomBlockColorReformCostItem, "#", true)
		local var_15_2 = var_15_1[1]
		local var_15_3 = var_15_1[2]

		if ItemModel.instance:getItemQuantity(var_15_2, var_15_3) < var_15_0.changeColorCount then
			GameFacade.showToast(ToastEnum.CopyLayoutNotEnoughBlockReformCost)

			return
		end

		GameFacade.showMessageBox(MessageBoxIdDefine.ConfirmCopyLayoutCostItem, MsgBoxEnum.BoxType.Yes_No, arg_15_0._confirmCopy, nil, nil, arg_15_0, nil, nil, var_15_0.changeColorCount)
	else
		arg_15_0:_confirmCopy()
	end
end

function var_0_0._confirmCopy(arg_16_0)
	local var_16_0 = arg_16_0:_getObPlanInfo()

	if var_16_0 == nil then
		return
	end

	local var_16_1 = RoomLayoutModel.instance:findDefaultName()
	local var_16_2 = {
		yesBtnNotClose = true,
		planInfo = var_16_0,
		defaultName = var_16_1,
		yesCallback = arg_16_0._onYesCopyViewCallback,
		callbockObj = arg_16_0,
		playerName = playerName
	}

	ViewMgr.instance:openView(ViewName.RoomLayoutCopyView, var_16_2)
end

var_0_0.COPY_SHARE_CODE_WORD_TEST_RPC = "RoomLayoutController.COPY_SHARE_CODE_WORD_TEST_RPC"

function var_0_0._onYesCopyViewCallback(arg_17_0, arg_17_1)
	UIBlockMgr.instance:startBlock(var_0_0.COPY_SHARE_CODE_WORD_TEST_RPC)
	ChatRpc.instance:sendWordTestRequest(arg_17_1, arg_17_0._onCopyWordTestReply, arg_17_0)
	RoomLayoutModel.instance:setVisitCopyName(arg_17_1)
end

function var_0_0._onCopyWordTestReply(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	UIBlockMgr.instance:endBlock(var_0_0.COPY_SHARE_CODE_WORD_TEST_RPC)

	if arg_18_2 == 0 then
		ViewMgr.instance:closeView(ViewName.RoomLayoutCopyView)
		arg_18_0:openView()
	end
end

function var_0_0._getObPlanInfo(arg_19_0, arg_19_1)
	local var_19_0 = RoomModel.instance:getInfoByMode(arg_19_1 or RoomModel.instance:getGameMode())

	if not var_19_0 then
		return
	end

	return RoomLayoutHelper.createInfoByObInfo(var_19_0)
end

function var_0_0.updateObInfo(arg_20_0)
	local var_20_0 = arg_20_0:_getObPlanInfo(RoomEnum.GameMode.Ob)

	if var_20_0 then
		var_20_0.id = RoomEnum.LayoutUsedPlanId

		RoomLayoutModel.instance:updateRoomPlanInfoReply(var_20_0)
	end
end

function var_0_0.sendGetRoomPlanInfoRpc(arg_21_0)
	if arg_21_0:isOpen() then
		RoomRpc.instance:sendGetRoomPlanInfoRequest()
	end
end

function var_0_0.sendCreateRpc(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_1:getCoverId()

	if arg_22_1:isEmpty() then
		arg_22_1:setName(RoomLayoutModel.instance:findDefaultName())
	else
		local var_22_1 = RoomLayoutModel.instance:getById(RoomEnum.LayoutUsedPlanId)

		var_22_0 = var_22_1 and var_22_1:getCoverId() or var_22_0
	end

	RoomRpc.instance:sendSetRoomPlanRequest(arg_22_1.id, var_22_0, arg_22_1:getName())

	if arg_22_2 and arg_22_1.id ~= RoomEnum.LayoutUsedPlanId then
		arg_22_0:sendSwitchRoomPlanRequest(arg_22_1.id)
	end
end

function var_0_0.sendSwitchRoomPlanRequest(arg_23_0, arg_23_1)
	if arg_23_1 ~= RoomEnum.LayoutUsedPlanId then
		arg_23_0._hasSwitchPlan = true

		RoomRpc.instance:sendSwitchRoomPlanRequest(RoomEnum.LayoutUsedPlanId, arg_23_1, arg_23_0._onObSwitchPlanReplay, arg_23_0)
	end
end

function var_0_0._onObSwitchPlanReplay(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = arg_24_0._hasSwitchPlan

	arg_24_0._hasSwitchPlan = false

	if arg_24_2 == 0 then
		local var_24_1 = var_24_0 and RoomEnum.Toast.LayoutPlanSaveAndUse or RoomEnum.Toast.LayoutPlanUse

		GameFacade.showToast(var_24_1)

		arg_24_0._lastSwitchbuildDegree = RoomMapModel.instance:getAllBuildDegree()

		arg_24_0:_swicthPlanCritterRequest()
		RoomController.instance:enterRoom(RoomEnum.GameMode.Ob, nil, nil, nil, nil, nil, true)
	end
end

function var_0_0._swicthPlanCritterRequest(arg_25_0)
	if CritterModel.instance:isCritterUnlock() then
		CritterRpc.instance:sendCritterGetInfoRequest()
	end

	ManufactureController.instance:getManufactureServerInfo()
end

function var_0_0.sendVisitCopyRpc(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = RoomModel.instance:getVisitParam()
	local var_26_1 = arg_26_1.id
	local var_26_2 = arg_26_1:getCoverId()
	local var_26_3 = RoomLayoutModel.instance:getVisitCopyName()

	if arg_26_2 and var_26_1 ~= RoomEnum.LayoutUsedPlanId then
		arg_26_0._visitsWitchPlanId = var_26_1
	end

	if arg_26_2 or var_26_1 == RoomEnum.LayoutUsedPlanId then
		local var_26_4 = RoomLayoutModel.instance:getById(RoomEnum.LayoutUsedPlanId)

		if var_26_4 then
			arg_26_0._lastSwitchbuildDegree = var_26_4.buildingDegree
		end
	end

	if RoomController.instance:isVisitShareMode() then
		RoomRpc.instance:sendUseRoomShareRequest(var_26_0.shareCode, var_26_1, var_26_2, var_26_3, arg_26_0._onVisitCopyReply, arg_26_0)
	else
		RoomRpc.instance:sendCopyOtherRoomPlanRequest(var_26_0.userId, var_26_1, var_26_2, var_26_3, arg_26_0._onVisitCopyReply, arg_26_0)
	end
end

function var_0_0._onVisitCopyReply(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = arg_27_0._visitsWitchPlanId

	arg_27_0._visitsWitchPlanId = nil

	if arg_27_2 == 0 then
		RoomLayoutModel.instance:clearNeedRpcGet()

		if var_27_0 then
			arg_27_0._hasSwitchPlan = true

			RoomRpc.instance:sendSwitchRoomPlanRequest(RoomEnum.LayoutUsedPlanId, var_27_0, arg_27_0._onVisitSwitchPlanReplay, arg_27_0)
		end

		if RoomController.instance:isVisitMode() then
			local var_27_1 = {
				{
					viewName = ViewName.RoomLayoutView
				}
			}

			arg_27_0:_swicthPlanCritterRequest()
			RoomController.instance:enterRoom(RoomEnum.GameMode.Ob, nil, nil, nil, var_27_1, nil, true)
		end
	end
end

function var_0_0._onVisitSwitchPlanReplay(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = arg_28_0._hasSwitchPlan

	arg_28_0._hasSwitchPlan = false

	if arg_28_2 == 0 then
		local var_28_1 = var_28_0 and RoomEnum.Toast.LayoutPlanSaveAndUse or RoomEnum.Toast.LayoutPlanUse

		GameFacade.showToast(var_28_1)
	end
end

function var_0_0.copyShareCodeTxt(arg_29_0, arg_29_1)
	if not string.nilorempty(arg_29_1) then
		ZProj.UGUIHelper.CopyText(arg_29_1)
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanCopyShareCodeTxt)
	end
end

var_0_0.GET_SHARE_CODE_RPC = "RoomLayoutController.GET_SHARE_CODE_RPC"

function var_0_0.sendGetShareCodeRpc(arg_30_0, arg_30_1)
	UIBlockMgr.instance:startBlock(var_0_0.GET_SHARE_CODE_RPC)
	RoomRpc.instance:sendGetRoomShareRequest(arg_30_1, arg_30_0._getGetRoomShareReply, arg_30_0)
end

function var_0_0._getGetRoomShareReply(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	UIBlockMgr.instance:endBlock(var_0_0.GET_SHARE_CODE_RPC)

	if arg_31_2 == 0 then
		local var_31_0 = {
			userId = arg_31_3.shareUserId,
			shareCode = arg_31_3.shareCode
		}
		local var_31_1 = arg_31_3

		RoomController.instance:enterRoom(RoomEnum.GameMode.VisitShare, nil, var_31_1, var_31_0, nil, nil, true)
	end
end

function var_0_0.sendSetRoomPlanNameRpc(arg_32_0, arg_32_1, arg_32_2)
	RoomRpc.instance:sendSetRoomPlanNameRequest(arg_32_1, arg_32_2, arg_32_0._onSetRoomPlanNameReply, arg_32_0)
end

function var_0_0._onSetRoomPlanNameReply(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	if arg_33_2 == 0 then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanRename)
		ViewMgr.instance:closeView(ViewName.RoomLayoutRenameView)
	end
end

function var_0_0.getRoomPlanInfoReply(arg_34_0, arg_34_1)
	RoomLayoutModel.instance:rpcGetFinish()
	RoomLayoutModel.instance:setRoomPlanInfoReply(arg_34_1)
	arg_34_0:updateObInfo()
	RoomLayoutListModel.instance:init()

	if arg_34_1.infos then
		for iter_34_0, iter_34_1 in ipairs(arg_34_1.infos) do
			if string.nilorempty(iter_34_1.name) then
				RoomRpc.instance:sendSetRoomPlanNameRequest(iter_34_1.id, formatLuaLang("room_layoutplan_default_name", ""))
			end
		end
	end
end

function var_0_0.getRoomPlanDestailsReply(arg_35_0, arg_35_1)
	RoomLayoutModel.instance:updateRoomPlanInfoReply(arg_35_1.info)

	if arg_35_1.info.id == arg_35_0._waitingOpenPlanId then
		local var_35_0 = RoomLayoutModel.instance:getById(arg_35_1.info.id)

		arg_35_0:_onOpenTips(var_35_0, arg_35_0._waitingOpenWorldPos)
	end
end

function var_0_0.setRoomPlanReply(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0:_getObPlanInfo() or {}

	var_36_0.id = arg_36_1.id
	var_36_0.coverId = arg_36_1.coverId
	var_36_0.name = arg_36_1.name
	var_36_0.shareCode = arg_36_1.shareCode or ""

	local var_36_1 = RoomLayoutModel.instance:getById(arg_36_1.id) == nil

	RoomLayoutModel.instance:updateRoomPlanInfoReply(var_36_0)

	if arg_36_0._hasSwitchPlan ~= true then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanSave)
	end

	if var_36_1 then
		RoomLayoutListModel.instance:init()
		RoomLayoutListModel.instance:setSelect(arg_36_1.id)
		arg_36_0:dispatchEvent(RoomEvent.UISelectLayoutPlanItem)
	else
		RoomLayoutListModel.instance:refreshList()
	end
end

function var_0_0.setRoomPlanNameReply(arg_37_0, arg_37_1)
	local var_37_0 = RoomLayoutModel.instance:getById(arg_37_1.id)

	if var_37_0 then
		var_37_0.name = arg_37_1.name
	end

	RoomLayoutListModel.instance:refreshList()
end

function var_0_0.setRoomPlanCoverReply(arg_38_0, arg_38_1)
	local var_38_0 = RoomLayoutModel.instance:getById(arg_38_1.id)

	if var_38_0 then
		var_38_0.coverId = arg_38_1.coverId
	end
end

function var_0_0.useRoomPlanReply(arg_39_0, arg_39_1)
	return
end

function var_0_0.switchRoomPlanReply(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_1.infos
	local var_40_1 = RoomLayoutModel.instance

	for iter_40_0 = 1, #var_40_0 do
		var_40_1:updateRoomPlanInfoReply(var_40_0[iter_40_0])
	end
end

function var_0_0.deleteRoomPlanReply(arg_41_0, arg_41_1)
	local var_41_0 = RoomLayoutModel.instance:getById(arg_41_1.id)

	if var_41_0 then
		RoomLayoutModel.instance:remove(var_41_0)
		RoomLayoutListModel.instance:init()
		RoomLayoutListModel.instance:setSelect(arg_41_1.id)
		arg_41_0:dispatchEvent(RoomEvent.UISelectLayoutPlanItem)
	end

	GameFacade.showToast(RoomEnum.Toast.LayoutPlanDelete)
end

function var_0_0.copyOtherRoomPlanReply(arg_42_0, arg_42_1)
	RoomLayoutModel.instance:updateRoomPlanInfoReply(arg_42_1)

	if not arg_42_1.buildDegree or not arg_42_1.blockCount then
		local var_42_0 = arg_42_0:_getObPlanInfo()

		if var_42_0 then
			var_42_0.id = arg_42_1.id

			RoomLayoutModel.instance:updateRoomPlanInfoReply(var_42_0)
		end
	end

	RoomLayoutListModel.instance:init()
	RoomLayoutModel.instance:clearNeedRpcGet()

	if arg_42_0._hasSwitchPlan ~= true then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanCopy)
	end
end

function var_0_0.useRoomShareReply(arg_43_0, arg_43_1)
	RoomLayoutModel.instance:updateRoomPlanInfoReply(arg_43_1)
	RoomLayoutModel.instance:setCanUseShareCount(arg_43_1.canUseShareCount)
	RoomLayoutListModel.instance:init()
end

function var_0_0.shareRoomPlanReply(arg_44_0, arg_44_1)
	RoomLayoutModel.instance:updateRoomPlanInfoReply(arg_44_1)
	RoomLayoutModel.instance:setCanShareCount(arg_44_1.canShareCount)
	RoomLayoutListModel.instance:init()
end

function var_0_0.deleteRoomShareReply(arg_45_0, arg_45_1)
	RoomLayoutModel.instance:updateRoomPlanInfoReply({
		shareCode = "",
		id = arg_45_1.id,
		useCount = arg_45_1.useCount or 0
	})
	RoomLayoutListModel.instance:init()
end

var_0_0.instance = var_0_0.New()

return var_0_0
