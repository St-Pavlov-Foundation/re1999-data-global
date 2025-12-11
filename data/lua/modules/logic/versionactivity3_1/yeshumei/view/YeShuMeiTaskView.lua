module("modules.logic.versionactivity3_1.yeshumei.view.YeShuMeiTaskView", package.seeall)

local var_0_0 = class("YeShuMeiTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simagelangtxt = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/#simage_langtxt")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_limittime")
	arg_1_0._scrollTaskList = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_TaskList")
	arg_1_0._goBackBtns = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")

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
	arg_4_0._actId = VersionActivity3_1Enum.ActivityId.YeShuMei
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	arg_6_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_6_0._oneClaimReward, arg_6_0)
	arg_6_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_6_0._onFinishTask, arg_6_0)
	YeShuMeiTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity211
	}, arg_6_0._oneClaimReward, arg_6_0)
	TaskDispatcher.runRepeat(arg_6_0.showLeftTime, arg_6_0, TimeUtil.OneMinuteSecond)
	arg_6_0:showLeftTime()
end

function var_0_0._oneClaimReward(arg_7_0)
	YeShuMeiTaskListModel.instance:init(arg_7_0._actId)
end

function var_0_0._onFinishTask(arg_8_0, arg_8_1)
	if YeShuMeiTaskListModel.instance:getById(arg_8_1) then
		YeShuMeiTaskListModel.instance:init(arg_8_0._actId)
	end
end

function var_0_0.showLeftTime(arg_9_0)
	arg_9_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(arg_9_0._actId)
end

function var_0_0.onClose(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.showLeftTime, arg_10_0)
end

return var_0_0
