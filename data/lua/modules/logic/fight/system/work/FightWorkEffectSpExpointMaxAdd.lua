module("modules.logic.fight.system.work.FightWorkEffectSpExpointMaxAdd", package.seeall)

local var_0_0 = class("FightWorkEffectSpExpointMaxAdd", FightEffectBase)

function var_0_0.beforePlayEffectData(arg_1_0)
	arg_1_0._entityId = arg_1_0.actEffectData.targetId
	arg_1_0._entityMO = FightDataHelper.entityMgr:getById(arg_1_0._entityId)
	arg_1_0._oldValue = arg_1_0._entityMO and arg_1_0._entityMO:getUniqueSkillPoint()
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = arg_2_0.actEffectData.targetId
	local var_2_1 = FightHelper.getEntity(var_2_0)

	if not var_2_1 then
		arg_2_0:onDone(true)

		return
	end

	local var_2_2 = var_2_1:getMO()

	if not var_2_2 then
		arg_2_0:onDone(true)

		return
	end

	if not var_2_2:hasBuffFeature(FightEnum.BuffType_SpExPointMaxAdd) then
		arg_2_0:onDone(true)

		return
	end

	FightController.instance:dispatchEvent(FightEvent.OnExpointMaxAdd, var_2_0, arg_2_0.actEffectData.effectNum)

	arg_2_0._newValue = var_2_2:getUniqueSkillPoint()

	FightController.instance:dispatchEvent(FightEvent.OnExSkillPointChange, var_2_0, arg_2_0._oldValue, arg_2_0._newValue)
	arg_2_0:onDone(true)
end

return var_0_0
