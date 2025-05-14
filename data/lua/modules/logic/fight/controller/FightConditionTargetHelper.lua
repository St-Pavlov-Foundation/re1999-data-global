module("modules.logic.fight.controller.FightConditionTargetHelper", package.seeall)

local var_0_0 = _M

function var_0_0.initConditionTargetHandle()
	if not var_0_0.ConditionTargetHandle then
		var_0_0.ConditionTargetHandle = {
			[FightEnum.ConditionTarget.Self] = var_0_0.getSelfConditionTarget
		}
	end
end

function var_0_0.getTarget(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.initConditionTargetHandle()

	local var_2_0 = var_0_0.ConditionTargetHandle[arg_2_0]

	if var_2_0 then
		return var_2_0(arg_2_0, arg_2_1, arg_2_2)
	end

	return arg_2_2
end

function var_0_0.getSelfConditionTarget(arg_3_0, arg_3_1, arg_3_2)
	return arg_3_1
end

return var_0_0
