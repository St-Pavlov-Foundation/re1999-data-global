module("modules.logic.fight.system.work.FightWorkEffectPowerChange", package.seeall)

slot0 = class("FightWorkEffectPowerChange", FightEffectBase)

function slot0.onStart(slot0)
	slot0:_startChangeExPoint()
end

function slot0._startChangeExPoint(slot0)
	if not FightHelper.getEntity(slot0._actEffectMO.targetId) then
		slot0:onDone(true)

		return
	end

	if slot2:getMO() then
		if slot3:getPowerInfo(slot0._actEffectMO.configEffect) then
			slot6 = slot5.num
			slot7 = slot6 + slot0._actEffectMO.effectNum
			slot5.num = slot7

			if slot6 ~= slot7 then
				FightController.instance:dispatchEvent(FightEvent.PowerChange, slot0._actEffectMO.targetId, slot4, slot6, slot7)
			end
		else
			logError(string.format("找不到灵光数据,灵光id:%s, 角色或怪物id:%s, 步骤类型:%s, actId:%s", slot4, slot3.modelId, slot0._fightStepMO.actType, slot0._fightStepMO.actId))
		end
	end

	slot0:_onDone()
end

function slot0._onDone(slot0)
	slot0:clearWork()
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
