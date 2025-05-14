module("modules.logic.fight.system.work.FightWorkDoneFlowSequence", package.seeall)

local var_0_0 = class("FightWorkDoneFlowSequence", FightWorkFlowSequence)

function var_0_0.start(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.PARENT_ROOT_CLASS and arg_1_0.PARENT_ROOT_CLASS.PARENT_ROOT_CLASS

	if var_1_0 and var_1_0.cancelFightWorkSafeTimer then
		var_1_0:cancelFightWorkSafeTimer()
	end

	return var_0_0.super.start(arg_1_0, arg_1_1)
end

return var_0_0
