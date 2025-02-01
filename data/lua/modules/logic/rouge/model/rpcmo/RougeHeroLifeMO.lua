module("modules.logic.rouge.model.rpcmo.RougeHeroLifeMO", package.seeall)

slot0 = pureTable("RougeHeroLifeMO")

function slot0.init(slot0, slot1)
	slot0.heroId = slot1.heroId
	slot0.life = slot1.life
end

function slot0.update(slot0, slot1)
	slot0.heroId = slot1.heroId
	slot0.life = slot1.life
end

return slot0
