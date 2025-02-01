module("modules.logic.scene.room.fsm.RoomShowTimeCharacterBuilding", package.seeall)

slot0 = class("RoomShowTimeCharacterBuilding", JompFSMBaseTransition)

function slot0.start(slot0)
end

function slot0.check(slot0)
	return true
end

function slot0.onStart(slot0, slot1)
	slot0._interationId = slot1.id
	slot0._actionDict = slot0._actionDict or {}

	if not slot0._actionDict[slot0._interationId] then
		slot0._actionDict[slot0._interationId] = RoomActionShowTimeCharacterBuilding.New(slot0)
	end

	slot2:start(slot1)
	slot0:onDone()
end

function slot0.endState(slot0)
	slot0.fsm:endTransition(slot0.fromStateName)
end

function slot0.stop(slot0)
	slot0:endState()
end

function slot0.clear(slot0)
	slot0:endState()
end

return slot0
