module("modules.logic.activity.model.ActivityType101SpInfoMo", package.seeall)

slot0 = pureTable("ActivityType101SpInfoMo")
slot1 = 0
slot2 = 1
slot3 = 2

function slot0.ctor(slot0)
	slot0.id = 0
	slot0.state = uv0
end

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.state = slot1.state
end

function slot0.isNotCompleted(slot0)
	return slot0.state == uv0
end

function slot0.isAvailable(slot0)
	return slot0.state == uv0
end

function slot0.isReceived(slot0)
	return slot0.state == uv0
end

function slot0.isNone(slot0)
	return slot0.state == uv0
end

function slot0.setState_Received(slot0)
	slot0.state = uv0
end

return slot0
