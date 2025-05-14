module("modules.logic.task.view.TaskView", package.seeall)

local var_0_0 = class("TaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._golineicon = gohelper.findChild(arg_1_0.viewGO, "bg/#go_lineIcon")
	arg_1_0._gonovice = gohelper.findChild(arg_1_0.viewGO, "top/#go_novice")
	arg_1_0._gonoviceunchoose = gohelper.findChild(arg_1_0.viewGO, "top/#go_novice/#go_noviceunchoose")
	arg_1_0._gonovicechoose = gohelper.findChild(arg_1_0.viewGO, "top/#go_novice/#go_novicechoose")
	arg_1_0._gotasknovicereddot = gohelper.findChild(arg_1_0.viewGO, "top/#go_novice/#go_tasknovicereddot")
	arg_1_0._btnnovice = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "top/#go_novice/#btn_novice")
	arg_1_0._goweek = gohelper.findChild(arg_1_0.viewGO, "top/#go_week")
	arg_1_0._goweekunchoose = gohelper.findChild(arg_1_0.viewGO, "top/#go_week/#go_weekunchoose")
	arg_1_0._goweekchoose = gohelper.findChild(arg_1_0.viewGO, "top/#go_week/#go_weekchoose")
	arg_1_0._gotaskweekreddot = gohelper.findChild(arg_1_0.viewGO, "top/#go_week/#go_taskweekreddot")
	arg_1_0._btnweek = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "top/#go_week/#btn_week")
	arg_1_0._goday = gohelper.findChild(arg_1_0.viewGO, "top/#go_day")
	arg_1_0._godayunchoose = gohelper.findChild(arg_1_0.viewGO, "top/#go_day/#go_dayunchoose")
	arg_1_0._godaychoose = gohelper.findChild(arg_1_0.viewGO, "top/#go_day/#go_daychoose")
	arg_1_0._gotaskdayreddot = gohelper.findChild(arg_1_0.viewGO, "top/#go_day/#go_taskdayreddot")
	arg_1_0._btnday = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "top/#go_day/#btn_day")
	arg_1_0._goline1 = gohelper.findChild(arg_1_0.viewGO, "top/#go_line1")
	arg_1_0._goline2 = gohelper.findChild(arg_1_0.viewGO, "top/#go_line2")
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "#go_container")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnnovice:AddClickListener(arg_2_0._btnnoviceOnClick, arg_2_0)
	arg_2_0._btnweek:AddClickListener(arg_2_0._btnweekOnClick, arg_2_0)
	arg_2_0._btnday:AddClickListener(arg_2_0._btndayOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnnovice:RemoveClickListener()
	arg_3_0._btnweek:RemoveClickListener()
	arg_3_0._btnday:RemoveClickListener()
end

function var_0_0._btnnoviceOnClick(arg_4_0)
	if not ActivityModel.instance:isActOnLine(ActivityEnum.Activity.NoviceTask) then
		return
	end

	if arg_4_0._taskType == TaskEnum.TaskType.Novice then
		return
	end

	arg_4_0._taskType = TaskEnum.TaskType.Novice

	arg_4_0:_refreshTop()
	arg_4_0:_changeTask()
end

function var_0_0._btndayOnClick(arg_5_0)
	if arg_5_0._taskType == TaskEnum.TaskType.Daily then
		return
	end

	arg_5_0._taskType = TaskEnum.TaskType.Daily

	arg_5_0:_refreshTop()
	arg_5_0:_changeTask()
end

function var_0_0._btnweekOnClick(arg_6_0)
	if arg_6_0._taskType == TaskEnum.TaskType.Weekly then
		return
	end

	arg_6_0._taskType = TaskEnum.TaskType.Weekly

	arg_6_0:_refreshTop()
	arg_6_0:_changeTask()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0:addEventCb(TaskController.instance, TaskEvent.SetTaskList, arg_7_0._changeTask, arg_7_0)
	arg_7_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_7_0._refreshView, arg_7_0)
	gohelper.addUIClickAudio(arg_7_0._btnnovice.gameObject, AudioEnum.UI.UI_Mission_switch)
	gohelper.addUIClickAudio(arg_7_0._btnweek.gameObject, AudioEnum.UI.UI_Mission_switch)
	gohelper.addUIClickAudio(arg_7_0._btnday.gameObject, AudioEnum.UI.UI_Mission_switch)
	RedDotController.instance:addRedDot(arg_7_0._gotaskdayreddot, RedDotEnum.DotNode.DailyTask)
	RedDotController.instance:addRedDot(arg_7_0._gotaskweekreddot, RedDotEnum.DotNode.WeeklyTask)
	RedDotController.instance:addRedDot(arg_7_0._gotasknovicereddot, RedDotEnum.DotNode.NoviceTask)
	TaskModel.instance:setRefreshCount(0)
	gohelper.setActive(arg_7_0._gocontainer, false)
