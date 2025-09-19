module("modules.logic.versionactivity2_8.molideer.view.MoLiDeErTaskView", package.seeall)

local var_0_0 = class("MoLiDeErTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_time")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0._actId = VersionActivity2_8Enum.ActivityId.MoLiDeEr

	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_2_0._oneClaimReward, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_2_0._onFinishTask, arg_2_0)
	MoLiDeErTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity194
	}, arg_2_0._oneClaimReward, arg_2_0)
	TaskDispatcher.runRepeat(arg_2_0.showLeftTime, arg_2_0, TimeUtil.OneMinuteSecond)
	arg_2_0:showLeftTime()
end

function var_0_0._oneClaimReward(arg_3_0)
	MoLiDeErTaskListModel.instance:init(arg_3_0._actId)
end

function var_0_0._onFinishTask(arg_4_0, arg_4_1)
	if MoLiDeErTaskListModel.instance:getById(arg_4_1) then
		MoLiDeErTaskListModel.instance:init(arg_4_0._actId)
	end
end

function var_0_0.showLeftTime(arg_5_0)
	arg_5_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(arg_5_0._actId)
end

function var_0_0.onClose(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.showLeftTime, arg_6_0)
end

return var_0_0
