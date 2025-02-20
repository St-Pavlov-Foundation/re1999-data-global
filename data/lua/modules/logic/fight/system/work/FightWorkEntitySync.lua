module("modules.logic.fight.system.work.FightWorkEntitySync", package.seeall)

slot0 = class("FightWorkEntitySync", FightEffectBase)

function slot0.onStart(slot0)
	if slot0._actEffectMO.entityMO then
		slot0:com_sendFightEvent(FightEvent.EntitySync, slot1.id)
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
