module("modules.logic.fight.system.work.FightWorkUpdateStoredExPoint", package.seeall)

slot0 = class("FightWorkUpdateStoredExPoint", FightEffectBase)

function slot0.onStart(slot0)
	if not FightEntityModel.instance:getById(slot0._actEffectMO.targetId) then
		slot0:onDone(true)

		return
	end

	slot2:changeStoredExPoint(slot0._actEffectMO.effectNum)

	if slot0._actEffectMO.buff then
		slot2:updateBuff(slot0._actEffectMO.buff)
	end

	slot0:onDone(true)
end

return slot0
