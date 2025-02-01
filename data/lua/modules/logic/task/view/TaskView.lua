module("modules.logic.task.view.TaskView", package.seeall)

slot0 = class("TaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._golineicon = gohelper.findChild(slot0.viewGO, "bg/#go_lineIcon")
	slot0._gonovice = gohelper.findChild(slot0.viewGO, "top/#go_novice")
	slot0._gonoviceunchoose = gohelper.findChild(slot0.viewGO, "top/#go_novice/#go_noviceunchoose")
	slot0._gonovicechoose = gohelper.findChild(slot0.viewGO, "top/#go_novice/#go_novicechoose")
	slot0._gotasknovicereddot = gohelper.findChild(slot0.viewGO, "top/#go_novice/#go_tasknovicereddot")
	slot0._btnnovice = gohelper.findChildButtonWithAudio(slot0.viewGO, "top/#go_novice/#btn_novice")
	slot0._goweek = gohelper.findChild(slot0.viewGO, "top/#go_week")
	slot0._goweekunchoose = gohelper.findChild(slot0.viewGO, "top/#go_week/#go_weekunchoose")
	slot0._goweekchoose = gohelper.findChild(slot0.viewGO, "top/#go_week/#go_weekchoose")
	slot0._gotaskweekreddot = gohelper.findChild(slot0.viewGO, "top/#go_week/#go_taskweekreddot")
	slot0._btnweek = gohelper.findChildButtonWithAudio(slot0.viewGO, "top/#go_week/#btn_week")
	slot0._goday = gohelper.findChild(slot0.viewGO, "top/#go_day")
	slot0._godayunchoose = gohelper.findChild(slot0.viewGO, "top/#go_day/#go_dayunchoose")
	slot0._godaychoose = gohelper.findChild(slot0.viewGO, "top/#go_day/#go_daychoose")
	slot0._gotaskdayreddot = gohelper.findChild(slot0.viewGO, "top/#go_day/#go_taskdayreddot")
	slot0._btnday = gohelper.findChildButtonWithAudio(slot0.viewGO, "top/#go_day/#btn_day")
	slot0._goline1 = gohelper.findChild(slot0.viewGO, "top/#go_line1")
	slot0._goline2 = gohelper.findChild(slot0.viewGO, "top/#go_line2")
	slot0._gocontainer = gohelper.findChild(slot0.viewGO, "#go_container")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnnovice:AddClickListener(slot0._btnnoviceOnClick, slot0)
	slot0._btnweek:AddClickListener(slot0._btnweekOnClick, slot0)
	slot0._btnday:AddClickListener(slot0._btndayOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnnovice:RemoveClickListener()
	slot0._btnweek:RemoveClickListener()
	slot0._btnday:RemoveClickListener()
end

function slot0._btnnoviceOnClick(slot0)
	if not ActivityModel.instance:isActOnLine(ActivityEnum.Activity.NoviceTask) then
		return
	end

	if slot0._taskType == TaskEnum.TaskType.Novice then
		return
	end

	slot0._taskType = TaskEnum.TaskType.Novice

	slot0:_refreshTop()
	slot0:_changeTask()
end

function slot0._btndayOnClick(slot0)
	if slot0._taskType == TaskEnum.TaskType.Daily then
		return
	end

	slot0._taskType = TaskEnum.TaskType.Daily

	slot0:_refreshTop()
	slot0:_changeTask()
end

function slot0._btnweekOnClick(slot0)
	if slot0._taskType == TaskEnum.TaskType.Weekly then
		return
	end

	slot0._taskType = TaskEnum.TaskType.Weekly

	slot0:_refreshTop()
	slot0:_changeTask()
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SetTaskList, slot0._changeTask, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0._refreshView, slot0)
	gohelper.addUIClickAudio(slot0._btnnovice.gameObject, AudioEnum.UI.UI_Mission_switch)
	gohelper.addUIClickAudio(slot0._btnweek.gameObject, AudioEnum.UI.UI_Mission_switch)
	gohelper.addUIClickAudio(slot0._btnday.gameObject, AudioEnum.UI.UI_Mission_switch)
	RedDotController.instance:addRedDot(slot0._gotaskdayreddot, RedDotEnum.DotNode.DailyTask)
	RedDotController.instance:addRedDot(slot0._gotaskweekreddot, RedDotEnum.DotNode.WeeklyTask)
	RedDotController.instance:addRedDot(slot0._gotasknovicereddot, RedDotEnum.DotNode.NoviceTask)
	TaskModel.instance:setRefreshCount(0)
	gohelper.setActive(slot0._gocontainer, false)
end

function slot0._refreshView(slot0)
	slot0._taskType = ActivityModel.instance:isActOnLine(ActivityEnum.Activity.NoviceTask) and TaskEnum.TaskType.Novice or TaskEnum.TaskType.Daily

	if slot1 and #TaskModel.instance:getAllRewardUnreceivedTasks(TaskEnum.TaskType.Novice) > 0 then
		slot0._taskType = TaskEnum.TaskType.Novice
	elseif #TaskModel.instance:getAllRewardUnreceivedTasks(TaskEnum.TaskType.Daily) > 0 and not TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Daily) then
		slot0._taskType = TaskEnum.TaskType.Daily
	elseif #TaskModel.instance:getAllRewardUnreceivedTasks(TaskEnum.TaskType.Weekly) > 0 and not TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Weekly) then
		slot0._taskType = TaskEnum.TaskType.Weekly
	elseif slot1 and not TaskModel.instance:isTypeAllTaskFinished(TaskEnum.TaskType.Novice) then
		slot0._taskType = TaskEnum.TaskType.Novice
	elseif not TaskModel.instance:isTypeAllTaskFinished(TaskEnum.TaskType.Daily) and not TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Daily) then
		slot0._taskType = TaskEnum.TaskType.Daily
	elseif not TaskModel.instance:isTypeAllTaskFinished(TaskEnum.TaskType.Weekly) and not TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Weekly) then
		slot0._taskType = TaskEnum.TaskType.Weekly
	end

	slot0:_refreshTop()
	slot0:_changeTask()
