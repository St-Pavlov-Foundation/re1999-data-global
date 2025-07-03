module("modules.logic.versionactivity2_5.challenge.view.task.Act183TaskHeadItem", package.seeall)

local var_0_0 = class("Act183TaskHeadItem", Act183TaskBaseItem)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.go, "txt_desc")
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_0.super.onUpdateMO(arg_2_0, arg_2_1, arg_2_2, arg_2_3)

	arg_2_0._firstTaskMo = arg_2_1.data
	arg_2_0._firstTaskCo = arg_2_0._firstTaskMo and arg_2_0._firstTaskMo.config

	arg_2_0:refresh()
end

function var_0_0.refresh(arg_3_0)
	arg_3_0._txtdesc.text = arg_3_0._firstTaskCo and arg_3_0._firstTaskCo.minType
end

function var_0_0._getTaskFinishCount(arg_4_0, arg_4_1)
	local var_4_0 = 0

	if arg_4_1 then
		for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
			if TaskModel.instance:taskHasFinished(TaskEnum.TaskType.Activity183, iter_4_1.id) then
				var_4_0 = var_4_0 + 1
			end
		end
	end

	return var_4_0
end

return var_0_0
