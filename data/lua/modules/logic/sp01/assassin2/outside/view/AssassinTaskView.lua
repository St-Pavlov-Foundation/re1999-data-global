module("modules.logic.sp01.assassin2.outside.view.AssassinTaskView", package.seeall)

local var_0_0 = class("AssassinTaskView", BaseView)

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
	arg_4_0._txtremaintime = gohelper.findChildText(arg_4_0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_6_0.refreshRight, arg_6_0)
	arg_6_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_6_0.refreshRight, arg_6_0)
	arg_6_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_6_0.refreshRight, arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	TaskDispatcher.runRepeat(arg_6_0.refreshRemainTime, arg_6_0, TimeUtil.OneMinuteSecond)
	AssassinTaskListModel.instance:initTask()
	arg_6_0:refreshLeft()
	arg_6_0:refreshRight()
end

function var_0_0.refreshLeft(arg_7_0)
	arg_7_0:refreshRemainTime()
end

function var_0_0.refreshRemainTime(arg_8_0)
	local var_8_0 = ActivityModel.instance:getActivityInfo()[VersionActivity2_9Enum.ActivityId.Outside]:getRealEndTimeStamp() - ServerTime.now()

	arg_8_0._txtremaintime.text = TimeUtil.SecondToActivityTimeFormat(var_8_0)
end

function var_0_0.refreshRight(arg_9_0)
	AssassinTaskListModel.instance:sortTaskMoList()
	AssassinTaskListModel.instance:refreshList()
end

function var_0_0.onClose(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.refreshRemainTime, arg_10_0)
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
