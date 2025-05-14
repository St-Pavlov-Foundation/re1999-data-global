module("modules.logic.task.controller.TaskController", package.seeall)

local var_0_0 = class("TaskController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_3_0._onDailyRefresh, arg_3_0)
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.enterTaskView(arg_5_0, arg_5_1)
	ViewMgr.instance:openView(ViewName.TaskView, arg_5_1)
end

function var_0_0.enterTaskViewCheckUnlock(arg_6_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Task) then
		var_0_0.instance:enterTaskView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Task))
	end
end

function var_0_0._onDailyRefresh(arg_7_0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Daily,
		TaskEnum.TaskType.Weekly,
		TaskEnum.TaskType.Novice
	})
end

function var_0_0.getRewardByLine(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if not arg_8_0._priority then
		arg_8_0._priority = 10000
	end

	arg_8_0._priority = arg_8_0._priority - 1

	PopupController.instance:addPopupView(arg_8_0._priority, arg_8_2, arg_8_3)
end

var_0_0.instance = var_0_0.New()

return var_0_0
