module("modules.logic.room.utils.fsm.SimpleFSM", package.seeall)

slot0 = class("SimpleFSM")

function slot0.ctor(slot0, slot1)
	slot0.context = slot1
	slot0.states = {}
	slot0.transitions = {}
	slot0.isRunning = false
	slot0.isTransitioning = false
	slot0.curStateName = nil
end

function slot0.registerState(slot0, slot1)
	if slot1.fsm then
		return
	end

	if slot0.states[slot1.name] then
		return
	end

	slot1:register(slot0, slot0.context)

	slot0.states[slot1.name] = slot1
end

function slot0.registerTransition(slot0, slot1)
	if slot1.fsm then
		return
	end

	if slot0.transitions[slot1.name] then
		return
	end

	if string.nilorempty(slot1.fromStateName) or string.nilorempty(slot1.toStateName) or not slot1.eventId then
		return
	end

	if not slot0.states[slot1.fromStateName] or not slot0.states[slot1.toStateName] then
		return
	end

	for slot5, slot6 in pairs(slot0.transitions) do
		if slot6.fromStateName == slot1.fromStateName and slot6.eventId == slot1.eventId then
			return
		end
	end

	slot1:register(slot0, slot0.context)

	slot0.transitions[slot1.name] = slot1
end

function slot0.triggerEvent(slot0, slot1, slot2)
	if not slot0.isRunning or slot0.isTransitioning then
		return
	end

	if string.nilorempty(slot0.curStateName) then
		return
	end

	for slot6, slot7 in pairs(slot0.transitions) do
		if slot7.fromStateName == slot0.curStateName and slot7.eventId == slot1 and slot7:check() then
			slot0:startTransition(slot7, slot2)

			break
		end
	end
end

function slot0.startTransition(slot0, slot1, slot2)
	slot0.isTransitioning = true

	slot0:leaveState(slot0.curStateName)
	slot1:onStart(slot2)
end

function slot0.endTransition(slot0, slot1)
	slot0.isTransitioning = false

	slot0:enterState(slot1)
end

function slot0.enterState(slot0, slot1)
	slot0.curStateName = slot1

	slot0.states[slot0.curStateName]:onEnter()
end

function slot0.leaveState(slot0)
	slot0.curStateName = nil

	slot0.states[slot0.curStateName]:onLeave()
end

function slot0.start(slot0, slot1)
	if slot0.isRunning then
		return
	end

	if string.nilorempty(slot1) then
		return
	end

	for slot5, slot6 in pairs(slot0.states) do
		slot6:start()
	end

	for slot5, slot6 in pairs(slot0.transitions) do
		slot6:start()
	end

	slot0.isRunning = true
	slot0.isTransitioning = false

	slot0:enterState(slot1)
end

function slot0.stop(slot0)
	if not slot0.isRunning then
		return
	end

	for slot4, slot5 in pairs(slot0.states) do
		slot5:stop()
	end

	for slot4, slot5 in pairs(slot0.transitions) do
		slot5:stop()
	end

	slot0.isRunning = false
	slot0.isTransitioning = false
	slot0.curStateName = nil
end

function slot0.clear(slot0)
	for slot4, slot5 in pairs(slot0.states) do
		slot5:clear()
	end

	for slot4, slot5 in pairs(slot0.transitions) do
		slot5:clear()
	end
end

return slot0
