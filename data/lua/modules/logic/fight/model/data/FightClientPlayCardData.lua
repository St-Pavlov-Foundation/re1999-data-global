module("modules.logic.fight.model.data.FightClientPlayCardData", package.seeall)

slot0 = FightDataClass("FightClientPlayCardData", FightCardData)

function slot0.onConstructor(slot0, slot1, slot2)
	slot0.index = slot2
end

return slot0
