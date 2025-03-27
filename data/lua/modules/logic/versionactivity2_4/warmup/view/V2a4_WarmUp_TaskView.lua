module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp_TaskView", package.seeall)

slot0 = class("V2a4_WarmUp_TaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._scrollTaskList = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_TaskList")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
	Activity125Controller.instance:sendGetTaskInfoRequest(slot0._fallbackCheckIsFinishedReadTasks, slot0)
end

function slot0.onOpen(slot0)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, slot0._refresh, slot0)
	TaskController.instance:registerCallback(TaskEvent.SuccessGetBonus, slot0._refresh, slot0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, slot0._refresh, slot0)
	TaskController.instance:registerCallback(TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
	TaskController.instance:registerCallback(TaskEvent.onReceiveFinishReadTaskReply, slot0._onFinishTask, slot0)
	slot0:onUpdateParam()
end

function slot0.onClose(slot0)
	TaskController.instance:unregisterCallback(TaskEvent.SetTaskList, slot0._refresh, slot0)
	TaskController.instance:unregisterCallback(TaskEvent.SuccessGetBonus, slot0._refresh, slot0)
	TaskController.instance:unregisterCallback(TaskEvent.UpdateTaskList, slot0._refresh, slot0)
	TaskController.instance:unregisterCallback(TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
	TaskController.instance:unregisterCallback(TaskEvent.onReceiveFinishReadTaskReply, slot0._onFinishTask, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageFullBG:UnLoadImage()
end

function slot0._refresh(slot0)
	V2a4_WarmUp_TaskListModel.instance:setTaskList()
end

function slot0._onFinishTask(slot0)
	slot0:_refresh()
	V2a4_WarmUpController.instance:dispatchEventUpdateActTag()
end

function slot0._fallbackCheckIsFinishedReadTasks(slot0, slot1, slot2)
	if slot2 ~= 0 then
		return
	end

	if not TaskModel.instance:getTaskMoList(TaskEnum.TaskType.Activity125, slot0.viewContainer:actId()) or #slot4 == 0 then
		return
	end

	slot6 = {}

	for slot10, slot11 in ipairs(slot4) do
		slot15 = slot11.progress

		if Activity125Config.instance:getTaskCO_ReadTask_Tag(slot3, ActivityWarmUpEnum.Activity125TaskTag.sum_help_npc)[slot11.id] and not slot11.hasFinished then
			slot15 = Activity125Controller.instance:get_V2a4_WarmUp_sum_help_npc(0)

			V2a4_WarmUpController.instance:appendCompleteTask(slot6, slot11.type, slot14, slot15, tonumber(slot11.config.clientlistenerParam) or slot15 + 1)
		end
	end

	if #slot6 > 0 then
		V2a4_WarmUpController.instance:sendFinishReadTaskRequest(slot6)
	end
end

return slot0
