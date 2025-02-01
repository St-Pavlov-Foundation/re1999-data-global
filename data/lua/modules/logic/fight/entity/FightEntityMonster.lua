module("modules.logic.fight.entity.FightEntityMonster", package.seeall)

slot0 = class("FightEntityMonster", BaseFightEntity)

function slot0.getTag(slot0)
	return SceneTag.UnitMonster
end

function slot0.initComponents(slot0)
	uv0.super.initComponents(slot0)
	slot0:addComp("variantHeart", FightVariantHeartComp)
	slot0:addComp("entityVisible", FightEntityVisibleComp)
	slot0:addComp("nameUIVisible", FightNameUIVisibleComp)
end

return slot0
