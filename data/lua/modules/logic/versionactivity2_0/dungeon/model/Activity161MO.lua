module("modules.logic.versionactivity2_0.dungeon.model.Activity161MO", package.seeall)

slot0 = pureTable("Activity161MO")

function slot0.ctor(slot0)
	slot0.id = 0
	slot0.state = 0
	slot0.cdBeginTime = nil
	slot0.config = nil
end

function slot0.init(slot0, slot1, slot2)
	slot0.id = slot1.id
	slot0.state = slot1.state
	slot0.cdBeginTime = tonumber(slot1.mainElementCdBeginTime)
	slot0.config = slot2
end

function slot0.isInCdTime(slot0)
	if slot0.cdBeginTime and slot0.cdBeginTime > 0 then
		return ServerTime.now() - slot0.cdBeginTime / 1000 < slot0.config.mainElementCd
	end

	return false
end

function slot0.getRemainUnlockTime(slot0)
	if slot0.cdBeginTime and slot0.cdBeginTime > 0 then
		return Mathf.Max(slot0.cdBeginTime / 1000 + slot0.config.mainElementCd - ServerTime.now(), 0)
	end

	return 0
end

function slot0.updateInfo(slot0, slot1)
	slot0.state = slot1.state
	slot0.cdBeginTime = tonumber(slot1.mainElementCdBeginTime)
end

return slot0
