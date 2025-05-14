module("modules.logic.versionactivity2_2.lopera.view.LoperaTaskView", package.seeall)

local var_0_0 = class("LoperaTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simagelangtxt = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/#simage_langtxt")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._scrollTaskList = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_TaskList")
	arg_1_0._goBackBtns = gohelper.findChild(arg_1_0.viewGO, "#go_BackBtns")

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
	arg_6_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_6_0._oneClaimReward, arg_6_0)
	arg_6_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_6_0._onFinishTask, arg_6_0)
	Activity168TaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity168
	}, arg_6_0._oneClaimReward, arg_6_0)
	TaskDispatcher.runRepeat(arg_6_0._showLeftTime, arg_6_0, 60)
	arg_6_0:_showLeftTime()
end

function var_0_0._oneClaimReward(arg_7_0)
	Activity168TaskListModel.instance:init(VersionActivity2_2Enum.ActivityId.Lopera)
end

function var_0_0._onFinishTask(arg_8_0, arg_8_1)
	if Activity168TaskListModel.instance:getById(arg_8_1) then
		Activity168TaskListModel.instance:init(VersionActivity2_2Enum.ActivityId.Lopera)
	end
end

function var_0_0._showLeftTime(arg_9_0)
	arg_9_0._txtLimitTime.text = arg_9_0:getLimitTimeStr()
end

function var_0_0.getLimitTimeStr()
	local var_10_0 = ActivityModel.instance:getActMO(VersionActivity2_2Enum.ActivityId.Lopera)

	if not var_10_0 then
		return ""
	end

	local var_10_1 = var_10_0:getRealEndTimeStamp() - ServerTime.now()

	if var_10_1 > 0 then
		return TimeUtil.SecondToActivityTimeFormat(var_10_1)
	end

	return ""
end

function var_0_0.onClose(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._showLeftTime, arg_11_0)
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._simageFullBG:UnLoadImage()
end

return var_0_0
