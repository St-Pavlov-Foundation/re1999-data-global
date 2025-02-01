module("modules.logic.summon.model.SummonLuckyBagMO", package.seeall)

slot0 = pureTable("SummonLuckyBagMO")

function slot0.ctor(slot0)
	slot0.luckyBagId = 0
	slot0.summonTimes = 0
	slot0.openedTimes = 0
end

function slot0.update(slot0, slot1)
	slot0.luckyBagId = slot1.luckyBagId or 0
	slot0.summonTimes = slot1.count or 0
	slot0.openedTimes = slot1.openLBTimes or 0
end

function slot0.isGot(slot0)
	return slot0.luckyBagId ~= nil and slot0.luckyBagId ~= 0 or slot0.openedTimes > 0
end

function slot0.isOpened(slot0)
	return slot0.openedTimes > 0
end

return slot0
