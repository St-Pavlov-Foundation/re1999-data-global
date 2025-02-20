module("modules.logic.fight.system.work.FightWorkTriggerStress", package.seeall)

slot0 = class("FightWorkTriggerStress", FightEffectBase)

function slot0.onStart(slot0)
	if not FightDataHelper.entityMgr:getById(slot0._actEffectMO.targetId) then
		return slot0:onDone(true)
	end

	if not (FightEnum.StressBehaviourConstId[slot0._actEffectMO.effectNum] and lua_stress_const.configDict[slot4]) then
		return slot0:onDone(true)
	end

	if slot0:checkNeedWaitTimeLineHandle(slot0._actEffectMO) then
		FightModel.instance:recordDelayHandleStressBehaviour(slot0._actEffectMO)
	else
		FightFloatMgr.instance:float(slot1, FightEnum.FloatType.stress, slot5.value2, tonumber(slot5.value))
		FightController.instance:dispatchEvent(FightEvent.TriggerStressBehaviour, slot1, slot3)
	end

	return slot0:onDone(true)
end

function slot0.checkNeedWaitTimeLineHandle(slot0, slot1)
	slot3 = slot1.configEffect and lua_stress_rule.configDict[slot2]

	return slot3 and slot3.type == "triggerSkill"
end

return slot0
