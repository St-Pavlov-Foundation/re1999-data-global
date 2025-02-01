module("modules.logic.room.controller.RoomLayoutController", package.seeall)

slot0 = class("RoomLayoutController", BaseController)

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.clear(slot0)
end

function slot0.addConstEvents(slot0)
	slot0:addEventCb(RoomController.instance, RoomEvent.OnLateInitDone, slot0._onEnterRoomDone, slot0)
	slot0:addEventCb(RoomController.instance, RoomEvent.OnSwitchModeDone, slot0._onEnterRoomDone, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.UpdateRoomLevel, slot0._onUpateRoomLevel, slot0)
end

function slot0._onEnterRoomDone(slot0)
	if slot0._lastSwitchbuildDegree and RoomController.instance:isObMode() then
		slot0._lastSwitchbuildDegree = nil

		if RoomConfig.instance:getBuildBonusByBuildDegree(slot0._lastSwitchbuildDegree) ~= RoomConfig.instance:getBuildBonusByBuildDegree(RoomMapModel.instance:getAllBuildDegree()) then
			slot0:dispatchEvent(RoomEvent.UISwitchLayoutPlanBuildDegree)
		end
	end
end

function slot0._onUpateRoomLevel(slot0)
	if (CommonConfig.instance:getConstNum(ConstEnum.RoomLayoutPlanOpen) or 0) == RoomModel.instance:getRoomLevel() then
		slot0:sendGetRoomPlanInfoRpc()
	end
end

function slot0.isOpen(slot0, slot1)
	if (CommonConfig.instance:getConstNum(ConstEnum.RoomLayoutPlanOpen) or 0) <= RoomModel.instance:getRoomLevel() then
		return true
	end

	if slot1 == true then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanNotOpen, slot2)
	end

	return false
end

function slot0.openView(slot0)
	slot1 = false

	if slot0:isOpen(true) then
		if RoomController.instance:isObMode() then
			slot0:updateObInfo()
		end

		RoomLayoutListModel.instance:init()
		ViewMgr.instance:openView(ViewName.RoomLayoutView)

		slot1 = true
	end

	return slot1
end

function slot0.openCopyTips(slot0, slot1)
	slot0._openTipsParam = {
		showBuy = true,
		titleStr = luaLang("room_layoutplan_copy_tips_title")
	}

	slot0:_onOpenTips(slot1)
end

function slot0.openTips(slot0, slot1, slot2, slot3, slot4)
	if not RoomLayoutModel.instance:getById(slot1) then
		return
	end

	slot0._openTipsParam = {
		uiWorldPos = slot2,
		offsetWidth = slot3,
		offsetHeight = slot4,
		titleStr = formatLuaLang("room_layoutplan_look_details", slot5.name or "")
	}

	if slot5:isHasBlockBuildingInfo() then
		slot0:_onOpenTips(slot5)
	elseif slot1 == RoomEnum.LayoutUsedPlanId then
		slot0:updateObInfo()
		slot0:_onOpenTips(slot5)
	else
		slot0._waitingOpenPlanId = slot1
		slot0._waitingOpenWorldPos = slot2

		RoomRpc.instance:sendGetRoomPlanDetailsRequest(slot1)
	end
end

function slot0._onOpenTips(slot0, slot1)
	slot0._waitingOpenPlanId = nil
	slot2 = slot0._openTipsParam
	slot0._openTipsParam = nil

	RoomLayoutItemListModel.instance:init(slot1.infos, slot1.buildingInfos)

	if RoomLayoutItemListModel.instance:getCount() <= 0 then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanMapNothing)

		return
	end

	if not ViewMgr.instance:isOpen(ViewName.RoomLayoutItemTips) and ViewMgr.instance:getSetting(slot3) then
		slot4.bgBlur = RoomController.instance:isVisitMode() and ViewMgr.instance:isOpen(RoomLayoutCreateTipsView) and 1 or nil
	end

	ViewMgr.instance:openView(slot3, slot2)
end

function slot0.openBgSelectView(slot0, slot1, slot2, slot3)
	RoomLayoutBgResListModel.instance:init(RoomLayoutListModel.instance:getSelectMO() and slot4:getCoverId())
	ViewMgr.instance:openView(ViewName.RoomLayoutBgSelectView, {
		uiWorldPos = slot1,
		offsetWidth = slot2,
		offsetHeight = slot3
	})
