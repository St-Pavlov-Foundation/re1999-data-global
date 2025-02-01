module("modules.logic.critter.model.CritterSummonPoolMO", package.seeall)

slot0 = pureTable("CritterSummonPoolMO")

function slot0.init(slot0, slot1, slot2, slot3, slot4)
	slot0.rare = slot1
	slot0.uid = "0"
	slot0.critterId = slot2
	slot0.count = slot3
	slot0.poolCount = slot3 - slot4
	slot0.co = CritterConfig.instance:getCritterCfg(slot2)

	slot0:initCritterMo()
end

function slot0.initCritterMo(slot0)
	slot0.critterMo = CritterMO.New()
	slot1 = 0
	slot2 = 0
	slot3 = 0
	slot4 = 0
	slot5 = 0
	slot6 = 0
	slot7 = {}

	if slot0.co then
		if not string.nilorempty(slot0.co.baseAttribute) then
			slot1 = GameUtil.splitString2(slot0.co.baseAttribute, true)[1][2] or 0
			slot2 = slot8[2][2] or 0
			slot3 = slot8[3][2] or 0
		end

		if not string.nilorempty(slot0.co.baseAttribute) then
			slot4 = GameUtil.splitString2(slot0.co.attributeIncrRate, true)[1][2] or 0
			slot5 = slot8[2][2] or 0
			slot6 = slot8[3][2] or 0
		end

		slot7 = {
			tags = {
				slot0.co.raceTag
			}
		}
	end

	slot0.critterMo:init({
		specialSkin = false,
		id = slot0.uid,
		uid = slot0.uid,
		defineId = slot0.critterId,
		efficiency = slot1,
		patience = slot2,
		lucky = slot3,
		efficiencyIncrRate = slot4,
		patienceIncrRate = slot5,
		luckyIncrRate = slot6,
		tagAttributeRates = {},
		skillInfo = slot7
	})
end

function slot0.getCritterMo(slot0)
	return slot0.critterMo
end

function slot0.onRefreshPoolCount(slot0, slot1)
	slot0.poolCount = slot0.count - slot1
end

function slot0.getPoolCount(slot0)
	return slot0.poolCount
end

function slot0.isFullPool(slot0)
	return slot0.count == slot0.poolCount
end

return slot0
