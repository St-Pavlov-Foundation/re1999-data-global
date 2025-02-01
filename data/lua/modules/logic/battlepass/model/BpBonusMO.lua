module("modules.logic.battlepass.model.BpBonusMO", package.seeall)

slot0 = pureTable("BpBonusMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.level
	slot0.level = slot1.level
	slot0.hasGetfreeBonus = slot1.hasGetfreeBonus
	slot0.hasGetPayBonus = slot1.hasGetPayBonus
	slot0.hasGetSpfreeBonus = slot1.hasGetSpfreeBonus
	slot0.hasGetSpPayBonus = slot1.hasGetSpPayBonus
end

function slot0.updateServerInfo(slot0, slot1)
	if slot1:HasField("hasGetfreeBonus") then
		slot0.hasGetfreeBonus = slot1.hasGetfreeBonus
	end

	if slot1:HasField("hasGetPayBonus") then
		slot0.hasGetPayBonus = slot1.hasGetPayBonus
	end

	if slot1:HasField("hasGetSpfreeBonus") then
		slot0.hasGetSpfreeBonus = slot1.hasGetSpfreeBonus
	end

	if slot1:HasField("hasGetSpPayBonus") then
		slot0.hasGetSpPayBonus = slot1.hasGetSpPayBonus
	end
end

return slot0
