module("modules.logic.versionactivity1_2.jiexika.model.Activity114TaskMo", package.seeall)

local var_0_0 = pureTable("Activity114TaskMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = 0
	arg_1_0.config = nil
	arg_1_0.progress = 0
	arg_1_0.finishStatus = 0
end

function var_0_0.update(arg_2_0, arg_2_1)
	if arg_2_0.id ~= arg_2_1.taskId or not arg_2_0.config then
		arg_2_0.config = Activity114Config.instance:getTaskCoById(Activity114Model.instance.id, arg_2_1.taskId)
		arg_2_0.id = arg_2_1.taskId
	end

	arg_2_0.progress = arg_2_1.progress

	if arg_2_1.progress < arg_2_0.config.maxProgress then
		arg_2_0.finishStatus = Activity114Enum.TaskStatu.NoFinish
	elseif arg_2_1.hasGetBonus then
		arg_2_0.finishStatus = Activity114Enum.TaskStatu.GetBonus
	else
		arg_2_0.finishStatus = Activity114Enum.TaskStatu.Finish
	end
end

return var_0_0
