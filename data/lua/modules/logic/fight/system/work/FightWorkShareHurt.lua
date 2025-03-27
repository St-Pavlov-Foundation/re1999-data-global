module("modules.logic.fight.system.work.FightWorkShareHurt", package.seeall)

slot0 = class("FightWorkShareHurt", FightEffectBase)

function slot0.onStart(slot0)
	if FightHelper.getEntity(slot0._actEffectMO.targetId) and slot0._actEffectMO.effectNum > 0 then
		FightFloatMgr.instance:float(slot1.id, FightEnum.FloatType.damage, slot1:isMySide() and -slot2 or slot2)

		if slot1.nameUI then
			slot1.nameUI:addHp(-slot2)
		end

		FightController.instance:dispatchEvent(FightEvent.OnHpChange, slot1, -slot2)
	end

	slot0:onDone(true)
end

return slot0
