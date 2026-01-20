-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/view/TaskViewBaseContainer.lua

module("modules.logic.versionactivity3_1.gaosiniao.view.TaskViewBaseContainer", package.seeall)

local TaskViewBaseContainer = class("TaskViewBaseContainer", BaseViewContainer)

function TaskViewBaseContainer:sendGetTaskInfoRequest(callback, callbackObj)
	TaskRpc.instance:sendGetTaskInfoRequest({
		self:taskType()
	}, callback, callbackObj)
end

function TaskViewBaseContainer:sendFinishAllTaskRequest(callback, callbackObj)
	TaskRpc.instance:sendFinishAllTaskRequest(self:taskType(), nil, nil, callback, callbackObj, self:actId())
end

function TaskViewBaseContainer:sendFinishTaskRequest(taskId, callback, callbackObj)
	TaskRpc.instance:sendFinishTaskRequest(taskId, callback, callbackObj)
end

function TaskViewBaseContainer:getActivityRemainTimeStr()
	return ActivityHelper.getActivityRemainTimeStr(self:actId())
end

function TaskViewBaseContainer:actId()
	assert(false, "please override this function")
end

function TaskViewBaseContainer:taskType()
	assert(false, "please override this function")
end

return TaskViewBaseContainer
