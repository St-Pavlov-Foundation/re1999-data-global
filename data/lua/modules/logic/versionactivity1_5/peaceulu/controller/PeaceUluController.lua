module("modules.logic.versionactivity1_5.peaceulu.controller.PeaceUluController", package.seeall)

local var_0_0 = class("PeaceUluController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, arg_3_0._onUpdateTaskList, arg_3_0)
end

function var_0_0._onUpdateTaskList(arg_4_0, arg_4_1)
	PeaceUluModel.instance:setTasksInfo(arg_4_1.taskInfo)
end

function var_0_0.openPeaceUluView(arg_5_0, arg_5_1)
	PeaceUluRpc.instance:sendGet145InfosRequest(VersionActivity1_5Enum.ActivityId.PeaceUlu, function()
		ViewMgr.instance:openView(ViewName.PeaceUluView, {
			param = arg_5_1
		})
	end, arg_5_0)
end

function var_0_0.reInit(arg_7_0)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
