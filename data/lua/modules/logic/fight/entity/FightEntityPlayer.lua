module("modules.logic.fight.entity.FightEntityPlayer", package.seeall)

slot0 = class("FightEntityPlayer", BaseFightEntity)

function slot0.getTag(slot0)
	return SceneTag.UnitPlayer
end

function slot0.initComponents(slot0)
	uv0.super.initComponents(slot0)
	slot0:addComp("readyAttack", FightPlayerReadyAttackComp)
	slot0:addComp("variantCrayon", FightVariantCrayonComp)
	slot0:addComp("entityVisible", FightEntityVisibleComp)
	slot0:addComp("nameUIVisible", FightNameUIVisibleComp)
	slot0:addComp("variantHeart", FightVariantHeartComp)
end

return slot0
