module("modules.logic.room.view.topright.RoomViewTopRightBuildItem", package.seeall)

slot0 = class("RoomViewTopRightBuildItem", RoomViewTopRightBaseItem)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
end

function slot0._customOnInit(slot0)
	slot0._resourceItem.simageicon = gohelper.findChildImage(slot0._resourceItem.go, "icon")
	slot0._resourceItem.govxvitality = gohelper.findChild(slot0._resourceItem.go, "vx_vitality")

	UISpriteSetMgr.instance:setRoomSprite(slot0._resourceItem.simageicon, "jianshezhi")
	slot0:_setShow(true)
end

function slot0._onClick(slot0)
	if RoomController.instance:isVisitMode() then
		return
	end

	slot1 = RoomMapModel.instance:getAllBuildDegree()
	slot2 = RoomConfig.instance:getCharacterLimitAddByBuildDegree(slot1)
	slot3, slot4, slot5 = RoomConfig.instance:getBuildBonusByBuildDegree(slot1)
	slot6 = ""
	slot6 = (slot4 <= 0 or GameUtil.getSubPlaceholderLuaLang(luaLang("room_topright_build_next"), {
		slot5,
		slot3 / 10,
		slot2,
		slot1,
		slot1 + slot4,
		RoomConfig.instance:getBuildBonusByBuildDegree(slot1 + slot4) / 10,
		RoomConfig.instance:getCharacterLimitAddByBuildDegree(slot1 + slot4)
	})) and GameUtil.getSubPlaceholderLuaLang(luaLang("room_topright_build_desc"), {
		slot5,
		slot3 / 10,
		slot2
	})

	ViewMgr.instance:openView(ViewName.RoomTipsView, {
		type = RoomTipsView.ViewType.BuildDegree
	})
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.ConfirmBackBlock, slot0._refreshUI, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.ConfirmBlock, slot0._refreshUI, slot0)
	slot0:addEventCb(RoomBuildingController.instance, RoomEvent.ConfirmBuilding, slot0._refreshUI, slot0)
	slot0:addEventCb(RoomBuildingController.instance, RoomEvent.UnUseBuilding, slot0._refreshUI, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.ClientPlaceBlock, slot0._refreshAddNumUI, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.ClientCancelBlock, slot0._refreshAddNumUI, slot0)
	slot0:addEventCb(RoomBuildingController.instance, RoomEvent.ClientPlaceBuilding, slot0._refreshAddNumUI, slot0)
	slot0:addEventCb(RoomBuildingController.instance, RoomEvent.ClientCancelBuilding, slot0._refreshAddNumUI, slot0)
	slot0:addEventCb(RoomLayoutController.instance, RoomEvent.UISwitchLayoutPlanBuildDegree, slot0._onSwitchBuildDegree, slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0._onSwitchBuildDegree(slot0)
	TaskDispatcher.runDelay(slot0._onSwitchLayoutAnim, slot0, 1)
end

function slot0._onSwitchLayoutAnim(slot0)
	gohelper.setActive(slot0._resourceItem.govxvitality, false)
	gohelper.setActive(slot0._resourceItem.govxvitality, true)
end

function slot0._getPlaceDegree(slot0)
	if not RoomController.instance:isEditMode() then
		return 0
	end

	if RoomMapBlockModel.instance:getTempBlockMO() then
		slot1 = 0 + (RoomConfig.instance:getPackageConfigByBlockId(slot2.blockId) and slot3.blockBuildDegree or 0)
	end

	if RoomMapBuildingModel.instance:getTempBuildingMO() and slot3.buildingState == RoomBuildingEnum.BuildingState.Temp then
		slot1 = slot1 + slot3.config.buildDegree
	end

	return slot1
end

function slot0._refreshUI(slot0)
	slot1 = RoomMapModel.instance:getAllBuildDegree()
	slot0._lastDegree = slot1
	slot0._resourceItem.txtquantity.text = GameUtil.numberDisplay(slot1)

	slot0:_refreshAddNumUI()

	if (slot0._lastDegree or slot1) < slot1 then
		gohelper.setActive(slot0._resourceItem.goeffect, false)
		gohelper.setActive(slot0._resourceItem.goeffect, true)

		if RoomConfig.instance:getBuildBonusByBuildDegree(slot2) < RoomConfig.instance:getBuildBonusByBuildDegree(slot1) then
			GameFacade.showToastWithIcon(ToastEnum.RoomEditDegreeBonusTip, ResUrl.getRoomImage("icon_ziyuan"), slot4 * 0.1)
		end
	end
end

function slot0._refreshAddNumUI(slot0)
	if slot0:_getPlaceDegree() > 0 then
		slot0._resourceItem.txtaddNum.text = "+" .. slot1
	end

	gohelper.setActive(slot0._resourceItem.txtaddNum, slot1 > 0)
end

function slot0._customOnDestory(slot0)
	TaskDispatcher.cancelTask(slot0._onSwitchLayoutAnim, slot0)
end

return slot0
