module("modules.logic.act189.view.Activity189BaseView", package.seeall)

slot0 = class("Activity189BaseView", BaseView)

function slot0.onOpen(slot0)
	TaskController.instance:registerCallback(TaskEvent.SuccessGetBonus, slot0._refresh, slot0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, slot0._onUpdateTaskList, slot0)
	TaskController.instance:registerCallback(TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
	TaskController.instance:registerCallback(TaskEvent.onReceiveFinishReadTaskReply, slot0._onFinishTask, slot0)
	slot0:onUpdateParam()
end

function slot0.onUpdateParam(slot0)
	Activity189Controller.instance:sendGetTaskInfoRequest(slot0._refresh, slot0)
end

function slot0.onClose(slot0)
	TaskController.instance:unregisterCallback(TaskEvent.SuccessGetBonus, slot0._refresh, slot0)
	TaskController.instance:unregisterCallback(TaskEvent.UpdateTaskList, slot0._onUpdateTaskList, slot0)
	TaskController.instance:unregisterCallback(TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
	TaskController.instance:unregisterCallback(TaskEvent.onReceiveFinishReadTaskReply, slot0._onFinishTask, slot0)
end

function slot0._refresh(slot0)
	Activity189_TaskListModel.instance:setTaskList(slot0:actId())
end

function slot0._getTaskType(slot0)
	return Activity189Config.instance:getTaskType()
end

function slot0._onUpdateTaskList(slot0, slot1)
	if not slot1 then
		return
	end

	for slot7, slot8 in ipairs(slot1.taskInfo or {}) do
		if slot8.type == slot0:_getTaskType() then
			slot0:_refresh()

			break
		end
	end
end

function slot0._onFinishTask(slot0)
	slot0:_refresh()
	Activity189Controller.dispatchEventUpdateActTag(slot0:actId())
end

function slot0.getRemainTimeStr(slot0)
	if Activity189Model.instance:getRemainTimeSec(slot0:actId()) <= 0 then
		return luaLang("turnback_end")
	end

	slot2, slot3, slot4, slot5 = TimeUtil.secondsToDDHHMMSS(slot1)

	if slot2 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
			slot2,
			slot3
		})
	elseif slot3 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			slot3,
			slot4
		})
	elseif slot4 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			slot4
		})
	elseif slot5 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			1
		})
	end

	return luaLang("turnback_end")
end

function slot0.actId(slot0)
	return slot0.viewContainer:actId()
end

return slot0