end

function slot0.openCreateTipsView(slot0, slot1, slot2, slot3, slot4, slot5)
	ViewMgr.instance:openView(ViewName.RoomLayoutCreateTipsView, {
		titleStr = slot1,
		isSelect = slot2,
		isShowSetlect = slot3,
		yesCallback = slot4,
		callbockObj = slot5
	})
end

function slot0.openRenameView(slot0)
	ViewMgr.instance:openView(ViewName.RoomLayoutRenameView)
end

function slot0.openCopyView(slot0, slot1)
	if slot0:_getObPlanInfo() == nil then
		return
	end

	if RoomMapBlockModel.instance:getMaxBlockCount(RoomModel.instance:getRoomLevel()) < slot2.blockCount then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanMax)

		return
	end

	ViewMgr.instance:openView(ViewName.RoomLayoutCopyView, {
		yesBtnNotClose = true,
		planInfo = slot2,
		defaultName = RoomLayoutModel.instance:findDefaultName(),
		yesCallback = slot0._onYesCopyViewCallback,
		callbockObj = slot0,
		playerName = slot1
	})
end

slot0.COPY_SHARE_CODE_WORD_TEST_RPC = "RoomLayoutController.COPY_SHARE_CODE_WORD_TEST_RPC"

function slot0._onYesCopyViewCallback(slot0, slot1)
	UIBlockMgr.instance:startBlock(uv0.COPY_SHARE_CODE_WORD_TEST_RPC)
	ChatRpc.instance:sendWordTestRequest(slot1, slot0._onCopyWordTestReply, slot0)
	RoomLayoutModel.instance:setVisitCopyName(slot1)
end

function slot0._onCopyWordTestReply(slot0, slot1, slot2, slot3)
	UIBlockMgr.instance:endBlock(uv0.COPY_SHARE_CODE_WORD_TEST_RPC)

	if slot2 == 0 then
		ViewMgr.instance:closeView(ViewName.RoomLayoutCopyView)
		slot0:openView()
	end
end

function slot0._getObPlanInfo(slot0, slot1)
	if not RoomModel.instance:getInfoByMode(slot1 or RoomModel.instance:getGameMode()) then
		return
	end

	return RoomLayoutHelper.createInfoByObInfo(slot2)
end

function slot0.updateObInfo(slot0)
	if slot0:_getObPlanInfo(RoomEnum.GameMode.Ob) then
		slot1.id = RoomEnum.LayoutUsedPlanId

		RoomLayoutModel.instance:updateRoomPlanInfoReply(slot1)
	end
end

function slot0.sendGetRoomPlanInfoRpc(slot0)
	if slot0:isOpen() then
		RoomRpc.instance:sendGetRoomPlanInfoRequest()
	end
end

function slot0.sendCreateRpc(slot0, slot1, slot2)
	slot3 = slot1:getCoverId()

	if slot1:isEmpty() then
		slot1:setName(RoomLayoutModel.instance:findDefaultName())
	elseif RoomLayoutModel.instance:getById(RoomEnum.LayoutUsedPlanId) then
		slot3 = slot4:getCoverId() or slot3
	end

	RoomRpc.instance:sendSetRoomPlanRequest(slot1.id, slot3, slot1:getName())

	if slot2 and slot1.id ~= RoomEnum.LayoutUsedPlanId then
		slot0:sendSwitchRoomPlanRequest(slot1.id)
	end
end

function slot0.sendSwitchRoomPlanRequest(slot0, slot1)
	if slot1 ~= RoomEnum.LayoutUsedPlanId then
		slot0._hasSwitchPlan = true

		RoomRpc.instance:sendSwitchRoomPlanRequest(RoomEnum.LayoutUsedPlanId, slot1, slot0._onObSwitchPlanReplay, slot0)
	end
end

function slot0._onObSwitchPlanReplay(slot0, slot1, slot2, slot3)
	slot0._hasSwitchPlan = false

	if slot2 == 0 then
		GameFacade.showToast(slot0._hasSwitchPlan and RoomEnum.Toast.LayoutPlanSaveAndUse or RoomEnum.Toast.LayoutPlanUse)

		slot0._lastSwitchbuildDegree = RoomMapModel.instance:getAllBuildDegree()

		slot0:_swicthPlanCritterRequest()
		RoomController.instance:enterRoom(RoomEnum.GameMode.Ob, nil, , , , , true)
	end
