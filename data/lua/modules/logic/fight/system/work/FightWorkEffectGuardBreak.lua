module("modules.logic.fight.system.work.FightWorkEffectGuardBreak", package.seeall)

slot0 = class("FightWorkEffectGuardBreak", FightEffectBase)

function slot0.onStart(slot0)
	if FightHelper.getEntity(slot0._actEffectMO.targetId) and slot1.effect then
		slot2 = 0.5
		slot3 = slot1.effect:addHangEffect("buff/buff_podun", ModuleEnum.SpineHangPoint.mountmiddle, nil, slot2)

		slot3:setLocalPos(0, 0, 0)
		FightRenderOrderMgr.instance:onAddEffectWrap(slot1.id, slot3)
		slot0:com_registTimer(slot0._delayAfterPerformance, slot2)
		AudioMgr.instance:trigger(410000102)

		return
	end

	slot0:onDone(true)
end

return slot0
