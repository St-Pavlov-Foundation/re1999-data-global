module("modules.logic.fight.entity.FightEntityASFD", package.seeall)

slot0 = class("FightEntityASFD", BaseFightEntity)

function slot0.getTag(slot0)
	return SceneTag.UnitNpc
end

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)
	FightRenderOrderMgr.instance:unregister(slot0.id)
end

function slot0.initComponents(slot0)
	slot0:addComp("effect", FightEffectComp)
end

return slot0