end

function slot0._swicthPlanCritterRequest(slot0)
	if CritterModel.instance:isCritterUnlock() then
		CritterRpc.instance:sendCritterGetInfoRequest()
	end

	ManufactureController.instance:getManufactureServerInfo()
end

function slot0.sendVisitCopyRpc(slot0, slot1, slot2)
	slot3 = RoomModel.instance:getVisitParam()
	slot4 = slot1.id
	slot5 = slot1:getCoverId()
	slot6 = RoomLayoutModel.instance:getVisitCopyName()

	if slot2 and slot4 ~= RoomEnum.LayoutUsedPlanId then
		slot0._visitsWitchPlanId = slot4
	end

	if (slot2 or slot4 == RoomEnum.LayoutUsedPlanId) and RoomLayoutModel.instance:getById(RoomEnum.LayoutUsedPlanId) then
		slot0._lastSwitchbuildDegree = slot7.buildingDegree
	end

	if RoomController.instance:isVisitShareMode() then
		RoomRpc.instance:sendUseRoomShareRequest(slot3.shareCode, slot4, slot5, slot6, slot0._onVisitCopyReply, slot0)
	else
		RoomRpc.instance:sendCopyOtherRoomPlanRequest(slot3.userId, slot4, slot5, slot6, slot0._onVisitCopyReply, slot0)
	end
end

function slot0._onVisitCopyReply(slot0, slot1, slot2, slot3)
	slot4 = slot0._visitsWitchPlanId
	slot0._visitsWitchPlanId = nil

	if slot2 == 0 then
		RoomLayoutModel.instance:clearNeedRpcGet()

		if slot4 then
			slot0._hasSwitchPlan = true

			RoomRpc.instance:sendSwitchRoomPlanRequest(RoomEnum.LayoutUsedPlanId, slot4, slot0._onVisitSwitchPlanReplay, slot0)
		end

		if RoomController.instance:isVisitMode() then
			slot0:_swicthPlanCritterRequest()
			RoomController.instance:enterRoom(RoomEnum.GameMode.Ob, nil, , , {
				{
					viewName = ViewName.RoomLayoutView
				}
			}, nil, true)
		end
	end
end

function slot0._onVisitSwitchPlanReplay(slot0, slot1, slot2, slot3)
	slot0._hasSwitchPlan = false

	if slot2 == 0 then
		GameFacade.showToast(slot0._hasSwitchPlan and RoomEnum.Toast.LayoutPlanSaveAndUse or RoomEnum.Toast.LayoutPlanUse)
	end
end

function slot0.copyShareCodeTxt(slot0, slot1)
	if not string.nilorempty(slot1) then
		ZProj.UGUIHelper.CopyText(slot1)
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanCopyShareCodeTxt)
	end
end

slot0.GET_SHARE_CODE_RPC = "RoomLayoutController.GET_SHARE_CODE_RPC"

function slot0.sendGetShareCodeRpc(slot0, slot1)
	UIBlockMgr.instance:startBlock(uv0.GET_SHARE_CODE_RPC)
	RoomRpc.instance:sendGetRoomShareRequest(slot1, slot0._getGetRoomShareReply, slot0)
end

function slot0._getGetRoomShareReply(slot0, slot1, slot2, slot3)
	UIBlockMgr.instance:endBlock(uv0.GET_SHARE_CODE_RPC)

	if slot2 == 0 then
		RoomController.instance:enterRoom(RoomEnum.GameMode.VisitShare, nil, slot3, {
			userId = slot3.shareUserId,
			shareCode = slot3.shareCode
		}, nil, , true)
	end
end

function slot0.sendSetRoomPlanNameRpc(slot0, slot1, slot2)
	RoomRpc.instance:sendSetRoomPlanNameRequest(slot1, slot2, slot0._onSetRoomPlanNameReply, slot0)
end

function slot0._onSetRoomPlanNameReply(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanRename)
		ViewMgr.instance:closeView(ViewName.RoomLayoutRenameView)
	end
end

