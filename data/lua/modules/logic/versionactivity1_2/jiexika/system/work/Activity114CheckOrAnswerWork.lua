module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114CheckOrAnswerWork", package.seeall)

local var_0_0 = class("Activity114CheckOrAnswerWork", Activity114BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.context.eventCo

	if var_1_0.config.testId > 0 then
		arg_1_0:getFlow():addWork(Activity114AnswerWork.New())
	elseif var_1_0.config.isCheckEvent == 1 then
		arg_1_0:getFlow():addWork(Activity114DiceViewWork.New())
	else
		arg_1_0.context.result = Activity114Enum.Result.Success
	end

	arg_1_0:getFlow():addWork(Activity114CheckResultWork.New())
	arg_1_0:startFlow()
end

return var_0_0
