module("modules.logic.fight.entity.comp.skill.FightTLEventEntityRenderOrder", package.seeall)

slot0 = class("FightTLEventEntityRenderOrder")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot0:_setRenderOrder(slot6, tonumber(slot3[1]) or -1)

	for slot12, slot13 in ipairs(FightHelper.getSideEntitys(FightHelper.getEntity(slot1.fromId):getSide() == FightEnum.EntitySide.MySide and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide, true)) do
		slot0:_setRenderOrder(slot13, tonumber(slot3[2]) or -1)
	end

	FightRenderOrderMgr.instance:refreshRenderOrder()
end

function slot0._setRenderOrder(slot0, slot1, slot2)
	if slot2 ~= -1 then
		FightRenderOrderMgr.instance:setOrder(slot1.id, slot2)
	end
end

return slot0
