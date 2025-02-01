module("modules.logic.fight.entity.FightEntityScene", package.seeall)

slot0 = class("FightEntityScene", BaseFightEntity)
slot0.MySideId = "0"
slot0.EnemySideId = "-99999"

function slot0.getTag(slot0)
	return SceneTag.UnitNpc
end

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)
	FightRenderOrderMgr.instance:unregister(slot0.id)
end

function slot0.initComponents(slot0)
	slot0:addComp("skill", FightSkillComp)
	slot0:addComp("effect", FightEffectComp)
	slot0:addComp("buff", FightBuffComp)
end

function slot0.getSide(slot0)
	if slot0.id == uv0.MySideId then
		return FightEnum.EntitySide.MySide
	elseif slot0.id == uv0.EnemySideId then
		return FightEnum.EntitySide.EnemySide
	else
		return FightEnum.EntitySide.BothSide
	end
end

return slot0
