module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6TaskView", package.seeall)

local var_0_0 = class("LengZhou6TaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simagelangtxt = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/#simage_langtxt")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_time")
	arg_1_0._scrollTaskList = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_TaskList")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_2_0._oneClaimReward, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_2_0._onFinishTask, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._oneClaimReward(arg_4_0)
	LengZhou6TaskListModel.instance:init()
end

function var_0_0._onFinishTask(arg_5_0, arg_5_1)
	if LengZhou6TaskListModel.instance:getById(arg_5_1) then
		LengZhou6TaskListModel.instance:init()
	end
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.actId = LengZhou6Model.instance:getAct190Id()
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
