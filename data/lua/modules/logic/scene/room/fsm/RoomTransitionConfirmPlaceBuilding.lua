module("modules.logic.scene.room.fsm.RoomTransitionConfirmPlaceBuilding", package.seeall)

slot0 = class("RoomTransitionConfirmPlaceBuilding", SimpleFSMBaseTransition)

function slot0.start(slot0)
	slot0._scene = GameSceneMgr.instance:getCurScene()
end

function slot0.check(slot0)
	return true
end

function slot0.onStart(slot0, slot1)
	slot0._param = slot1
	slot2 = slot0._param.buildingInfo
	slot3 = slot0._param.tempBuildingMO

	RoomBuildingController.instance:addWaitRefreshBuildingNearBlock(slot3.buildingId, slot3.hexPoint, slot3.rotate)

	if slot0._scene.buildingmgr:getBuildingEntity(slot3.id, SceneTag.RoomBuilding) then
		slot0._scene.buildingmgr:moveTo(slot4, slot3.hexPoint)
		slot4:refreshBuilding()
		slot4:refreshRotation()
		slot4:playSmokeEffect()
	end

	RoomBuildingController.instance:cancelPressBuilding()
	RoomResourceModel.instance:clearLightResourcePoint()
	RoomBuildingController.instance:dispatchEvent(RoomEvent.BuildingUIRefreshUI, slot3.id)
	RoomShowBuildingListModel.instance:clearSelect()
	RoomBuildingController.instance:dispatchEvent(RoomEvent.ConfirmBuilding, slot2.defineId)
	RoomMapController.instance:dispatchEvent(RoomEvent.RefreshResourceUIShow)
	slot0:onDone()
	RoomMapController.instance:dispatchEvent(RoomEvent.BuildingCanConfirm)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_board_fix)
	RoomBuildingController.instance:refreshBuildingOccupy()
end

function slot0.stop(slot0)
end

function slot0.clear(slot0)
end

return slot0
