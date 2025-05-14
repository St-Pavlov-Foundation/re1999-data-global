module("modules.logic.versionactivity1_5.act142.view.Activity142TaskView", package.seeall)

local var_0_0 = class("Activity142TaskView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goLimitTime = gohelper.findChild(arg_1_0.viewGO, "Left/LimitTime")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_2_0._oneClaimReward, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_2_0._onFinishTask, arg_2_0)
	arg_2_0:addEventCb(Activity142Controller.instance, Activity142Event.ClickEpisode, arg_2_0._onGotoTaskEpisode, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_3_0._oneClaimReward, arg_3_0)
	arg_3_0:removeEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_3_0._onFinishTask, arg_3_0)
	arg_3_0:removeEventCb(Activity142Controller.instance, Activity142Event.ClickEpisode, arg_3_0._onGotoTaskEpisode, arg_3_0)
end

function var_0_0._oneClaimReward(arg_4_0)
	local var_4_0 = Activity142Model.instance:getActivityId()

	Activity142TaskListModel.instance:init(var_4_0)
end

function var_0_0._onFinishTask(arg_5_0, arg_5_1)
	if Activity142TaskListModel.instance:getById(arg_5_1) then
		local var_5_0 = Activity142Model.instance:getActivityId()

		Activity142TaskListModel.instance:init(var_5_0)
	end
end

function var_0_0._onGotoTaskEpisode(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	gohelper.setActive(arg_7_0._goLimitTime, false)
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)

	local var_9_0 = Activity142Model.instance:getActivityId()

	Activity142TaskListModel.instance:init(var_9_0)
	TaskDispatcher.runRepeat(arg_9_0._showLeftTime, arg_9_0, TimeUtil.OneMinuteSecond)
	arg_9_0:_showLeftTime()
end

function var_0_0._showLeftTime(arg_10_0)
	local var_10_0 = Activity142Model.instance:getActivityId()
	local var_10_1 = Activity142Model.instance:getRemainTimeStr(var_10_0)

	arg_10_0._txtLimitTime.text = var_10_1
end

function var_0_0.onClose(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._showLeftTime, arg_11_0)
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
