module("modules.logic.room.utils.fsm.SimpleFSMBaseTransition", package.seeall)

slot0 = class("SimpleFSMBaseTransition")

function slot0.ctor(slot0, slot1, slot2, slot3)
	slot0.name = string.format("%s_to_%s_by_%s", slot1, slot2, slot3)
	slot0.fromStateName = slot1
	slot0.toStateName = slot2
	slot0.eventId = slot3
	slot0.fsm = nil
	slot0.context = nil
end

function slot0.register(slot0, slot1, slot2)
	slot0.fsm = slot1
	slot0.context = slot2
end

function slot0.onDone(slot0)
	slot0.fsm:endTransition(slot0.toStateName)
end

function slot0.start(slot0)
end

function slot0.check(slot0)
	return true
end

function slot0.onStart(slot0, slot1)
	slot0:onDone()
end

function slot0.stop(slot0)
end

function slot0.clear(slot0)
end

return slot0
