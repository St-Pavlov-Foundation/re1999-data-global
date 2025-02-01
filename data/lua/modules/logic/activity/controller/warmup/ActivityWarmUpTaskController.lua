module("modules.logic.activity.controller.warmup.ActivityWarmUpTaskController", package.seeall)

slot0 = class("ActivityWarmUpTaskController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.init(slot0, slot1, slot2)
	slot0._actId = slot1

	ActivityWarmUpTaskListModel.instance:setSelectedDay(slot2 or 1)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, slot0.updateDatas, slot0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, slot0.updateDatas, slot0)
end

function slot0.release(slot0)
	slot0._actId = nil

	TaskController.instance:unregisterCallback(TaskEvent.SetTaskList, slot0.updateDatas, slot0)
	TaskController.instance:unregisterCallback(TaskEvent.UpdateTaskList, slot0.updateDatas, slot0)
	ActivityWarmUpTaskListModel.instance:release()
end

function slot0.updateDatas(slot0)
	if not slot0._actId then
		logNormal("no actId enable!")

		return
	end

	ActivityWarmUpTaskListModel.instance:init(slot0._actId)
	ActivityWarmUpTaskListModel.instance:updateDayList()
	slot0:dispatchEvent(ActivityWarmUpEvent.TaskListUpdated)
	slot0:dispatchEvent(ActivityWarmUpEvent.TaskListInit)
end

function slot0.changeSelectedDay(slot0, slot1)
	ActivityWarmUpTaskListModel.instance:setSelectedDay(slot1)
	ActivityWarmUpTaskListModel.instance:updateDayList()
	slot0:dispatchEvent(ActivityWarmUpEvent.TaskDayChanged)
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
