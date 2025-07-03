module("modules.logic.versionactivity2_7.coopergarland.view.CooperGarlandTaskView", package.seeall)

local var_0_0 = class("CooperGarlandTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_time")
	arg_1_0._scrollTaskList = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_TaskList")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_2_0._oneClaimReward, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_2_0._onFinishTask, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_3_0._oneClaimReward, arg_3_0)
	arg_3_0:removeEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_3_0._onFinishTask, arg_3_0)
end

function var_0_0._oneClaimReward(arg_4_0)
	CooperGarlandTaskListModel.instance:init()
end

function var_0_0._onFinishTask(arg_5_0, arg_5_1)
	if CooperGarlandTaskListModel.instance:getById(arg_5_1) then
		CooperGarlandTaskListModel.instance:init()
	end
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.actId = CooperGarlandModel.instance:getAct192Id()
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:showLeftTime()
	TaskDispatcher.runRepeat(arg_8_0.showLeftTime, arg_8_0, TimeUtil.OneMinuteSecond)
end

function var_0_0.showLeftTime(arg_9_0)
	arg_9_0._txttime.text = ActivityHelper.getActivityRemainTimeStr(arg_9_0.actId)
end

function var_0_0.onClose(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.showLeftTime, arg_10_0)
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
