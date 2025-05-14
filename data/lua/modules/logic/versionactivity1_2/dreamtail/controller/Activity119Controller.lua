module("modules.logic.versionactivity1_2.dreamtail.controller.Activity119Controller", package.seeall)

local var_0_0 = class("Activity119Controller", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.reInit(arg_3_0)
	return
end

function var_0_0.addConstEvents(arg_4_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, arg_4_0._get119TaskInfo, arg_4_0)
end

function var_0_0._get119TaskInfo(arg_5_0, arg_5_1)
	if arg_5_1 then
		local var_5_0 = ActivityConfig.instance:getActivityCo(arg_5_1)

		if var_5_0 and var_5_0.typeId ~= ActivityEnum.ActivityTypeID.DreamTail then
			return
		end
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity119
	})
end

function var_0_0.openAct119View(arg_6_0)
	ViewMgr.instance:openView(ViewName.Activity119View)
end

var_0_0.instance = var_0_0.New()

return var_0_0
