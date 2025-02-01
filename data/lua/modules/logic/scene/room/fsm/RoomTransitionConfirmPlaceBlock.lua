module("modules.logic.scene.room.fsm.RoomTransitionConfirmPlaceBlock", package.seeall)

slot0 = class("RoomTransitionConfirmPlaceBlock", JompFSMBaseTransition)

function slot0.start(slot0)
	slot0._scene = GameSceneMgr.instance:getCurScene()
end

function slot0.check(slot0)
	return true
end

function slot0.onStart(slot0, slot1)
	slot0._param = slot1
	slot0._animDone = false

	for slot8, slot9 in ipairs(slot0._param.tempBlockMO.hexPoint:getInRanges(RoomBlockEnum.EmptyBlockDistanceStyleCount, true)) do
		if RoomMapBlockModel.instance:getBlockMO(slot9.x, slot9.y) and slot10.blockState == RoomBlockEnum.BlockState.Water then
			slot11 = slot0._scene.mapmgr:getBlockEntity(slot10.id, SceneTag.RoomEmptyBlock) or slot0._scene.mapmgr:spawnMapBlock(slot10)
		end
	end

	if slot0._scene.mapmgr:getBlockEntity(slot2.id, SceneTag.RoomMapBlock) then
		slot5:refreshBlock()
		slot5:refreshRotation()
		slot5:playSmokeEffect()
		slot5:playAmbientAudio()
	end

	for slot10, slot11 in ipairs(slot3:getNeighbors()) do
		if RoomMapBlockModel.instance:getBlockMO(slot11.x, slot11.y) and slot12.blockState == RoomBlockEnum.BlockState.Map and slot0:_isNeighborsCanAnim(slot11.x, slot11.y) and slot0._scene.mapmgr:getBlockEntity(slot12.id, SceneTag.RoomMapBlock) then
			slot13:playAnim(RoomScenePreloader.ResAnim.ContainerUp, "container_up")
		end
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.UpdateWater)
	RoomMapController.instance:dispatchEvent(RoomEvent.UpdateInventoryCount)
	slot0._scene.inventorymgr:playForwardAnim(slot0._animCallback, slot0)
	RoomBlockController.instance:refreshResourceLight()
	RoomMapController.instance:dispatchEvent(RoomEvent.ConfirmBlock)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_board_fix)
end

function slot0._isNeighborsCanAnim(slot0, slot1, slot2)
	if RoomMapBuildingModel.instance:getBuildingParam(slot1, slot2) and RoomBuildingEnum.NotPlaceBlockAnimDict[slot3.buildingId] then
		return false
	end

	return true
end

function slot0._animCallback(slot0)
	RoomBlockHelper.refreshBlockEntity(RoomBlockHelper.getNearBlockEntity(false, slot0._param.tempBlockMO.hexPoint, 1, true), "refreshSideShow")
	slot0._scene.inventorymgr:moveForward()

	slot0._animDone = true

	slot0:_checkDone()
end

function slot0._checkDone(slot0)
	if slot0._animDone then
		RoomMapController.instance:dispatchEvent(RoomEvent.OnUseBlock, slot0._param.tempBlockMO.id)
		slot0:onDone()
	end
end

function slot0.stop(slot0)
end

function slot0.clear(slot0)
end

return slot0
