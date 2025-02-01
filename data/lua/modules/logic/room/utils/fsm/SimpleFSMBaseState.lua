module("modules.logic.room.utils.fsm.SimpleFSMBaseState", package.seeall)

slot0 = class("SimpleFSMBaseState")

function slot0.ctor(slot0, slot1)
	slot0.name = slot1
	slot0.fsm = nil
	slot0.context = nil
end

function slot0.register(slot0, slot1, slot2)
	slot0.fsm = slot1
	slot0.context = slot2
end

function slot0.start(slot0)
end

function slot0.onEnter(slot0)
	RoomMapController.instance:dispatchEvent(RoomEvent.FSMEnterState, slot0.name)
end

function slot0.onLeave(slot0)
	RoomMapController.instance:dispatchEvent(RoomEvent.FSMLeaveState, slot0.name)
end

function slot0.stop(slot0)
end

function slot0.clear(slot0)
end

return slot0
