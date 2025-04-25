module("modules.logic.fight.model.data.FightDataCardHeatValue", package.seeall)

slot0 = FightDataClass("FightDataCardHeatValue")

function slot0.onConstructor(slot0, slot1)
	slot0.id = slot1.id
	slot0.upperLimit = slot1.upperLimit
	slot0.lowerLimit = slot1.lowerLimit
	slot0.value = slot1.value
	slot0.changeValue = slot1.changeValue
end

return slot0
