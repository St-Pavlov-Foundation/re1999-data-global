module("modules.logic.sp01.act204.view.Activity204TaskView", package.seeall)

local var_0_0 = class("Activity204TaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "root/leftReward/dailyreward/#go_reddot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(Activity204Controller.instance, Activity204Event.UpdateInfo, arg_2_0.onUpdateInfo, arg_2_0)
	arg_2_0:addEventCb(Activity204Controller.instance, Activity204Event.UpdateTask, arg_2_0.refreshTask, arg_2_0)
	arg_2_0:addEventCb(Activity204Controller.instance, Activity204Event.FinishTask, arg_2_0.onFinishTask, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_2_0.refreshTask, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_2_0.refreshTask, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_2_0.refreshTask, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.SetTaskList, arg_2_0.refreshTask, arg_2_0)
	arg_2_0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_2_0.onDailyRefresh, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	RedDotController.instance:addRedDot(arg_4_0._goreddot, RedDotEnum.DotNode.V2a9_Act204DailyGet)
end

function var_0_0.onUpdateInfo(arg_5_0)
	arg_5_0:refreshView()
end

function var_0_0.onFinishTask(arg_6_0)
	arg_6_0:refreshTask()
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:refreshParam()
	arg_7_0:refreshView()
end

function var_0_0.onOpen(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.Act186.play_ui_mln_details_open)
	arg_8_0:refreshParam()
	arg_8_0:refreshView()
end

function var_0_0.refreshParam(arg_9_0)
	arg_9_0.actId = arg_9_0.viewParam.actId
	arg_9_0.actMo = Activity204Model.instance:getById(arg_9_0.actId)

	Activity204TaskListModel.instance:init(arg_9_0.actId)
	Activity204Model.instance:recordHasReadNewTask(arg_9_0.actId)
	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateActTag)
end

function var_0_0.refreshView(arg_10_0)
	arg_10_0:refreshTask()
end

function var_0_0.refreshTask(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.onDailyRefresh, arg_11_0)
	Activity204TaskListModel.instance:refresh()

	local var_11_0 = Activity204TaskListModel.instance:getNextRefreshTime()
	local var_11_1 = var_11_0 and var_11_0 / 1000 - ServerTime.now()

	if var_11_1 and var_11_1 > 0 then
		TaskDispatcher.runDelay(arg_11_0.onDailyRefresh, arg_11_0, var_11_1)
	end
end

function var_0_0.onDailyRefresh(arg_12_0)
	Activity204Controller.instance:sendRpc2GetMainTaskInfo()
end

function var_0_0.onClose(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0.onDailyRefresh, arg_13_0)
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0
