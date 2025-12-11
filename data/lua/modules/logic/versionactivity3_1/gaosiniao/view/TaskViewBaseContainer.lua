module("modules.logic.versionactivity3_1.gaosiniao.view.TaskViewBaseContainer", package.seeall)

local var_0_0 = class("TaskViewBaseContainer", BaseViewContainer)

function var_0_0.sendGetTaskInfoRequest(arg_1_0, arg_1_1, arg_1_2)
	TaskRpc.instance:sendGetTaskInfoRequest({
		arg_1_0:taskType()
	}, arg_1_1, arg_1_2)
end

function var_0_0.sendFinishAllTaskRequest(arg_2_0, arg_2_1, arg_2_2)
	TaskRpc.instance:sendFinishAllTaskRequest(arg_2_0:taskType(), nil, nil, arg_2_1, arg_2_2, arg_2_0:actId())
end

function var_0_0.sendFinishTaskRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	TaskRpc.instance:sendFinishTaskRequest(arg_3_1, arg_3_2, arg_3_3)
end

function var_0_0.getActivityRemainTimeStr(arg_4_0)
	return ActivityHelper.getActivityRemainTimeStr(arg_4_0:actId())
end

function var_0_0.actId(arg_5_0)
	assert(false, "please override this function")
end

function var_0_0.taskType(arg_6_0)
	assert(false, "please override this function")
end

return var_0_0
