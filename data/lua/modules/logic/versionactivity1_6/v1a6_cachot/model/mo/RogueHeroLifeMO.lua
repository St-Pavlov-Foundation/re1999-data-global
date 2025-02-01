module("modules.logic.versionactivity1_6.v1a6_cachot.model.mo.RogueHeroLifeMO", package.seeall)

slot0 = pureTable("RogueHeroLifeMO")

function slot0.init(slot0, slot1)
	slot0.heroId = slot1.heroId
	slot0.life = slot1.life
	slot0.lifePercent = slot1.life / 10
end

return slot0
