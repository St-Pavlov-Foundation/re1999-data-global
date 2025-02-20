module("modules.logic.room.view.RoomViewUIBuildingItem", package.seeall)

slot0 = class("RoomViewUIBuildingItem", RoomViewUIBaseItem)

function slot0.ctor(slot0, slot1)
	slot0._buildingUid = slot1
end

function slot0._customOnInit(slot0)
	slot0._gomain = gohelper.findChild(slot0._gocontainer, "bubblebg/#go_main")
	slot0._imagebuildingicon = gohelper.findChildImage(slot0._gocontainer, "#image_buildingicon")
	slot0._txtnamecn = gohelper.findChildText(slot0._gocontainer, "bottom/txt_buildingName")
	slot0._goreddot = gohelper.findChild(slot0._gocontainer, "bottom/#go_reddot")

	if RoomMapBuildingModel.instance:getBuildingMOById(slot0._buildingUid) then
		slot2 = slot1.config
		slot3 = slot2.buildingType
		slot0._txtnamecn.text = slot2.name

		UISpriteSetMgr.instance:setCritterSprite(slot0._imagebuildingicon, RoomBuildingEnum.BuildingMapUiIcon[slot2.buildingType])
	end
end

function slot0._customAddEventListeners(slot0)
	slot0:refreshUI(true)
end

function slot0._customRemoveEventListeners(slot0)
end

function slot0._onClick(slot0, slot1, slot2)
	if RoomMapBuildingModel.instance:getBuildingMOById(slot0._buildingUid) then
		RoomMap3DClickController.instance:onBuildingEntityClick(slot3)
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end
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

	slot0:_setShow(true, slot1)
end

function slot0.getUI3DPos(slot0)
	if not slot0._scene.buildingmgr:getBuildingEntity(slot0._buildingUid, SceneTag.RoomBuilding) then
		slot0:_setShow(false, true)

		return Vector3.zero
	end

	if slot1:getHeadGO() then
		return slot2.transform.position
	end

	return slot1.goTrs.position
end

function slot0._customOnDestory(slot0)
end

return slot0
