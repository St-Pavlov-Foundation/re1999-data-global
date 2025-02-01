module("modules.logic.versionactivity2_2.tianshinana.model.TianShiNaNaMapUnitMo", package.seeall)

slot0 = class("TianShiNaNaMapUnitMo")

function slot0.init(slot0, slot1)
	slot0.co = slot1
	slot0.x = slot1.x
	slot0.y = slot1.y
	slot0.dir = slot1.dir
	slot0.isActive = false
end

function slot0.updatePos(slot0, slot1, slot2, slot3)
	slot0.x = slot1
	slot0.y = slot2
	slot0.dir = slot3
end

function slot0.setActive(slot0, slot1)
	slot0.isActive = slot1
end

function slot0.canWalk(slot0)
	return slot0.co.walkable
end

function slot0.isPosEqual(slot0, slot1, slot2)
	return slot1 == slot0.x and slot2 == slot0.y
end

return slot0
