module("modules.logic.versionactivity3_1.bpoper.controller.V3a1_BpOperActController", package.seeall)

local var_0_0 = class("V3a1_BpOperActController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.onInitFinish(arg_3_0)
	return
end

function var_0_0.addConstEvents(arg_4_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_4_0.checkActivity, arg_4_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, arg_4_0.checkActivity, arg_4_0)
end

function var_0_0.checkActivity(arg_5_0)
	if not ActivityModel.instance:isActOnLine(VersionActivity3_1Enum.ActivityId.BpOperAct) then
		return
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.BpOperAct
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
