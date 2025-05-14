module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaTaskView", package.seeall)

local var_0_0 = class("TianShiNaNaTaskView", BaseView)

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
	TianShiNaNaTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity167
	}, arg_2_0._oneClaimReward, arg_2_0)
	TaskDispatcher.runRepeat(arg_2_0._showLeftTime, arg_2_0, 60)
	arg_2_0:_showLeftTime()
end

function var_0_0._oneClaimReward(arg_3_0)
	TianShiNaNaTaskListModel.instance:init(VersionActivity2_2Enum.ActivityId.TianShiNaNa)
end

function var_0_0._onFinishTask(arg_4_0, arg_4_1)
	if TianShiNaNaTaskListModel.instance:getById(arg_4_1) then
		TianShiNaNaTaskListModel.instance:init(VersionActivity2_2Enum.ActivityId.TianShiNaNa)
	end
end

function var_0_0._showLeftTime(arg_5_0)
	arg_5_0._txtLimitTime.text = TianShiNaNaHelper.getLimitTimeStr()
end

function var_0_0.onClose(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._showLeftTime, arg_6_0)
end

return var_0_0