end

function var_0_0._refreshView(arg_8_0)
	local var_8_0 = ActivityModel.instance:isActOnLine(ActivityEnum.Activity.NoviceTask)

	arg_8_0._taskType = var_8_0 and TaskEnum.TaskType.Novice or TaskEnum.TaskType.Daily

	if var_8_0 and #TaskModel.instance:getAllRewardUnreceivedTasks(TaskEnum.TaskType.Novice) > 0 then
		arg_8_0._taskType = TaskEnum.TaskType.Novice
	elseif #TaskModel.instance:getAllRewardUnreceivedTasks(TaskEnum.TaskType.Daily) > 0 and not TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Daily) then
		arg_8_0._taskType = TaskEnum.TaskType.Daily
	elseif #TaskModel.instance:getAllRewardUnreceivedTasks(TaskEnum.TaskType.Weekly) > 0 and not TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Weekly) then
		arg_8_0._taskType = TaskEnum.TaskType.Weekly
	elseif var_8_0 and not TaskModel.instance:isTypeAllTaskFinished(TaskEnum.TaskType.Novice) then
		arg_8_0._taskType = TaskEnum.TaskType.Novice
	elseif not TaskModel.instance:isTypeAllTaskFinished(TaskEnum.TaskType.Daily) and not TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Daily) then
		arg_8_0._taskType = TaskEnum.TaskType.Daily
	elseif not TaskModel.instance:isTypeAllTaskFinished(TaskEnum.TaskType.Weekly) and not TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Weekly) then
		arg_8_0._taskType = TaskEnum.TaskType.Weekly
	end

	arg_8_0:_refreshTop()
	arg_8_0:_changeTask()
end

function var_0_0.onUpdateParam(arg_9_0)
	if arg_9_0.viewParam then
		arg_9_0._taskType = arg_9_0.viewParam
	end

	arg_9_0:_refreshTop()
	arg_9_0:_changeTask()
end

function var_0_0.onOpen(arg_10_0)
	if arg_10_0.viewParam then
		arg_10_0._taskType = arg_10_0.viewParam
	else
		arg_10_0._taskType = var_0_0.getInitTaskType()
	end

	arg_10_0._blurTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.35, arg_10_0._onFrame, arg_10_0._onFinish, arg_10_0, nil, EaseType.Linear)

	TaskDispatcher.runDelay(arg_10_0.checkCanvasGroupAlpha, arg_10_0, 3)
end

function var_0_0.checkCanvasGroupAlpha(arg_11_0)
	if arg_11_0.viewContainer._canvasGroup and arg_11_0.viewContainer._canvasGroup.alpha == 0 and arg_11_0.viewContainer._isVisible then
		arg_11_0.viewContainer._canvasGroup.alpha = 1
	end
end

function var_0_0._onFrame(arg_12_0, arg_12_1)
	PostProcessingMgr.instance:setBlurWeight(arg_12_1)
end

