module("modules.logic.room.utils.fsm.JompFSMBaseTransition", package.seeall)

slot0 = class("JompFSMBaseTransition", SimpleFSMBaseTransition)

function slot0.ctor(slot0, slot1, slot2, slot3, slot4)
	uv0.super.ctor(slot0, slot1, slot2, slot3)

	slot0.jompStateNames = {}

	tabletool.addValues(slot0.jompStateNames, slot4)
end

function slot0.onDone(slot0)
	slot1 = nil

	for slot5 = 1, #slot0.jompStateNames do
		if slot0:checkJompState(slot0.jompStateNames[slot5]) then
			slot1 = slot0.jompStateNames[slot5]

			break
		end
	end

	slot0.fsm:endTransition(slot1 or slot0.toStateName)
end

function slot0.checkJompState(slot0, slot1)
	return slot1 and RoomFSMHelper.isCanJompTo(slot1)
end

return slot0
