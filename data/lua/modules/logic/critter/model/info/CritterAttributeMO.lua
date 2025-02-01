module("modules.logic.critter.model.info.CritterAttributeMO", package.seeall)

slot0 = pureTable("CritterAttributeMO")
slot1 = {}

function slot0.init(slot0, slot1)
	slot1 = slot1 or uv0
	slot0.attributeId = slot1.attributeId or 0
	slot0.value = slot1.value and math.floor(slot1.value / 10000) or 0
end

function slot0.setAttr(slot0, slot1, slot2)
	slot0.attributeId = slot1
	slot0.value = slot2
end

function slot0.getValueNum(slot0)
	return slot0.value
end

return slot0
