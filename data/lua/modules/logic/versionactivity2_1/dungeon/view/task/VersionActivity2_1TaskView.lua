module("modules.logic.versionactivity2_1.dungeon.view.task.VersionActivity2_1TaskView", package.seeall)

local var_0_0 = class("VersionActivity2_1TaskView", BaseView)
local var_0_1 = 0.8

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagelangtxt = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/#simage_langtxt")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._scrollTaskList = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_TaskList")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_2_0.refreshTaskList, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_2_0.refreshTaskList, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_2_0.refreshTaskList, arg_2_0)
	arg_2_0:addEventCb(JumpController.instance, JumpEvent.BeforeJump, arg_2_0.closeThis, arg_2_0)
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
	VersionActivity2_1TaskListModel.instance:initTask()
	arg_6_0:refreshRemainTime()
	TaskDispatcher.runRepeat(arg_6_0.refreshRemainTime, arg_6_0, TimeUtil.OneMinuteSecond)
	UIBlockMgr.instance:startBlock(VersionActivity2_1DungeonEnum.BlockKey.OpenTaskView)
	TaskDispatcher.runDelay(arg_6_0._delayEndBlock, arg_6_0, var_0_1)
	arg_6_0:refreshTaskList()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
end

function var_0_0._delayEndBlock(arg_7_0)
	UIBlockMgr.instance:endBlock(VersionActivity2_1DungeonEnum.BlockKey.OpenTaskView)
end

function var_0_0.refreshTaskList(arg_8_0)
	VersionActivity2_1TaskListModel.instance:sortTaskMoList()
	VersionActivity2_1TaskListModel.instance:refreshList()
end

function var_0_0.refreshRemainTime(arg_9_0)
	local var_9_0 = ActivityModel.instance:getActivityInfo()[VersionActivity2_1Enum.ActivityId.Dungeon]
	local var_9_1 = ""

	if var_9_0 then
		var_9_1 = var_9_0:getRemainTimeStr3(false, false)
	end

	arg_9_0._txtLimitTime.text = var_9_1
end

function var_0_0.onClose(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.refreshRemainTime, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._delayEndBlock, arg_10_0)
	UIBlockMgr.instance:endBlock(VersionActivity2_1DungeonEnum.BlockKey.OpenTaskView)
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
