module("modules.logic.critter.model.CritterSummonMO", package.seeall)

slot0 = pureTable("CritterSummonMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.id or slot1.poolId
	slot0.poolId = slot1.poolId
	slot0.hasSummonCritter = {}

	for slot5 = 1, #slot1.hasSummonCritter do
		slot6 = slot1.hasSummonCritter[slot5]
		slot0.hasSummonCritter[slot6.materialId] = slot6.quantity
	end

	slot0.critterMos = {}

	if CritterConfig.instance:getCritterSummonPoolCfg(slot1.poolId) then
		for slot6, slot7 in pairs(slot2) do
			for slot12, slot13 in pairs(GameUtil.splitString2(slot7.critterIds, true)) do
				slot14 = CritterSummonPoolMO.New()

				slot14:init(slot7.rare, slot15, slot13[2], slot0.hasSummonCritter[slot13[1]] or 0)
				table.insert(slot0.critterMos, slot14)
			end
		end
	end
end

function slot0.onRefresh(slot0, slot1)
	slot0.hasSummonCritter = {}

	for slot5 = 1, #slot1 do
		slot6 = slot1[slot5]
		slot7 = slot6.materialId
		slot0.hasSummonCritter[slot7] = slot6.quantity

		if slot0:getCritterMoById(slot7) then
			slot9:onRefreshPoolCount(slot8)
		end
	end
end

function slot0.getCritterMoById(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.critterMos) do
		if slot6.critterId == slot1 then
			return slot6
		end
	end
end

function slot0.getCritterMos(slot0)
	return slot0.critterMos
end

function slot0.getCritterCount(slot0)
	for slot5, slot6 in ipairs(slot0.critterMos) do
		slot1 = 0 + slot6:getPoolCount()
	end

	return slot1
end

return slot0
