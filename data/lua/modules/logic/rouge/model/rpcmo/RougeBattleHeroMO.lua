module("modules.logic.rouge.model.rpcmo.RougeBattleHeroMO", package.seeall)

slot0 = pureTable("RougeBattleHeroMO")

function slot0.init(slot0, slot1)
	slot0.index = slot1.index
	slot0.heroId = slot1.heroId
	slot0.equipUid = slot1.equipUid
	slot0.supportHeroId = slot1.supportHeroId
	slot0.supportHeroSkill = slot1.supportHeroSkill
end

return slot0