end

function slot0.onUpdateParam(slot0)
	if slot0.viewParam then
		slot0._taskType = slot0.viewParam
	end

	slot0:_refreshTop()
	slot0:_changeTask()
end

function slot0.onOpen(slot0)
	if slot0.viewParam then
		slot0._taskType = slot0.viewParam
	else
		slot0._taskType = uv0.getInitTaskType()
	end

	slot0._blurTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.35, slot0._onFrame, slot0._onFinish, slot0, nil, EaseType.Linear)

	TaskDispatcher.runDelay(slot0.checkCanvasGroupAlpha, slot0, 3)
end

function slot0.checkCanvasGroupAlpha(slot0)
	if slot0.viewContainer._canvasGroup and slot0.viewContainer._canvasGroup.alpha == 0 and slot0.viewContainer._isVisible then
		slot0.viewContainer._canvasGroup.alpha = 1
	end
end

function slot0._onFrame(slot0, slot1)
	PostProcessingMgr.instance:setBlurWeight(slot1)
end

function slot0.getInitTaskType()
	slot1 = ActivityModel.instance:isActOnLine(ActivityEnum.Activity.NoviceTask) and TaskEnum.TaskType.Novice or TaskEnum.TaskType.Daily

	if slot0 and #TaskModel.instance:getAllRewardUnreceivedTasks(TaskEnum.TaskType.Novice) > 0 then
		slot1 = TaskEnum.TaskType.Novice
	elseif #TaskModel.instance:getAllRewardUnreceivedTasks(TaskEnum.TaskType.Daily) > 0 and not TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Daily) then
		slot1 = TaskEnum.TaskType.Daily
	elseif #TaskModel.instance:getAllRewardUnreceivedTasks(TaskEnum.TaskType.Weekly) > 0 and not TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Weekly) then
		slot1 = TaskEnum.TaskType.Weekly
	elseif slot0 and not TaskModel.instance:isTypeAllTaskFinished(TaskEnum.TaskType.Novice) then
		slot1 = TaskEnum.TaskType.Novice
	elseif not TaskModel.instance:isTypeAllTaskFinished(TaskEnum.TaskType.Daily) and not TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Daily) then
		slot1 = TaskEnum.TaskType.Daily
	elseif not TaskModel.instance:isTypeAllTaskFinished(TaskEnum.TaskType.Weekly) and not TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Weekly) then
		slot1 = TaskEnum.TaskType.Weekly
	end

	return slot1
end

function slot0._onFinish(slot0)
	PostProcessingMgr.instance:setBlurWeight(1)
end

function slot0.onOpenFinish(slot0)
	gohelper.setActive(slot0._gocontainer, true)
	slot0:_refreshTop()
	slot0:_changeTask()
end

function slot0._refreshTop(slot0)
	slot1 = ActivityModel.instance:isActOnLine(ActivityEnum.Activity.NoviceTask)

	gohelper.setActive(slot0._gonovice, slot1)
	gohelper.setActive(slot0._goline1, slot1 and slot0._taskType == TaskEnum.TaskType.Weekly)

	if slot1 then
		gohelper.setActive(slot0._gonoviceunchoose, slot0._taskType ~= TaskEnum.TaskType.Novice)
		gohelper.setActive(slot0._gonovicechoose, slot0._taskType == TaskEnum.TaskType.Novice)
	end

	gohelper.setActive(slot0._goline2, slot0._taskType == TaskEnum.TaskType.Novice)
	gohelper.setActive(slot0._godayunchoose, slot0._taskType ~= TaskEnum.TaskType.Daily)
	gohelper.setActive(slot0._godaychoose, slot0._taskType == TaskEnum.TaskType.Daily)
	gohelper.setActive(slot0._goweekunchoose, slot0._taskType ~= TaskEnum.TaskType.Weekly)
	gohelper.setActive(slot0._goweekchoose, slot0._taskType == TaskEnum.TaskType.Weekly)
	gohelper.setActive(slot0._golineicon, slot0._taskType == TaskEnum.TaskType.Daily or slot0._taskType == TaskEnum.TaskType.Weekly)
end

function slot0._changeTask(slot0)
	TaskModel.instance:setRefreshCount(TaskModel.instance:getRefreshCount() + 1)

	if slot0._taskType == TaskEnum.TaskType.Novice then
		slot0.viewContainer:switchTab(1)
	elseif slot0._taskType == TaskEnum.TaskType.Daily then
		slot0.viewContainer:switchTab(2)
	elseif slot0._taskType == TaskEnum.TaskType.Weekly then
		slot0.viewContainer:switchTab(3)
	end
end

function slot0.onClose(slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.SetTaskList, slot0._changeTask, slot0)
	slot0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0._refreshView, slot0)
	TaskDispatcher.cancelTask(slot0.checkCanvasGroupAlpha, slot0)

	if slot0._blurTweenId then
		PostProcessingMgr.instance:setBlurWeight(1)
		ZProj.TweenHelper.KillById(slot0._blurTweenId)
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
