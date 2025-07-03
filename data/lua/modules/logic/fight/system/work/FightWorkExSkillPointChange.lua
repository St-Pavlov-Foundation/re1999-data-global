module("modules.logic.fight.system.work.FightWorkExSkillPointChange", package.seeall)

local var_0_0 = class("FightWorkExSkillPointChange", FightEffectBase)

function var_0_0.beforePlayEffectData(arg_1_0)
	arg_1_0._entityId = arg_1_0.actEffectData.targetId
	arg_1_0._entityMO = FightDataHelper.entityMgr:getById(arg_1_0._entityId)
	arg_1_0._oldValue = arg_1_0._entityMO and arg_1_0._entityMO:getUniqueSkillPoint()
end

function var_0_0.onStart(arg_2_0)
	if not FightHelper.getEntity(arg_2_0._entityId) then
		arg_2_0:onDone(true)

		return
	end

	if not arg_2_0._entityMO then
		arg_2_0:onDone(true)

		return
	end

	arg_2_0._newValue = arg_2_0._entityMO and arg_2_0._entityMO:getUniqueSkillPoint()

	if arg_2_0._oldValue ~= arg_2_0._newValue then
		FightController.instance:dispatchEvent(FightEvent.OnExSkillPointChange, arg_2_0.actEffectData.targetId, arg_2_0._oldValue, arg_2_0._newValue)
	end

	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0
