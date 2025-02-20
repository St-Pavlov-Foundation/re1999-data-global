module("modules.logic.fight.system.work.FightWorkChangeShield", package.seeall)

slot0 = class("FightWorkChangeShield", FightEffectBase)

function slot0.onStart(slot0)
	slot0:com_sendFightEvent(FightEvent.ChangeShield, slot0._actEffectMO.targetId)
	slot0:onDone(true)
end

function slot0._onPlayCardOver(slot0)
end

return slot0
