module("modules.logic.rouge.model.rpcmo.RougeHeroInfoMO", package.seeall)

slot0 = pureTable("RougeHeroInfoMO")

function slot0.init(slot0, slot1)
	slot0:update(slot1)
end

function slot0.update(slot0, slot1)
	slot0.heroId = slot1.heroId
	slot0.stressValue = slot1.stressValue
	slot0.stressValueLimit = slot1.stressValueLimit
end

function slot0.getStressValue(slot0)
	return slot0.stressValue or 0
end

function slot0.getStressRange(slot0)
	return 0, slot0:getStressValueLimit()
end

function slot0.getStressValueLimit(slot0)
	return slot0.stressValueLimit or 0
end

return slot0
