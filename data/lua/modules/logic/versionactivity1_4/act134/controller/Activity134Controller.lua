module("modules.logic.versionactivity1_4.act134.controller.Activity134Controller", package.seeall)

slot0 = class("Activity134Controller", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, slot0._onUpdateTaskList, slot0)
	TaskController.instance:registerCallback(TaskEvent.OnDeleteTask, slot0._onDeleteTaskList, slot0)
end

function slot0._onUpdateTaskList(slot0, slot1)
	if Activity134Model.instance:setTasksInfo(slot1.taskInfo) then
		uv0.instance:dispatchEvent(Activity134Event.OnTaskUpdate)
		uv0.instance:dispatchEvent(Activity134Event.OnRedDotUpdate)
	end
end

function slot0._onDeleteTaskList(slot0, slot1)
	if Activity134Model.instance:deleteInfo(slot1.taskIds) then
		uv0.instance:dispatchEvent(Activity134Event.OnTaskUpdate)
		uv0.instance:dispatchEvent(Activity134Event.OnRedDotUpdate)
	end
end

function slot0.openActivity134MainView(slot0, slot1)
	Activity134Rpc.instance:sendGet134InfosRequest(slot1, function ()
		ViewMgr.instance:openView(ViewName.Activity134View, {
			activityId = uv0
		})
	end)
end

function slot0.openActivity134TaskView(slot0)
	ViewMgr.instance:openView(ViewName.Activity134TaskView)
end

function slot0.reInit(slot0)
end

slot0.instance = slot0.New()

return slot0
