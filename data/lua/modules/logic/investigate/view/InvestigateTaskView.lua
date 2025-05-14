module("modules.logic.investigate.view.InvestigateTaskView", package.seeall)

local var_0_0 = class("InvestigateTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_6_0.refreshRight, arg_6_0)
	arg_6_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_6_0.refreshRight, arg_6_0)
	arg_6_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_6_0.refreshRight, arg_6_0)
	arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_6_0._onOpenViewFinish, arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	arg_6_0:refreshLeft()
	InvestigateTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Investigate
	}, arg_6_0._oneClaimReward, arg_6_0)
end

function var_0_0._oneClaimReward(arg_7_0)
	arg_7_0:refreshRight()
end

function var_0_0.refreshLeft(arg_8_0)
	arg_8_0:refreshRemainTime()
end

function var_0_0.refreshRemainTime(arg_9_0)
	return
end

function var_0_0.refreshRight(arg_10_0)
	InvestigateTaskListModel.instance:initTask()
	InvestigateTaskListModel.instance:sortTaskMoList()
	InvestigateTaskListModel.instance:refreshList()
end

function var_0_0._onOpenViewFinish(arg_11_0, arg_11_1)
	if arg_11_1 == ViewName.InvestigateOpinionTabView then
		arg_11_0:closeThis()
	end
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
