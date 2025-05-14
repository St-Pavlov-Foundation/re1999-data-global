module("modules.logic.versionactivity2_5.liangyue.view.LiangYueTaskView", package.seeall)

local var_0_0 = class("LiangYueTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_time")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0._actId = VersionActivity2_5Enum.ActivityId.LiangYue

	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_2_0._oneClaimReward, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_2_0._onFinishTask, arg_2_0)
	LiangYueTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity184
	}, arg_2_0._oneClaimReward, arg_2_0)
	TaskDispatcher.runRepeat(arg_2_0.showLeftTime, arg_2_0, TimeUtil.OneMinuteSecond)
	arg_2_0:showLeftTime()
end

function var_0_0._oneClaimReward(arg_3_0)
	LiangYueTaskListModel.instance:init(arg_3_0._actId)
end

function var_0_0._onFinishTask(arg_4_0, arg_4_1)
	if LiangYueTaskListModel.instance:getById(arg_4_1) then
		LiangYueTaskListModel.instance:init(arg_4_0._actId)
	end
end

function var_0_0.showLeftTime(arg_5_0)
	arg_5_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(arg_5_0._actId)
end

function var_0_0.onClose(arg_6_0)
	LiangYueController.instance:dispatchEvent(LiangYueEvent.OnCloseTask)
	TaskDispatcher.cancelTask(arg_6_0.showLeftTime, arg_6_0)
end

return var_0_0
