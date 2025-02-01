module("modules.logic.fight.system.work.FightWorkStepBuff", package.seeall)

slot0 = class("FightWorkStepBuff", FightEffectBase)

function slot0.onStart(slot0)
	slot1 = slot0._actEffectMO
	slot2 = FightEntityModel.instance:getById(slot1.targetId)
	slot4 = slot1.buff and FightHelper.getEntity(slot3.entityId)
	uv0.canPlayDormantBuffAni = slot3 and FightBuffHelper.canPlayDormantBuffAni(slot1, slot0._fightStepMO)

	if slot1.effectType == FightEnum.EffectType.BUFFADD then
		if slot2 and slot2:addBuff(slot3) and slot4 and slot4.buff then
			slot4.buff:addBuff(slot3, false, slot0._fightStepMO.stepUid)
		end
	elseif slot1.effectType == FightEnum.EffectType.BUFFDEL or slot1.effectType == FightEnum.EffectType.BUFFDELNOEFFECT then
		if slot2 then
			if slot2.buffModel:getById(slot3.uid) then
				slot2:delBuff(slot5)
			else
				logNormal("BuffError del fail, buff not exist: entity_" .. slot3.entityId .. " buff_" .. slot3.buffId)
			end

			if slot4 and slot4.buff and slot5 then
				slot4.buff:delBuff(slot5)
			end
		end
	elseif slot1.effectType == FightEnum.EffectType.BUFFUPDATE then
		slot5 = nil

		if slot2 then
			slot5 = slot2:getBuffMO(slot3.uid) and slot6:clone()

			slot2:updateBuff(slot3)
		end

		if slot4 and slot4.buff then
			slot4.buff:updateBuff(slot3, slot5 or slot3, slot0._actEffectMO)
		end
	end

	FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate, slot1.targetId, slot1.effectType, slot3.buffId, slot3.uid, slot1.configEffect)

	if uv0.canPlayDormantBuffAni then
		slot0:com_registTimer(slot0._delayDone, 2 / FightModel.instance:getSpeed())

		return
	end

	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
