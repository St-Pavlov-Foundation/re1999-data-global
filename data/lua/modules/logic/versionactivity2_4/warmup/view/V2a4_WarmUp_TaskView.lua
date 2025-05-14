module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp_TaskView", package.seeall)

local var_0_0 = class("V2a4_WarmUp_TaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._scrollTaskList = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_TaskList")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	Activity125Controller.instance:sendGetTaskInfoRequest(arg_6_0._fallbackCheckIsFinishedReadTasks, arg_6_0)
end

function var_0_0.onOpen(arg_7_0)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, arg_7_0._refresh, arg_7_0)
	TaskController.instance:registerCallback(TaskEvent.SuccessGetBonus, arg_7_0._refresh, arg_7_0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, arg_7_0._refresh, arg_7_0)
	TaskController.instance:registerCallback(TaskEvent.OnFinishTask, arg_7_0._onFinishTask, arg_7_0)
	TaskController.instance:registerCallback(TaskEvent.onReceiveFinishReadTaskReply, arg_7_0._onFinishTask, arg_7_0)
	arg_7_0:onUpdateParam()
end

function var_0_0.onClose(arg_8_0)
	TaskController.instance:unregisterCallback(TaskEvent.SetTaskList, arg_8_0._refresh, arg_8_0)
	TaskController.instance:unregisterCallback(TaskEvent.SuccessGetBonus, arg_8_0._refresh, arg_8_0)
	TaskController.instance:unregisterCallback(TaskEvent.UpdateTaskList, arg_8_0._refresh, arg_8_0)
	TaskController.instance:unregisterCallback(TaskEvent.OnFinishTask, arg_8_0._onFinishTask, arg_8_0)
	TaskController.instance:unregisterCallback(TaskEvent.onReceiveFinishReadTaskReply, arg_8_0._onFinishTask, arg_8_0)
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0._simageFullBG:UnLoadImage()
end

function var_0_0._refresh(arg_10_0)
	V2a4_WarmUp_TaskListModel.instance:setTaskList()
end

function var_0_0._onFinishTask(arg_11_0)
	arg_11_0:_refresh()
	V2a4_WarmUpController.instance:dispatchEventUpdateActTag()
end

function var_0_0._fallbackCheckIsFinishedReadTasks(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_2 ~= 0 then
		return
	end

	local var_12_0 = arg_12_0.viewContainer:actId()
	local var_12_1 = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.Activity125, var_12_0)

	if not var_12_1 or #var_12_1 == 0 then
		return
	end

	local var_12_2 = Activity125Config.instance:getTaskCO_ReadTask_Tag(var_12_0, ActivityWarmUpEnum.Activity125TaskTag.sum_help_npc)
	local var_12_3 = {}

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		local var_12_4 = iter_12_1.config
		local var_12_5 = iter_12_1.type
		local var_12_6 = iter_12_1.id
		local var_12_7 = iter_12_1.progress

		if var_12_2[var_12_6] and not iter_12_1.hasFinished then
			local var_12_8 = Activity125Controller.instance:get_V2a4_WarmUp_sum_help_npc(0)
			local var_12_9 = var_12_4.clientlistenerParam
			local var_12_10 = tonumber(var_12_9) or var_12_8 + 1

			V2a4_WarmUpController.instance:appendCompleteTask(var_12_3, var_12_5, var_12_6, var_12_8, var_12_10)
		end
	end

	if #var_12_3 > 0 then
		V2a4_WarmUpController.instance:sendFinishReadTaskRequest(var_12_3)
	end
end

return var_0_0
