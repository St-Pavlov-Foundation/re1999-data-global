module("modules.logic.fight.system.work.FightWorkLayerHaloSync", package.seeall)

slot0 = class("FightWorkLayerHaloSync", FightEffectBase)

function slot0.onStart(slot0)
	slot1 = slot0._actEffectMO

	if FightEntityModel.instance:getById(slot1.targetId) then
		slot2:updateBuff(slot1.buff)
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
