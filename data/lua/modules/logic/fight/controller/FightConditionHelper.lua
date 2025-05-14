module("modules.logic.fight.controller.FightConditionHelper", package.seeall)

local var_0_0 = _M

function var_0_0.initConditionHandle()
	if not var_0_0.ConditionHandle then
		var_0_0.ConditionHandle = {
			[FightEnum.ConditionType.HasBuffId] = var_0_0.checkHasBuffId
		}
	end
end

function var_0_0.checkCondition(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_0.initConditionHandle()

	local var_2_0 = FightStrUtil.splitToNumber(arg_2_0, "#")
	local var_2_1 = lua_skill_behavior_condition.configDict[tonumber(var_2_0[1])]

	if not var_2_1 then
		return true
	end

	local var_2_2 = var_0_0.ConditionHandle[var_2_1.type]

	if var_2_2 then
		return var_2_2(var_2_0, arg_2_1, arg_2_2, arg_2_3)
	end

	return true
end

function var_0_0.checkHasBuffId(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_3 = FightConditionTargetHelper.getTarget(arg_3_1, arg_3_2, arg_3_3)

	if not arg_3_3 then
		return false
	end

	local var_3_0 = FightDataHelper.entityMgr:getById(arg_3_3)

	if not var_3_0 then
		return false
	end

	for iter_3_0 = 2, #arg_3_0 do
		if var_3_0:hasBuffId(tonumber(arg_3_0[iter_3_0])) then
			return true
		end
	end

	return false
end

return var_0_0
