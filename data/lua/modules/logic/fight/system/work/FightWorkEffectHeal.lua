module("modules.logic.fight.system.work.FightWorkEffectHeal", package.seeall)

slot0 = class("FightWorkEffectHeal", FightEffectBase)

function slot0.onStart(slot0)
	if not slot0._actEffectMO then
		slot0:onDone(true)

		return
	end

	if FightHelper.getEntity(slot0._actEffectMO.targetId) then
		if not slot1.nameUI then
			slot0:onDone(true)

			return
		end

		slot3 = slot0._actEffectMO.effectNum

		FightFloatMgr.instance:float(slot1.id, slot0._actEffectMO.effectType == FightEnum.EffectType.HEALCRIT and FightEnum.FloatType.crit_heal or FightEnum.FloatType.heal, slot3)
		slot1.nameUI:addHp(slot3)
		FightController.instance:dispatchEvent(FightEvent.OnHpChange, slot1, slot3)

		if slot1.nameUI:getHp() <= 0 and slot1.nameUI:getHp() > 0 and not FightSkillMgr.instance:isPlayingAnyTimeline() then
			slot1.nameUI:setActive(true)
		end
	end

	slot0:onDone(true)
end

return slot0
