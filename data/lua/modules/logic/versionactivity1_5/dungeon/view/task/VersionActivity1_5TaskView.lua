﻿module("modules.logic.versionactivity1_5.dungeon.view.task.VersionActivity1_5TaskView", package.seeall)

local var_0_0 = class("VersionActivity1_5TaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")

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
	arg_4_0._simageFullBG:LoadImage("singlebg/v1a5_taskview_singlebg/v1a5_taskview_fullbg.png")

	arg_4_0._txtremaintime = gohelper.findChildText(arg_4_0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, arg_6_0._onOpen, arg_6_0)
end

function var_0_0._onOpen(arg_7_0)
	arg_7_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_7_0.refreshRight, arg_7_0)
	arg_7_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_7_0.refreshRight, arg_7_0)
	arg_7_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_7_0.refreshRight, arg_7_0)
	TaskDispatcher.runRepeat(arg_7_0.refreshRemainTime, arg_7_0, TimeUtil.OneMinuteSecond)
	VersionActivity1_5TaskListModel.instance:initTask()
	arg_7_0:refreshLeft()
	arg_7_0:refreshRight()
end

function var_0_0.refreshLeft(arg_8_0)
	arg_8_0:refreshRemainTime()
end

function var_0_0.refreshRemainTime(arg_9_0)
	local var_9_0 = ActivityModel.instance:getActivityInfo()[VersionActivity1_5Enum.ActivityId.Dungeon]:getRemainTimeStr3()

	arg_9_0._txtremaintime.text = formatLuaLang("remain", var_9_0)
end

function var_0_0.refreshRight(arg_10_0)
	VersionActivity1_5TaskListModel.instance:sortTaskMoList()
	VersionActivity1_5TaskListModel.instance:refreshList()
end

function var_0_0.onClose(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.refreshRemainTime, arg_11_0)
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._simageFullBG:UnLoadImage()
end

return var_0_0
