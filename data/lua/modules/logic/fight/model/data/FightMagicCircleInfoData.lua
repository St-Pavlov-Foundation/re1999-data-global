module("modules.logic.fight.model.data.FightMagicCircleInfoData", package.seeall)

slot0 = FightDataBase("FightMagicCircleInfoData")

function slot0.ctor(slot0, slot1)
	slot0.magicCircleId = slot1.magicCircleId
	slot0.round = slot1.round
	slot0.createUid = slot1.createUid
end

return slot0
