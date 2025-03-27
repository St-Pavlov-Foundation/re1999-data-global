module("modules.logic.versionactivity2_4.pinball.entity.PinballTriggerBlackHoleEntity", package.seeall)

slot0 = class("PinballTriggerBlackHoleEntity", PinballTriggerEntity)

function slot0.onInitByCo(slot0)
	slot0.groupId = tonumber(slot0.spData) or 0
end

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)
	gohelper.setActive(gohelper.findChild(slot1, "vx_blackhole"), true)
end

function slot0.isBounce(slot0)
	return false
end

function slot0.onHitEnter(slot0, slot1, slot2, slot3, slot4)
	if not PinballEntityMgr.instance:getEntity(slot1) or slot5.inBlackHoleId then
		return
	end

	slot6 = nil

	for slot10, slot11 in pairs(PinballEntityMgr.instance:getAllEntity()) do
		if slot11 ~= slot0 and slot11.unitType == slot0.unitType and slot11.groupId == slot0.groupId then
			slot6 = slot11

			break
		end
	end

	if slot6 then
		slot5.x = slot6.x
		slot5.y = slot6.y

		slot5:tick(0)

		slot5.inBlackHoleId = slot0.id

		slot5:onEnterHole()
	end
end

function slot0.onHitExit(slot0, slot1)
	if not PinballEntityMgr.instance:getEntity(slot1) or not slot2.inBlackHoleId or slot2.inBlackHoleId == slot0.id then
		return
	end

	slot2.inBlackHoleId = nil

	slot2:onExitHole()
end

return slot0
