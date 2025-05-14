module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicTaskView", package.seeall)

local var_0_0 = class("VersionActivity2_4MusicTaskView", BaseView)

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
	arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_6_0._onOpenViewFinish, arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	TaskDispatcher.runRepeat(arg_6_0.refreshRemainTime, arg_6_0, TimeUtil.OneMinuteSecond)
	arg_6_0:refreshLeft()
	VersionActivity2_4MusicTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity179
	}, arg_6_0._oneClaimReward, arg_6_0)
end

function var_0_0._oneClaimReward(arg_7_0)
	arg_7_0:refreshRight()
end

function var_0_0.refreshLeft(arg_8_0)
	arg_8_0:refreshRemainTime()
end

function var_0_0.refreshRemainTime(arg_9_0)
	local var_9_0 = Activity179Model.instance:getActivityId()
	local var_9_1 = ActivityModel.instance:getActivityInfo()[var_9_0]

	if var_9_1 then
		local var_9_2 = var_9_1:getRealEndTimeStamp() - ServerTime.now()

		if var_9_2 > 0 then
			local var_9_3 = TimeUtil.SecondToActivityTimeFormat(var_9_2)

			arg_9_0._txtremaintime.text = var_9_3

			return
		end
	end

	TaskDispatcher.cancelTask(arg_9_0.refreshRemainTime, arg_9_0)
end

function var_0_0.refreshRight(arg_10_0)
	VersionActivity2_4MusicTaskListModel.instance:initTask()
	VersionActivity2_4MusicTaskListModel.instance:sortTaskMoList()
	VersionActivity2_4MusicTaskListModel.instance:refreshList()
end

function var_0_0._onOpenViewFinish(arg_11_0, arg_11_1)
	if arg_11_1 == ViewName.VersionActivity2_4MusicOpinionTabView then
		arg_11_0:closeThis()
	end
end

function var_0_0.onClose(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0.refreshRemainTime, arg_12_0)
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
