module("modules.logic.scene.room.fsm.RoomTransitionCancelBackBlock", package.seeall)

slot0 = class("RoomTransitionCancelBackBlock", JompFSMBaseTransition)

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

	for slot7 = 1, #RoomMapBlockModel.instance:getBackBlockModel():getList() do
		slot8 = slot3[slot7]

		slot8:setOpState(RoomBlockEnum.OpState.Normal)

		if slot0._scene.mapmgr:getBlockEntity(slot8.id, SceneTag.RoomMapBlock) then
			slot9:refreshBlock()
		end
	end

	slot2:clear()
	slot0:onDone()
	RoomMapController.instance:dispatchEvent(RoomEvent.ClientCancelBackBlock)
end

function slot0.stop(slot0)
end

function slot0.clear(slot0)
end

return slot0
