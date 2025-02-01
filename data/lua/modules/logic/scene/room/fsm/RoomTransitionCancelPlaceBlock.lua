module("modules.logic.scene.room.fsm.RoomTransitionCancelPlaceBlock", package.seeall)

slot0 = class("RoomTransitionCancelPlaceBlock", JompFSMBaseTransition)

function slot0.start(slot0)
	slot0._scene = GameSceneMgr.instance:getCurScene()
end

function slot0.check(slot0)
	return true
end

function slot0.onStart(slot0, slot1)
	slot0._param = slot1

	if not RoomMapBlockModel.instance:getTempBlockMO() then
		slot0:onDone()

		return
	end

	RoomMapBlockModel.instance:removeTempBlockMO()
	RoomResourceModel.instance:clearLightResourcePoint()
	RoomMapBlockModel.instance:refreshNearRiver(slot2.hexPoint, 1)

	if slot2 then
		if slot0._scene.mapmgr:getBlockEntity(slot2.id, SceneTag.RoomMapBlock) then
			slot5:playAnim(RoomScenePreloader.ResAnim.ContainerPlay, "container_donw")
			slot4:removeUnitData(SceneTag.RoomMapBlock, slot2.id)
			slot5:removeEvent()
			TaskDispatcher.runDelay(function ()
				uv0:destroyUnit(uv1)
			end, slot0, 0.3333333333333333)
		end
	end

	slot0._scene.mapmgr:spawnMapBlock(RoomMapBlockModel.instance:getBlockMO(slot3.x, slot3.y))
	RoomBlockController.instance:refreshNearLand(slot3, true)
	RoomBlockController.instance:refreshResourceLight()
	RoomMapController.instance:dispatchEvent(RoomEvent.ClientCancelBlock)

	slot5 = RoomMapModel.instance:getCameraParam()
	slot6 = slot0._scene.camera:getCameraParam()

	if {} then
		slot0._scene.camera:tweenCamera(slot7, nil, slot0.onDone, slot0)
		RoomMapModel.instance:clearCameraParam()
	else
		slot0:onDone()
	end
end

function slot0.stop(slot0)
end

function slot0.clear(slot0)
end

return slot0
