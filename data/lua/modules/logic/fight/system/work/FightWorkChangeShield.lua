module("modules.logic.fight.system.work.FightWorkChangeShield", package.seeall)

slot0 = class("FightWorkChangeShield", FightEffectBase)

function slot0.onStart(slot0)
	slot0:com_sendFightEvent(FightEvent.ChangeShield, slot0._actEffectMO.targetId)

	if slot0._actEffectMO.reserveId == "1" then
		FightFloatMgr.instance:float(slot1, FightEnum.FloatType.addShield, "+" .. slot0._actEffectMO.effectNum)
	end

	slot0:onDone(true)
end

function slot0._onPlayCardOver(slot0)
end

return slot0
