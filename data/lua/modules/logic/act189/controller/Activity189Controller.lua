module("modules.logic.act189.controller.Activity189Controller", package.seeall)

local var_0_0 = class("Activity189Controller", BaseController)

function var_0_0.dispatchEventUpdateActTag(arg_1_0)
	local var_1_0 = ActivityConfig.instance:getActivityCenterRedDotId(ActivityEnum.ActivityType.Beginner)
	local var_1_1 = RedDotConfig.instance:getParentRedDotId(var_1_0)
	local var_1_2 = ActivityConfig.instance:getActivityRedDotId(arg_1_0)

	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
		[tonumber(var_1_1)] = true,
		[tonumber(var_1_2)] = true
	})
end

function var_0_0.onInit(arg_2_0)
	arg_2_0:reInit()
end

function var_0_0.reInit(arg_3_0)
	return
end

function var_0_0.sendGetTaskInfoRequest(arg_4_0, arg_4_1, arg_4_2)
	TaskRpc.instance:sendGetTaskInfoRequest({
		Activity189Config.instance:getTaskType()
	}, arg_4_1, arg_4_2)
end

function var_0_0.sendFinishAllTaskRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	TaskRpc.instance:sendFinishAllTaskRequest(Activity189Config.instance:getTaskType(), nil, nil, arg_5_2, arg_5_3, arg_5_1)
end

function var_0_0.sendGetAct189OnceBonusRequest(arg_6_0, arg_6_1)
	return Activity189Rpc.instance:sendGetAct189OnceBonusRequest(arg_6_1, var_0_0.dispatchEventUpdateActTag, arg_6_1)
end

function var_0_0.sendGetAct189InfoRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	return Activity189Rpc.instance:sendGetAct189InfoRequest(arg_7_1, arg_7_2, arg_7_3)
end

function var_0_0.sendFinishReadTaskRequest(arg_8_0, arg_8_1)
	if not arg_8_1 or arg_8_1 == 0 then
		return
	end

	local var_8_0 = Activity189Config.instance:getTaskCO(arg_8_1)

	if not var_8_0 then
		return
	end

	local var_8_1 = var_8_0.activityId

	TaskRpc.instance:sendFinishReadTaskRequest(arg_8_1, var_0_0.dispatchEventUpdateActTag, var_8_1)
end

local var_0_1 = "ReadTask"

function var_0_0.trySendFinishReadTaskRequest_jump(arg_9_0, arg_9_1)
	local var_9_0 = Activity189Config.instance:getTaskCO(arg_9_1)

	if not var_9_0 then
		return
	end

	if var_9_0.listenerType ~= var_0_1 then
		return
	end

	arg_9_0:sendFinishReadTaskRequest(arg_9_1)
end

function var_0_0.checkRed_Task(arg_10_0)
	local var_10_0 = RedDotEnum.DotNode.Activity189Task

	return RedDotModel.instance:isDotShow(var_10_0, 0)
end

function var_0_0.checkActRed(arg_11_0, arg_11_1)
	if ActivityBeginnerController.instance:checkRedDot(arg_11_1) then
		return true
	end

	return arg_11_0:checkRed_Task()
end

var_0_0.instance = var_0_0.New()

return var_0_0
