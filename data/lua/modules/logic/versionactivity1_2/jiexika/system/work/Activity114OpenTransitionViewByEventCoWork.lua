module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114OpenTransitionViewByEventCoWork", package.seeall)

local var_0_0 = class("Activity114OpenTransitionViewByEventCoWork", Activity114OpenTransitionViewWork)

function var_0_0.getTransitionId(arg_1_0)
	if arg_1_0._transitionId then
		return arg_1_0._transitionId
	end

	local var_1_0 = arg_1_0.context.eventCo

	if string.nilorempty(var_1_0.config.isTransition) then
		return
	end

	local var_1_1 = string.splitToNumber(var_1_0.config.isTransition, "#")
	local var_1_2

	if arg_1_0.context.result == Activity114Enum.Result.Success or arg_1_0.context.result == Activity114Enum.Result.FightSucess then
		var_1_2 = var_1_1[1]
	elseif arg_1_0.context.result == Activity114Enum.Result.Fail then
		var_1_2 = var_1_1[2]
	end

	if not var_1_2 or var_1_2 == 0 then
		return
	end

	return var_1_2
end

return var_0_0
