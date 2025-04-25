module("modules.logic.fight.model.data.FightDataCardHeatInfo", package.seeall)

slot0 = FightDataClass("FightDataCardHeatInfo")

function slot0.onConstructor(slot0, slot1)
	slot0.values = {}

	for slot5, slot6 in ipairs(slot1.values) do
		slot0.values[slot6.id] = FightDataCardHeatValue.New(slot6)
	end
end

return slot0
