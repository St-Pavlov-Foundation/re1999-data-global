module("modules.logic.fight.system.work.FightWorkEffectShieldDel", package.seeall)

slot0 = class("FightWorkEffectShieldDel", FightEffectBase)

function slot0.onStart(slot0)
	if FightHelper.getEntity(slot0._actEffectMO.targetId) and slot1.nameUI then
		slot1.nameUI:setShield(0)
		FightController.instance:dispatchEvent(FightEvent.OnShieldChange, slot1, 0)
	end

	slot0:onDone(true)
end

return slot0
