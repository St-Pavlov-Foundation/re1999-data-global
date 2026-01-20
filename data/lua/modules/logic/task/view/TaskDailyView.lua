-- chunkname: @modules/logic/task/view/TaskDailyView.lua

module("modules.logic.task.view.TaskDailyView", package.seeall)

local TaskDailyView = class("TaskDailyView", BaseView)

function TaskDailyView:onInitView()
	self._goleft = gohelper.findChild(self.viewGO, "#go_left")
	self._goallcomplete = gohelper.findChild(self.viewGO, "#go_allcomplete")
	self._gonormaltask = gohelper.findChild(self.viewGO, "#go_left/Viewport/#go_normaltask")
	self._gotasklevel = gohelper.findChild(self.viewGO, "#go_left/Viewport/#go_normaltask/#go_tasklevel")
	self._goright = gohelper.findChild(self.viewGO, "#go_right")
	self._gotaskitemcontent = gohelper.findChild(self.viewGO, "#go_right/viewport/#go_taskitemcontent")
	self._txtLeftTime = gohelper.findChildText(self.viewGO, "#txtLeftTime")
	self._allCompleteAni = self._goallcomplete:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TaskDailyView:addEvents()
	return
end

function TaskDailyView:removeEvents()
	return
end

function TaskDailyView:_editableInitView()
	gohelper.setActive(self._goallcomplete, false)

	self._tasklevels = {}
	self._taskItems = {}
end

function TaskDailyView:onUpdateParam()
	self:_refreshDaily()
end

function TaskDailyView:onOpen()
	self:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, self._updateDaily, self)
	self:addEventCb(TaskController.instance, TaskEvent.SetTaskList, self._updateDaily, self)
	self:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, self._updateDaily, self)
	self:addEventCb(TaskController.instance, TaskEvent.OnShowTaskFinished, self._onShowTaskFinished, self)

	local totalStage = TaskModel.instance:getMaxStage(TaskEnum.TaskType.Daily)
	local curStage = TaskModel.instance:getTaskActivityMO(TaskEnum.TaskType.Daily).defineId + 1
	local y = totalStage - curStage >= 5 and 160 * (curStage - 1) or 160 * (totalStage - 5)

	transformhelper.setLocalPosXY(self._gonormaltask.transform, 0, y)

	local initType = TaskView.getInitTaskType()
	local count = TaskModel.instance:getRefreshCount()

	if count == 0 and initType ~= TaskEnum.TaskType.Daily then
		return
	end

	if #self._taskItems < 1 then
		self:_refreshDaily()
	end

	self:_showAllComplete()
end

function TaskDailyView:_onShowTaskFinished(taskType)
	if taskType == TaskEnum.TaskType.Daily then
		return
	end

	self:_refreshDaily()
end

function TaskDailyView:_refreshDaily()
	local open = TaskModel.instance:getRefreshCount() < 2

	self:_refreshLeftTime()
	TaskDispatcher.cancelTask(self._refreshLeftTime, self)
	TaskDispatcher.runRepeat(self._refreshLeftTime, self, 1)
	self:_refreshTaskLevelItem(open)
	self:_setCommonTaskItem(open)
end

function TaskDailyView:_updateDaily()
	local totalStage = TaskModel.instance:getMaxStage(TaskEnum.TaskType.Daily)
	local curStage = TaskModel.instance:getTaskActivityMO(TaskEnum.TaskType.Daily).defineId + 1
	local y = totalStage - curStage >= 5 and 160 * (curStage - 1) or 160 * (totalStage - 5)

	transformhelper.setLocalPosXY(self._gonormaltask.transform, 0, y)
	TaskDispatcher.cancelTask(self._updateItems, self)
	UIBlockMgr.instance:startBlock("taskupdateitems")
	TaskDispatcher.runDelay(self._updateItems, self, 0.4)
end

function TaskDailyView:_updateItems()
	self:_refreshTaskLevelItem()
	self:_setCommonTaskItem()
	self:_refreshLeftTime()
	TaskDispatcher.cancelTask(self._refreshLeftTime, self)
	TaskDispatcher.runRepeat(self._refreshLeftTime, self, 1)
	self:_showAllComplete()
	UIBlockMgr.instance:endBlock("taskupdateitems")
end

function TaskDailyView:_showAllComplete()
	local allRewardGet = TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Daily)

	gohelper.setActive(self._goallcomplete, allRewardGet)

	if allRewardGet then
		for _, v in pairs(self._tasklevels) do
			v:showAllComplete()
		end

		for _, v in pairs(self._taskItems) do
			v:showAllComplete()
		end
	end
end

function TaskDailyView:_refreshLeftTime()
	local leftSecond = TaskModel.instance:getTaskTypeExpireTime(TaskEnum.TaskType.Daily) - ServerTime.now()

	if leftSecond > 0 then
		local date = TimeUtil.getFormatTime(leftSecond)

		self._txtLeftTime.text = date and luaLang("task_remaintime") .. date or ""
	else
		self._txtLeftTime.text = luaLang("bp_dateLeft_timeout")
	end
