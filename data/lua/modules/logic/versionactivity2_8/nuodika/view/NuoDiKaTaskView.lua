module("modules.logic.versionactivity2_8.nuodika.view.NuoDiKaTaskView", package.seeall)

local var_0_0 = class("NuoDiKaTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.onOpen(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_2_0._oneClaimReward, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_2_0._onFinishTask, arg_2_0)
	NuoDiKaTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity180
	}, arg_2_0._oneClaimReward, arg_2_0)
	TaskDispatcher.runRepeat(arg_2_0._showLeftTime, arg_2_0, 60)
	arg_2_0:_showLeftTime()
end

function var_0_0._oneClaimReward(arg_3_0)
	NuoDiKaTaskListModel.instance:init(VersionActivity2_8Enum.ActivityId.NuoDiKa)
end

function var_0_0._onFinishTask(arg_4_0, arg_4_1)
	if NuoDiKaTaskListModel.instance:getById(arg_4_1) then
		NuoDiKaTaskListModel.instance:init(VersionActivity2_8Enum.ActivityId.NuoDiKa)
	end
end

function var_0_0._showLeftTime(arg_5_0)
	arg_5_0._txtLimitTime.text = var_0_0.getLimitTimeStr()
end

function var_0_0.getLimitTimeStr()
	local var_6_0 = ActivityModel.instance:getActMO(VersionActivity2_8Enum.ActivityId.NuoDiKa)

	if not var_6_0 then
		return ""
	end

	local var_6_1 = var_6_0:getRealEndTimeStamp() - ServerTime.now()

	if var_6_1 > 0 then
		return TimeUtil.SecondToActivityTimeFormat(var_6_1)
	end

	return ""
end

function var_0_0.onClose(arg_7_0)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.OnCloseTask)
	TaskDispatcher.cancelTask(arg_7_0._showLeftTime, arg_7_0)
end

function var_0_0.onDestroyView(arg_8_0)
	return
end

return var_0_0
