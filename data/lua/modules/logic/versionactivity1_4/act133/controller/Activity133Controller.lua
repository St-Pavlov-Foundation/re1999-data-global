module("modules.logic.versionactivity1_4.act133.controller.Activity133Controller", package.seeall)

slot0 = class("Activity133Controller", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, slot0._onUpdateTaskList, slot0)
	TaskController.instance:registerCallback(TaskEvent.OnDeleteTask, slot0._onDeleteTaskList, slot0)
end

function slot0._onUpdateTaskList(slot0, slot1)
	if Activity133Model.instance:setTasksInfo(slot1.taskInfo) then
		uv0.instance:dispatchEvent(Activity133Event.OnTaskUpdate)
	end
end

function slot0._onDeleteTaskList(slot0, slot1)
	if Activity133Model.instance:deleteInfo(slot1.taskIds) then
		uv0.instance:dispatchEvent(Activity133Event.OnTaskUpdate)
	end
end

function slot0.openActivity133MainView(slot0, slot1)
	Activity133Rpc.instance:sendGet133InfosRequest(slot1, function ()
		ViewMgr.instance:openView(ViewName.Activity133View, {
			actId = uv0
		})
	end)
end

function slot0.openActivity133TaskView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.Activity133TaskView, {
		actId = slot1
	})
end

function slot0.reInit(slot0)
end

slot0.instance = slot0.New()

return slot0
