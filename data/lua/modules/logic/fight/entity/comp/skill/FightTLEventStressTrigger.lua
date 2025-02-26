module("modules.logic.fight.entity.comp.skill.FightTLEventStressTrigger", package.seeall)

slot0 = class("FightTLEventStressTrigger")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	if not FightModel.instance:popNoHandledStressBehaviour(slot1.fromId) then
		logError("压力触发技能动效帧, 但是没找到触发压力的effect")

		return
	end

	if not (FightEnum.StressBehaviourConstId[slot5.effectNum] and lua_stress_const.configDict[slot7]) then
		logError(string.format("压力行为 %s 的常量配置不存在", slot6))

		return
	end

	FightFloatMgr.instance:float(slot4, FightEnum.FloatType.stress, slot8.value2, tonumber(slot8.value))

	slot14 = slot4
	slot15 = slot6

	FightController.instance:dispatchEvent(FightEvent.TriggerStressBehaviour, slot14, slot15)

	for slot14, slot15 in ipairs(slot1.actEffectMOs) do
		if slot15.effectType == FightEnum.EffectType.POWERCHANGE and slot15.targetId == slot4 and slot15.configEffect == FightEnum.PowerType.Stress then
			slot17 = FightDataHelper.entityMgr:getById(slot4) and slot16:getPowerInfo(FightEnum.PowerType.Stress)

			FightDataHelper.playEffectData(slot15)

			slot19 = slot17 and slot17.num

			if slot17 and slot17.num and slot19 and slot18 ~= slot19 then
				FightController.instance:dispatchEvent(FightEvent.PowerChange, slot4, FightEnum.PowerType.Stress, slot18, slot19)
			end

			break
		end
	end
end

function slot0.handleSkillEventEnd(slot0)
end

function slot0.onSkillEnd(slot0)
end

function slot0.clear(slot0)
end

function slot0.dispose(slot0)
end

return slot0
