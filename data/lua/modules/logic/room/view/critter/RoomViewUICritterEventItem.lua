module("modules.logic.room.view.critter.RoomViewUICritterEventItem", package.seeall)

slot0 = class("RoomViewUICritterEventItem", RoomViewUIBaseItem)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0)

	slot0._showCameraStateDict = {
		[RoomEnum.CameraState.OverlookAll] = true
	}
	slot0.critterUid = slot1
	slot0.critterMO = CritterModel.instance:getCritterMOByUid(slot0.critterUid)
	slot0.eventType = CritterHelper.getEventTypeByCritterMO(slot0.critterMO)

	if not slot0.eventType then
		slot0.eventType = CritterEnum.CritterItemEventType.SurpriseCollect
	end
end

function slot0._customOnInit(slot0)
	slot0._gobg = gohelper.findChildImage(slot0._gocontainer, "bg")
	slot0._gocrittericon = gohelper.findChild(slot0._gocontainer, "#go_crittericon")
	slot0._goEventBubble = gohelper.findChild(slot0._gocontainer, "#image_bubble")
	slot0._imageEventBubble = gohelper.findChildImage(slot0._gocontainer, "#image_bubble")
	slot0._goPropBubble = gohelper.findChild(slot0._gocontainer, "bubblebg")
	slot0._simageProp = gohelper.findChildSingleImage(slot0._gocontainer, "#image_bubble")
end

function slot0._customAddEventListeners(slot0)
	RoomCharacterController.instance:registerCallback(RoomEvent.CharacterPositionChanged, slot0._characterPositionChanged, slot0)
	slot0:setIconUI()
	slot0:refreshUI(true)
end

function slot0._customRemoveEventListeners(slot0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.CharacterPositionChanged, slot0._characterPositionChanged, slot0)
end

function slot0._characterPositionChanged(slot0, slot1)
	if slot0.critterMO and slot0.critterMO.trainInfo.heroId ~= slot1 then
		return
	end

	slot0:_refreshPosition()
end

function slot0._onClick(slot0, slot1, slot2)
	if slot0.eventType == CritterEnum.CritterItemEventType.HasTrainEvent then
		slot0:_clickTrainEvent()
	end

	if slot0.eventType == CritterEnum.CritterItemEventType.NoMoodWork then
		slot0:_clickNoMoodWorking()
	end
end

function slot0._clickNoMoodWorking(slot0)
	RoomMap3DClickController.instance:onBuildingEntityClick(RoomMapBuildingModel.instance:getBuildingMOById(ManufactureModel.instance:getCritterWorkingBuilding(slot0.critterUid)))
end

function slot0._clickTrainEvent(slot0)
	if ViewMgr.instance:isOpen(ViewName.RoomCritterBuildingView) then
		RoomCritterController.instance:openTrainEventView(slot0.critterUid)
	else
		ManufactureController.instance:openCritterBuildingView(nil, RoomCritterBuildingViewContainer.SubViewTabId.Training, slot0.critterUid)
	end
end

slot1 = {
	[CritterEnum.CritterItemEventType.HasTrainEvent] = "critter_mapbubble1",
	[CritterEnum.CritterItemEventType.TrainEventComplete] = "critter_mapbubble2",
	[CritterEnum.CritterItemEventType.NoMoodWork] = "critter_mapbubble3"
}

function slot0.setIconUI(slot0)
	if not slot0.critterIcon then
		slot0.critterIcon = IconMgr.instance:getCommonCritterIcon(slot0._gocrittericon)
	end

	slot0.critterIcon:onUpdateMO(slot0.critterMO)

	if slot0.eventType ~= CritterEnum.CritterItemEventType.SurpriseCollect then
		UISpriteSetMgr.instance:setCritterSprite(slot0._imageEventBubble, uv0[slot0.eventType])
	end

	gohelper.setActive(slot0._goPropBubble, slot1)
	gohelper.setActive(slot0._goEventBubble, not slot1)
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

	if RoomMapController.instance:isInRoomInitBuildingViewCamera() or not slot0._showCameraStateDict[slot0._scene.camera:getCameraState()] then
		slot0:_setShow(false, slot1)

		return
	end

	slot0:_setShow(true, slot1)
end

function slot0.getUI3DPos(slot0)
	if not slot0:getEventCritterEntity() then
		return Vector3.zero
	end

	if not (slot1.critterspine:getMountheadGOTrs() or slot1.goTrs) then
		return Vector3.zero
	end

	slot3, slot4, slot5 = transformhelper.getPos(slot2)

	return Vector3(slot3, slot4, slot5)
end

function slot0.getEventCritterEntity(slot0)
	slot1 = nil

	return (not slot0.critterMO:isCultivating() or slot0._scene.crittermgr:getCritterEntity(slot0.critterUid, SceneTag.RoomCharacter)) and slot0._scene.buildingcrittermgr:getCritterEntity(slot0.critterUid, SceneTag.RoomCharacter)
end

function slot0._customOnDestory(slot0)
	slot0._simageProp:UnLoadImage()
end

slot0.prefabPath = "ui/viewres/room/sceneui/roomscenecritterheadui.prefab"

return slot0
