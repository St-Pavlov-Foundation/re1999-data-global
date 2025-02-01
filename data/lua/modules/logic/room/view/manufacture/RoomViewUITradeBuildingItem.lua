module("modules.logic.room.view.manufacture.RoomViewUITradeBuildingItem", package.seeall)

slot0 = class("RoomViewUITradeBuildingItem", RoomViewUIBaseItem)

function slot0._customOnInit(slot0)
	slot0._gomain = gohelper.findChild(slot0._gocontainer, "bubblebg/#go_main")
	slot0._imagebuildingicon = gohelper.findChildImage(slot0._gocontainer, "#image_buildingicon")
	slot0._txtnamecn = gohelper.findChildText(slot0._gocontainer, "bottom/txt_buildingName")
	slot0._goreddot = gohelper.findChild(slot0._gocontainer, "bottom/#go_reddot")
	slot0._txtnamecn.text = luaLang("room_trade_name")

	UISpriteSetMgr.instance:setCritterSprite(slot0._imagebuildingicon, "critter_buildingicon_6")
	gohelper.setActive(slot0._gomain, true)
end

function slot0._customAddEventListeners(slot0)
	slot0:refreshUI(true)
end

function slot0._customRemoveEventListeners(slot0)
end

function slot0._onClick(slot0, slot1, slot2)
	ManufactureController.instance:openRoomTradeView()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function slot0.refreshUI(slot0, slot1)
	slot0:_refreshShow(slot1)
	slot0:_refreshPosition()
end

function slot0._refreshShow(slot0, slot1)
	if RoomBuildingController.instance:isBuildingListShow() or RoomCharacterController.instance:isCharacterListShow() then
		slot0:_setShow(false, slot1)

		return
	end

	if slot0._scene.camera:getCameraState() ~= RoomEnum.CameraState.Overlook and slot2 ~= RoomEnum.CameraState.OverlookAll then
		slot0:_setShow(false, slot1)

		return
	end

	if RoomMapController.instance:isInRoomInitBuildingViewCamera() then
		slot0:_setShow(false, slot1)

		return
	end

	slot0:_setShow(slot0:getBuildingEntity() ~= nil, slot1)
end

function slot0.getUI3DPos(slot0)
	if not slot0:getBuildingEntity() then
		slot0:_setShow(false, true)

		return Vector3.zero
	end

	slot4 = slot1:getHeadGO() and slot3.transform.position or slot1.containerGO.transform.position

	return RoomBendingHelper.worldToBendingSimple(Vector3(slot4.x, slot4.y, slot4.z))
end

function slot0.getBuildingEntity(slot0)
	slot1 = nil

	if ManufactureModel.instance:getTradeBuildingListInOrder() then
		slot1 = slot2[1].buildingUid
	end

	return slot0._scene.buildingmgr:getBuildingEntity(slot1, SceneTag.RoomBuilding)
end

function slot0._customOnDestory(slot0)
end

return slot0
