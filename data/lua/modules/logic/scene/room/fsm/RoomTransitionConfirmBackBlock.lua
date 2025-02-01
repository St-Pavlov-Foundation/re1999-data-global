module("modules.logic.scene.room.fsm.RoomTransitionConfirmBackBlock", package.seeall)

slot0 = class("RoomTransitionConfirmBackBlock", JompFSMBaseTransition)

function slot0.start(slot0)
	slot0._scene = GameSceneMgr.instance:getCurScene()
	slot0._opToDis = {
		[RoomBlockEnum.OpState.Normal] = RoomBlockEnum.OpState.Back,
		[RoomBlockEnum.OpState.Back] = RoomBlockEnum.OpState.Normal
	}
end

function slot0.check(slot0)
	return true
end

function slot0.onStart(slot0, slot1)
	slot0._param = slot1

	for slot6 = 1, #slot1.blockMOList do
		if slot0._scene.mapmgr:getBlockEntity(slot2[slot6].id, SceneTag.RoomMapBlock) then
			slot0._scene.mapmgr:destroyBlock(slot8)

			slot9 = slot7.hexPoint

			slot0._scene.mapmgr:spawnMapBlock(RoomMapBlockModel.instance:getBlockMO(slot9.x, slot9.y))
		end
	end

	slot0:onDone()
	slot0._scene.inventorymgr:moveForward()
	RoomMapController.instance:dispatchEvent(RoomEvent.UpdateWater)
	RoomMapController.instance:dispatchEvent(RoomEvent.UpdateInventoryCount)
	RoomMapController.instance:dispatchEvent(RoomEvent.ConfirmBackBlock)

	slot3 = {}
	slot4 = {}

	for slot8 = 1, #slot2 do
		slot10 = slot2[slot8].hexPoint

		slot0:_addValues(slot3, RoomBlockHelper.getNearBlockEntity(false, slot10, 1, true))
		slot0:_addValues(slot4, RoomBlockHelper.getNearBlockEntity(true, slot10, 1, true))
		RoomMapBlockModel.instance:refreshNearRiver(slot10, 1)
	end

	RoomBlockHelper.refreshBlockEntity(slot3, "refreshBlock")
	RoomBlockHelper.refreshBlockEntity(slot4, "refreshWaveEffect")
end

function slot0._addValues(slot0, slot1, slot2)
	if slot1 and slot2 then
		for slot6, slot7 in ipairs(slot2) do
			if not tabletool.indexOf(slot1, slot7) then
				table.insert(slot1, slot7)
			end
		end
	end
end

function slot0.stop(slot0)
end

function slot0.clear(slot0)
end

return slot0
