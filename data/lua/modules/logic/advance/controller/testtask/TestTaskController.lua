module("modules.logic.advance.controller.testtask.TestTaskController", package.seeall)

slot0 = class("TestTaskController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.openTestTaskView(slot0)
	slot0:_openTestTaskView()
end

function slot0._openTestTaskView(slot0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.TestTask
	}, function ()
		ViewMgr.instance:openView(ViewName.TestTaskView)
	end)
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
