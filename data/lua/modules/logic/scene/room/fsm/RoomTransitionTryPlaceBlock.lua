module("modules.logic.scene.room.fsm.RoomTransitionTryPlaceBlock", package.seeall)

slot0 = class("RoomTransitionTryPlaceBlock", SimpleFSMBaseTransition)

function slot0.start(slot0)
	slot0._scene = GameSceneMgr.instance:getCurScene()
end

function slot0.check(slot0)
	return true
end

function slot0.onStart(slot0, slot1)
	slot0._param = slot1
	slot2 = slot0._param.hexPoint
	slot3 = slot0._param.rotate

	if RoomMapBlockModel.instance:getTempBlockMO() then
		if RoomInventoryBlockModel.instance:getSelectInventoryBlockMO() and slot5.id ~= slot4.id then
			slot0:_replaceBlock()
		else
			slot0:_changeBlock()
		end
	else
		slot0:_placeBlock()
	end

	RoomBlockController.instance:refreshResourceLight()
	RoomMapController.instance:dispatchEvent(RoomEvent.ClientPlaceBlock)

	if slot2 then
		if slot0:_isOutScreen(HexMath.hexToPosition(slot2, RoomBlockEnum.BlockSize)) then
			-- Nothing
		end

		if not slot4 then
			RoomMapModel.instance:saveCameraParam(slot0._scene.camera:getCameraParam())
		end

		slot0._scene.camera:tweenCamera({
			focusX = slot5.x,
			focusY = slot5.y
		}, nil, slot0.onDone, slot0)
	else
		slot0:onDone()
	end
end

function slot0._isOutScreen(slot0, slot1)
	return RoomHelper.isOutCameraFocus(slot1)
end

function slot0._replaceBlock(slot0)
	slot1 = RoomMapBlockModel.instance:getTempBlockMO()
	slot2 = slot1:getRiverCount()
	slot3 = RoomInventoryBlockModel.instance:getSelectInventoryBlockMO()

	if slot0._scene.mapmgr:getBlockEntity(slot1.id, SceneTag.RoomMapBlock) then
		slot0._scene.mapmgr:destroyBlock(slot4)
	end

	slot0._param.hexPoint = slot0._param.hexPoint or slot1.hexPoint

	RoomMapBlockModel.instance:removeTempBlockMO()
	slot0:_placeBlock()
end

function slot0._placeBlock(slot0)
	slot1 = slot0._param.hexPoint
	slot4 = RoomMapBlockModel.instance:addTempBlockMO(RoomInventoryBlockModel.instance:getSelectInventoryBlockMO(), slot1)

	RoomResourceModel.instance:clearLightResourcePoint()
	RoomMapBlockModel.instance:refreshNearRiver(slot1, 1)

	if RoomMapBlockModel.instance:getBlockMO(slot1.x, slot1.y) and slot0._scene.mapmgr:getBlockEntity(slot2.id, SceneTag.RoomEmptyBlock) then
		slot0._scene.mapmgr:destroyBlock(slot5)
	end

	slot6 = slot0._scene.mapmgr:spawnMapBlock(slot4)

	slot6:playAnim(RoomScenePreloader.ResAnim.ContainerPlay, "container_play")
	slot6:playVxWaterEffect()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_board_put)
	slot0:_refreshNearBlockEntity(false, slot1, true)
end

function slot0._changeBlock(slot0)
	slot3 = RoomMapBlockModel.instance:getTempBlockMO()
	slot1 = slot0._param.hexPoint or slot3.hexPoint
	slot2 = slot0._param.rotate or slot3.rotate
	slot5 = slot3.rotate
	slot6 = RoomMapBlockModel.instance:getBlockMO(slot1.x, slot1.y)
	slot7 = RoomInventoryBlockModel.instance:getSelectInventoryBlockMO()

	RoomMapBlockModel.instance:changeTempBlockMO(slot1, slot2)
	RoomInventoryBlockModel.instance:rotateFirst(slot2)
	RoomResourceModel.instance:clearLightResourcePoint()
	RoomMapBlockModel.instance:refreshNearRiver(slot1, 1)

	if HexPoint(slot3.hexPoint.x, slot3.hexPoint.y) ~= slot1 then
		RoomMapBlockModel.instance:refreshNearRiver(slot4, 1)
	end

	if slot4 ~= slot1 then
		if slot6 and slot0._scene.mapmgr:getBlockEntity(slot6.id, SceneTag.RoomEmptyBlock) then
			slot0._scene.mapmgr:destroyBlock(slot8)
		end

		if slot0._scene.mapmgr:getBlockEntity(slot3.id, SceneTag.RoomMapBlock) then
			slot0._scene.mapmgr:moveTo(slot9, slot1)
			slot9:playAnim(RoomScenePreloader.ResAnim.ContainerPlay, "container_play")
			slot9:playVxWaterEffect()
			AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_board_put)
		end

		slot0._scene.mapmgr:spawnMapBlock(RoomMapBlockModel.instance:getBlockMO(slot4.x, slot4.y))
	end

	if slot5 ~= slot2 then
		if slot0._scene.mapmgr:getBlockEntity(slot3.id, SceneTag.RoomMapBlock) then
			slot8:refreshRotation(true)
		end

		if slot0._scene.inventorymgr:getBlockEntity(slot7.id, SceneTag.RoomInventoryBlock) then
			slot9:refreshRotation(true)
		end
	end

	if slot0._scene.mapmgr:getBlockEntity(slot3.id, SceneTag.RoomMapBlock) then
		slot8:refreshBlock()
	end

	if slot4 ~= slot1 then
		slot0:_refreshNearBlockEntity(false, slot4, false)
	end

	slot0:_refreshNearBlockEntity(false, slot1, true)
end

function slot0._refreshNearBlockEntity(slot0, slot1, slot2, slot3)
	RoomBlockController.instance:refreshNearLand(slot2, slot3)
end

function slot0.stop(slot0)
end

function slot0.clear(slot0)
end

return slot0