function slot0.getRoomPlanInfoReply(slot0, slot1)
	RoomLayoutModel.instance:rpcGetFinish()
	RoomLayoutModel.instance:setRoomPlanInfoReply(slot1)
	slot0:updateObInfo()
	RoomLayoutListModel.instance:init()

	if slot1.infos then
		for slot5, slot6 in ipairs(slot1.infos) do
			if string.nilorempty(slot6.name) then
				RoomRpc.instance:sendSetRoomPlanNameRequest(slot6.id, formatLuaLang("room_layoutplan_default_name", ""))
			end
		end
	end
end

function slot0.getRoomPlanDestailsReply(slot0, slot1)
	RoomLayoutModel.instance:updateRoomPlanInfoReply(slot1.info)

	if slot1.info.id == slot0._waitingOpenPlanId then
		slot0:_onOpenTips(RoomLayoutModel.instance:getById(slot1.info.id), slot0._waitingOpenWorldPos)
	end
end

function slot0.setRoomPlanReply(slot0, slot1)
	slot2 = slot0:_getObPlanInfo() or {}
	slot2.id = slot1.id
	slot2.coverId = slot1.coverId
	slot2.name = slot1.name
	slot2.shareCode = slot1.shareCode or ""
	slot3 = RoomLayoutModel.instance:getById(slot1.id) == nil

	RoomLayoutModel.instance:updateRoomPlanInfoReply(slot2)

	if slot0._hasSwitchPlan ~= true then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanSave)
	end

	if slot3 then
		RoomLayoutListModel.instance:init()
		RoomLayoutListModel.instance:setSelect(slot1.id)
		slot0:dispatchEvent(RoomEvent.UISelectLayoutPlanItem)
	else
		RoomLayoutListModel.instance:refreshList()
	end
end

function slot0.setRoomPlanNameReply(slot0, slot1)
	if RoomLayoutModel.instance:getById(slot1.id) then
		slot2.name = slot1.name
	end

	RoomLayoutListModel.instance:refreshList()
end

function slot0.setRoomPlanCoverReply(slot0, slot1)
	if RoomLayoutModel.instance:getById(slot1.id) then
		slot2.coverId = slot1.coverId
	end
end

function slot0.useRoomPlanReply(slot0, slot1)
end

function slot0.switchRoomPlanReply(slot0, slot1)
	for slot7 = 1, #slot1.infos do
		RoomLayoutModel.instance:updateRoomPlanInfoReply(slot2[slot7])
	end
end

function slot0.deleteRoomPlanReply(slot0, slot1)
	if RoomLayoutModel.instance:getById(slot1.id) then
		RoomLayoutModel.instance:remove(slot2)
		RoomLayoutListModel.instance:init()
		RoomLayoutListModel.instance:setSelect(slot1.id)
		slot0:dispatchEvent(RoomEvent.UISelectLayoutPlanItem)
	end

	GameFacade.showToast(RoomEnum.Toast.LayoutPlanDelete)
end

function slot0.copyOtherRoomPlanReply(slot0, slot1)
	RoomLayoutModel.instance:updateRoomPlanInfoReply(slot1)

	if (not slot1.buildDegree or not slot1.blockCount) and slot0:_getObPlanInfo() then
		slot2.id = slot1.id

		RoomLayoutModel.instance:updateRoomPlanInfoReply(slot2)
	end

	RoomLayoutListModel.instance:init()
	RoomLayoutModel.instance:clearNeedRpcGet()

	if slot0._hasSwitchPlan ~= true then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanCopy)
	end
end

function slot0.useRoomShareReply(slot0, slot1)
	RoomLayoutModel.instance:updateRoomPlanInfoReply(slot1)
	RoomLayoutModel.instance:setCanUseShareCount(slot1.canUseShareCount)
	RoomLayoutListModel.instance:init()
end

function slot0.shareRoomPlanReply(slot0, slot1)
	RoomLayoutModel.instance:updateRoomPlanInfoReply(slot1)
	RoomLayoutModel.instance:setCanShareCount(slot1.canShareCount)
	RoomLayoutListModel.instance:init()
end

function slot0.deleteRoomShareReply(slot0, slot1)
	RoomLayoutModel.instance:updateRoomPlanInfoReply({
		shareCode = "",
		id = slot1.id,
		useCount = slot1.useCount or 0
	})
	RoomLayoutListModel.instance:init()
end

slot0.instance = slot0.New()

return slot0