function var_0_0.getInitTaskType()
	local var_13_0 = ActivityModel.instance:isActOnLine(ActivityEnum.Activity.NoviceTask)
	local var_13_1 = var_13_0 and TaskEnum.TaskType.Novice or TaskEnum.TaskType.Daily

	if var_13_0 and #TaskModel.instance:getAllRewardUnreceivedTasks(TaskEnum.TaskType.Novice) > 0 then
		var_13_1 = TaskEnum.TaskType.Novice
	elseif #TaskModel.instance:getAllRewardUnreceivedTasks(TaskEnum.TaskType.Daily) > 0 and not TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Daily) then
		var_13_1 = TaskEnum.TaskType.Daily
	elseif #TaskModel.instance:getAllRewardUnreceivedTasks(TaskEnum.TaskType.Weekly) > 0 and not TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Weekly) then
		var_13_1 = TaskEnum.TaskType.Weekly
	elseif var_13_0 and not TaskModel.instance:isTypeAllTaskFinished(TaskEnum.TaskType.Novice) then
		var_13_1 = TaskEnum.TaskType.Novice
	elseif not TaskModel.instance:isTypeAllTaskFinished(TaskEnum.TaskType.Daily) and not TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Daily) then
		var_13_1 = TaskEnum.TaskType.Daily
	elseif not TaskModel.instance:isTypeAllTaskFinished(TaskEnum.TaskType.Weekly) and not TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Weekly) then
		var_13_1 = TaskEnum.TaskType.Weekly
	end

	return var_13_1
end

function var_0_0._onFinish(arg_14_0)
	PostProcessingMgr.instance:setBlurWeight(1)
end

function var_0_0.onOpenFinish(arg_15_0)
	gohelper.setActive(arg_15_0._gocontainer, true)
	arg_15_0:_refreshTop()
	arg_15_0:_changeTask()
end

function var_0_0._refreshTop(arg_16_0)
	local var_16_0 = ActivityModel.instance:isActOnLine(ActivityEnum.Activity.NoviceTask)

	gohelper.setActive(arg_16_0._gonovice, var_16_0)
	gohelper.setActive(arg_16_0._goline1, var_16_0 and arg_16_0._taskType == TaskEnum.TaskType.Weekly)

	if var_16_0 then
		gohelper.setActive(arg_16_0._gonoviceunchoose, arg_16_0._taskType ~= TaskEnum.TaskType.Novice)
		gohelper.setActive(arg_16_0._gonovicechoose, arg_16_0._taskType == TaskEnum.TaskType.Novice)
	end

	gohelper.setActive(arg_16_0._goline2, arg_16_0._taskType == TaskEnum.TaskType.Novice)
	gohelper.setActive(arg_16_0._godayunchoose, arg_16_0._taskType ~= TaskEnum.TaskType.Daily)
	gohelper.setActive(arg_16_0._godaychoose, arg_16_0._taskType == TaskEnum.TaskType.Daily)
	gohelper.setActive(arg_16_0._goweekunchoose, arg_16_0._taskType ~= TaskEnum.TaskType.Weekly)
	gohelper.setActive(arg_16_0._goweekchoose, arg_16_0._taskType == TaskEnum.TaskType.Weekly)
	gohelper.setActive(arg_16_0._golineicon, arg_16_0._taskType == TaskEnum.TaskType.Daily or arg_16_0._taskType == TaskEnum.TaskType.Weekly)
end

function var_0_0._changeTask(arg_17_0)
	local var_17_0 = TaskModel.instance:getRefreshCount()

	TaskModel.instance:setRefreshCount(var_17_0 + 1)

	if arg_17_0._taskType == TaskEnum.TaskType.Novice then
		arg_17_0.viewContainer:switchTab(1)
	elseif arg_17_0._taskType == TaskEnum.TaskType.Daily then
		arg_17_0.viewContainer:switchTab(2)
	elseif arg_17_0._taskType == TaskEnum.TaskType.Weekly then
		arg_17_0.viewContainer:switchTab(3)
	end
end

function var_0_0.onClose(arg_18_0)
	arg_18_0:removeEventCb(TaskController.instance, TaskEvent.SetTaskList, arg_18_0._changeTask, arg_18_0)
	arg_18_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_18_0._refreshView, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0.checkCanvasGroupAlpha, arg_18_0)

	if arg_18_0._blurTweenId then
		PostProcessingMgr.instance:setBlurWeight(1)
		ZProj.TweenHelper.KillById(arg_18_0._blurTweenId)
	end
end

function var_0_0.onDestroyView(arg_19_0)
	return
end

return var_0_0
