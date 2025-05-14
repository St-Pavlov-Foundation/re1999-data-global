module("modules.logic.versionactivity2_5.autochess.view.AutoChessTaskView", package.seeall)

local var_0_0 = class("AutoChessTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simagelangtxt = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/#simage_langtxt")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._scrollTaskList = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_TaskList")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0.actId = arg_2_0.viewParam.actId

	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_2_0._oneClaimReward, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_2_0._onFinishTask, arg_2_0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.AutoChess
	}, arg_2_0._oneClaimReward, arg_2_0)
	TaskDispatcher.runRepeat(arg_2_0._showLeftTime, arg_2_0, TimeUtil.OneMinuteSecond)
	arg_2_0:_showLeftTime()
end

function var_0_0._oneClaimReward(arg_3_0)
	AutoChessTaskListModel.instance:init(arg_3_0.actId)
end

function var_0_0._onFinishTask(arg_4_0, arg_4_1)
	if AutoChessTaskListModel.instance:getById(arg_4_1) then
		AutoChessTaskListModel.instance:init(arg_4_0.actId)
	end
end

function var_0_0._showLeftTime(arg_5_0)
	arg_5_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(arg_5_0.actId)
end

function var_0_0.onClose(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._showLeftTime, arg_6_0)
	AutoChessTaskListModel.instance:clear()
end

return var_0_0
