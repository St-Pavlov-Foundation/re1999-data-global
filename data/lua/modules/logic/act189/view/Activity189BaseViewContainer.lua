module("modules.logic.act189.view.Activity189BaseViewContainer", package.seeall)

local var_0_0 = class("Activity189BaseViewContainer", BaseViewContainer)

function var_0_0.getActivityRemainTimeStr(arg_1_0)
	return ActivityHelper.getActivityRemainTimeStr(arg_1_0:actId())
end

function var_0_0.sendGetTaskInfoRequest(arg_2_0, arg_2_1, arg_2_2)
	Activity189Controller.instance:sendGetTaskInfoRequest(arg_2_1, arg_2_2)
end

function var_0_0.sendFinishAllTaskRequest(arg_3_0, arg_3_1, arg_3_2)
	Activity189Controller.instance:sendFinishAllTaskRequest(arg_3_0:actId(), arg_3_1, arg_3_2)
end

function var_0_0.sendFinishTaskRequest(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	TaskRpc.instance:sendFinishTaskRequest(arg_4_1, arg_4_2, arg_4_3)
end

function var_0_0.actId(arg_5_0)
	assert(false, "please override this function")
end

return var_0_0
