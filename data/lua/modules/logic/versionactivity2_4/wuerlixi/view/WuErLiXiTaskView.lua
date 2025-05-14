module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiTaskView", package.seeall)

local var_0_0 = class("WuErLiXiTaskView", BaseView)

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
	WuErLiXiTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity180
	}, arg_2_0._oneClaimReward, arg_2_0)
	TaskDispatcher.runRepeat(arg_2_0._showLeftTime, arg_2_0, 60)
	arg_2_0:_showLeftTime()
end

function var_0_0._oneClaimReward(arg_3_0)
	WuErLiXiTaskListModel.instance:init(VersionActivity2_4Enum.ActivityId.WuErLiXi)
end

function var_0_0._onFinishTask(arg_4_0, arg_4_1)
	if WuErLiXiTaskListModel.instance:getById(arg_4_1) then
		WuErLiXiTaskListModel.instance:init(VersionActivity2_4Enum.ActivityId.WuErLiXi)
	end
end

function var_0_0._showLeftTime(arg_5_0)
	arg_5_0._txtLimitTime.text = WuErLiXiHelper.getLimitTimeStr()
end

function var_0_0.onClose(arg_6_0)
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.OnCloseTask)
	TaskDispatcher.cancelTask(arg_6_0._showLeftTime, arg_6_0)
end

return var_0_0