end

function TaskDailyView:_refreshTaskLevelItem(open)
	local actCo = TaskConfig.instance:getTaskActivityBonusConfig(TaskEnum.TaskType.Daily)

	for i = 1, #actCo do
		if not self._tasklevels[i] then
			local child = gohelper.cloneInPlace(self._gotasklevel.gameObject)

			gohelper.setActive(child, true)

			self._tasklevels[i] = TaskListCommonLevelItem.New()

			self._tasklevels[i]:init(child, self._goleft)
		end

		self._tasklevels[i]:setItem(i, actCo[i], TaskEnum.TaskType.Daily, open)
	end

	self:_showAllComplete()

	local isAllRewardGet = TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Daily)

	if isAllRewardGet then
		if open then
			self._allCompleteAni:Play(UIAnimationName.Open)
		else
			self._allCompleteAni:Play(UIAnimationName.Idle)
		end
	end
end

function TaskDailyView:_setCommonTaskItem(open)
	if self._taskItems then
		for _, v in pairs(self._taskItems) do
			gohelper.setActive(v.go, false)
		end
	end

	local isAllRewardGet = TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Daily)
	local rewardTasks = isAllRewardGet and {} or TaskModel.instance:getAllRewardUnreceivedTasks(TaskEnum.TaskType.Daily)
	local list = TaskListModel.instance:getTaskList(TaskEnum.TaskType.Daily)
	local count = #rewardTasks >= 2 and #list + 1 or #list

	if open then
		UIBlockMgr.instance:startBlock("taskani")

		self._repeatCount = 0

		TaskDispatcher.runRepeat(self.showByLine, self, 0.04, count)
	else
		for i = 1, count do
			local co

			if #rewardTasks >= 2 and (i ~= 1 or true) then
				co = list[i - 1]
			else
				co = list[i]
			end

			self:setItem(co, i, false)
		end
	end
end

function TaskDailyView:showByLine()
	self._repeatCount = self._repeatCount + 1

	local isAllRewardGet = TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Daily)
	local rewardTasks = isAllRewardGet and {} or TaskModel.instance:getAllRewardUnreceivedTasks(TaskEnum.TaskType.Daily)
	local list = TaskListModel.instance:getTaskList(TaskEnum.TaskType.Daily)
	local count = #rewardTasks >= 2 and #list + 1 or #list
	local co

	if #rewardTasks >= 2 and (self._repeatCount ~= 1 or true) then
		co = list[self._repeatCount - 1]
	else
		co = list[self._repeatCount]
	end

	self:setItem(co, self._repeatCount, true)

	if count <= self._repeatCount then
		UIBlockMgr.instance:endBlock("taskani")
		TaskDispatcher.cancelTask(self.showByLine, self)
		TaskDispatcher.runDelay(self._onStartTaskFinished, self, 0.5)
	end
end

function TaskDailyView:_onStartTaskFinished()
	local count = TaskModel.instance:getRefreshCount()

	TaskModel.instance:setRefreshCount(count + 1)
	TaskController.instance:dispatchEvent(TaskEvent.OnShowTaskFinished, TaskEnum.TaskType.Daily)
end

function TaskDailyView:setItem(co, index, open)
	if not self._taskItems then
		self._taskItems = {}
	end

	if self._taskItems[index] then
		self._taskItems[index]:showIdle()
		self._taskItems[index]:reset(TaskEnum.TaskType.Daily, index, co)
	else
		local res = self.viewContainer:getSetting().otherRes[1]
		local go = self:getResInst(res, self._gotaskitemcontent, "item" .. index)

		self._taskItems[index] = TaskListCommonItem.New()

		self._taskItems[index]:init(go, TaskEnum.TaskType.Daily, index, co, open)
	end

	gohelper.setSibling(self._taskItems[index].go, index)
end

function TaskDailyView:onClose()
	return
end

function TaskDailyView:onDestroyView()
	TaskDispatcher.cancelTask(self.showByLine, self)
	TaskDispatcher.cancelTask(self._updateItems, self)
	TaskDispatcher.cancelTask(self._refreshLeftTime, self)
	self:removeEventCb(TaskController.instance, TaskEvent.SetTaskList, self._updateDaily, self)
	self:removeEventCb(TaskController.instance, TaskEvent.UpdateTaskList, self._updateDaily, self)
	self:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, self._updateDaily, self)
	self:removeEventCb(TaskController.instance, TaskEvent.OnShowTaskFinished, self._onShowTaskFinished, self)

	if self._tasklevels then
		for _, tasklevel in pairs(self._tasklevels) do
			tasklevel:destroy()
		end

		self._tasklevels = nil
	end

	if self._taskItems then
		for i, taskItem in ipairs(self._taskItems) do
			taskItem:destroy()
		end

		self._taskItems = nil
	end
end

return TaskDailyView
