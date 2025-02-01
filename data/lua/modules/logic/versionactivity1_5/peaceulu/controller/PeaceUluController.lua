module("modules.logic.versionactivity1_5.peaceulu.controller.PeaceUluController", package.seeall)

slot0 = class("PeaceUluController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, slot0._onUpdateTaskList, slot0)
end

function slot0._onUpdateTaskList(slot0, slot1)
	PeaceUluModel.instance:setTasksInfo(slot1.taskInfo)
end

function slot0.openPeaceUluView(slot0, slot1)
	PeaceUluRpc.instance:sendGet145InfosRequest(VersionActivity1_5Enum.ActivityId.PeaceUlu, function ()
		ViewMgr.instance:openView(ViewName.PeaceUluView, {
			param = uv0
		})
	end, slot0)
end

function slot0.reInit(slot0)
end

slot0.instance = slot0.New()

return slot0
