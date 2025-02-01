module("modules.logic.task.view.TaskWeeklyView", package.seeall)

slot0 = class("TaskWeeklyView", BaseView)

function slot0.onInitView(slot0)
	slot0._goleft = gohelper.findChild(slot0.viewGO, "#go_left")
	slot0._goallcomplete = gohelper.findChild(slot0.viewGO, "#go_allcomplete")
	slot0._gonormaltask = gohelper.findChild(slot0.viewGO, "#go_left/Viewport/#go_normaltask")
	slot0._gotasklevel = gohelper.findChild(slot0.viewGO, "#go_left/Viewport/#go_normaltask/#go_tasklevel")
	slot0._goright = gohelper.findChild(slot0.viewGO, "#go_right")
	slot0._gotaskitemcontent = gohelper.findChild(slot0.viewGO, "#go_right/viewport/#go_taskitemcontent")
	slot0._txtLeftTime = gohelper.findChildText(slot0.viewGO, "#txtLeftTime")
	slot0._allCompleteAni = slot0._goallcomplete:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goallcomplete, false)

	slot0._tasklevels = {}
	slot0._taskItems = {}
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshWeekly()
end

function slot0.onOpen(slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0._updateWeekly, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SetTaskList, slot0._updateWeekly, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._updateWeekly, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnShowTaskFinished, slot0._onShowTaskFinished, slot0)
	transformhelper.setLocalPosXY(slot0._gonormaltask.transform, 0, TaskModel.instance:getMaxStage(TaskEnum.TaskType.Weekly) - (TaskModel.instance:getTaskActivityMO(TaskEnum.TaskType.Weekly).defineId + 1) >= 5 and 160 * (slot2 - 1) or 160 * (slot1 - 5))

	if TaskModel.instance:getRefreshCount() == 0 and TaskView.getInitTaskType() ~= TaskEnum.TaskType.Weekly then
		return
	end

	if #slot0._taskItems < 1 then
		slot0:_refreshWeekly()
	end

	slot0:_showAllComplete()
end

function slot0._onShowTaskFinished(slot0, slot1)
	if slot1 == TaskEnum.TaskType.Weekly then
		return
	end

	slot0:_refreshWeekly()
end

function slot0._refreshWeekly(slot0)
	slot1 = TaskModel.instance:getRefreshCount() < 2

	slot0:_refreshLeftTime()
	TaskDispatcher.cancelTask(slot0._refreshLeftTime, slot0)
	TaskDispatcher.runRepeat(slot0._refreshLeftTime, slot0, 1)
	slot0:_refreshTaskLevelItem(slot1)
	slot0:_setCommonTaskItem(slot1)
end

function slot0._updateWeekly(slot0)
	transformhelper.setLocalPosXY(slot0._gonormaltask.transform, 0, TaskModel.instance:getMaxStage(TaskEnum.TaskType.Weekly) - (TaskModel.instance:getTaskActivityMO(TaskEnum.TaskType.Weekly).defineId + 1) >= 5 and 160 * (slot2 - 1) or 160 * (slot1 - 5))
	TaskDispatcher.cancelTask(slot0._refreshLeftTime, slot0)
	TaskDispatcher.cancelTask(slot0._updateItems, slot0)
	UIBlockMgr.instance:startBlock("taskupdateitems")
	TaskDispatcher.runDelay(slot0._updateItems, slot0, 0.4)
end

function slot0._updateItems(slot0)
	slot0:_refreshTaskLevelItem()
	slot0:_setCommonTaskItem()
	slot0:_refreshLeftTime()
	TaskDispatcher.cancelTask(slot0._refreshLeftTime, slot0)
	TaskDispatcher.runRepeat(slot0._refreshLeftTime, slot0, 1)
	slot0:_showAllComplete()
	UIBlockMgr.instance:endBlock("taskupdateitems")
end

function slot0._showAllComplete(slot0)
	slot1 = TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Weekly)

	gohelper.setActive(slot0._goallcomplete, slot1)

	if slot1 then
		for slot5, slot6 in pairs(slot0._tasklevels) do
			slot6:showAllComplete()
		end

		for slot5, slot6 in pairs(slot0._taskItems) do
			slot6:showAllComplete()
		end
	end
end

function slot0._refreshLeftTime(slot0)
	if TaskModel.instance:getTaskTypeExpireTime(TaskEnum.TaskType.Weekly) - ServerTime.now() > 0 then
		slot0._txtLeftTime.text = TimeUtil.getFormatTime_overseas(slot1) and luaLang("task_remaintime") .. slot2 or ""
	else
		slot0._txtLeftTime.text = luaLang("bp_dateLeft_timeout")
	end
end

function slot0._refreshTaskLevelItem(slot0, slot1)
	slot3 = TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Weekly)

	for slot7 = 1, #TaskConfig.instance:getTaskActivityBonusConfig(TaskEnum.TaskType.Weekly) do
		if not slot0._tasklevels[slot7] then
			slot8 = gohelper.cloneInPlace(slot0._gotasklevel.gameObject)

			gohelper.setActive(slot8, true)

			slot0._tasklevels[slot7] = TaskListCommonLevelItem.New()

			slot0._tasklevels[slot7]:init(slot8, slot0._goleft)
		end

		slot0._tasklevels[slot7]:setItem(slot7, slot2[slot7], TaskEnum.TaskType.Weekly, slot1)
	end

	slot0:_showAllComplete()

	if slot3 then
		if slot1 then
			slot0._allCompleteAni:Play(UIAnimationName.Open)
		else
			slot0._allCompleteAni:Play(UIAnimationName.Idle)
		end
	end
end

function slot0._setCommonTaskItem(slot0, slot1)
	if slot0._taskItems then
		for slot5, slot6 in pairs(slot0._taskItems) do
			gohelper.setActive(slot6.go, false)
		end
	end

	slot4 = TaskListModel.instance:getTaskList(TaskEnum.TaskType.Weekly)

	if slot1 then
		UIBlockMgr.instance:startBlock("taskani")

		slot0._repeatCount = 0

		TaskDispatcher.runRepeat(slot0.showByLine, slot0, 0.04, #(TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Weekly) and {} or TaskModel.instance:getAllRewardUnreceivedTasks(TaskEnum.TaskType.Weekly)) >= 2 and #slot4 + 1 or #slot4)
	else
		for slot9 = 1, slot5 do
			slot10 = nil

			if #slot3 >= 2 then
				if slot9 == 1 then
					-- Nothing
				end

				slot10 = slot4[slot9 - 1]
			else
				slot10 = slot4[slot9]
			end

			slot0:setItem(slot10, slot9, false)
		end
	end
end

function slot0.showByLine(slot0)
	slot0._repeatCount = slot0._repeatCount + 1
	slot2 = TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Weekly) and {} or TaskModel.instance:getAllRewardUnreceivedTasks(TaskEnum.TaskType.Weekly)
	slot3 = TaskListModel.instance:getTaskList(TaskEnum.TaskType.Weekly)
	slot4 = #slot2 >= 2 and #slot3 + 1 or #slot3
	slot5 = nil

	if #slot2 >= 2 then
		if slot0._repeatCount == 1 then
			-- Nothing
		end

		slot5 = slot3[slot0._repeatCount - 1]
	else
		slot5 = slot3[slot0._repeatCount]
	end

	slot0:setItem(slot5, slot0._repeatCount, true)

	if slot4 <= slot0._repeatCount then
		UIBlockMgr.instance:endBlock("taskani")
		TaskDispatcher.cancelTask(slot0.showByLine, slot0)
		TaskDispatcher.runDelay(slot0._onStartTaskFinished, slot0, 0.5)
	end
end

function slot0._onStartTaskFinished(slot0)
	TaskModel.instance:setRefreshCount(TaskModel.instance:getRefreshCount() + 1)
	TaskController.instance:dispatchEvent(TaskEvent.OnShowTaskFinished, TaskEnum.TaskType.Weekly)
end

function slot0.setItem(slot0, slot1, slot2, slot3)
	if not slot0._taskItems then
		slot0._taskItems = {}
	end

	if slot0._taskItems[slot2] then
		slot0._taskItems[slot2]:showIdle()
		slot0._taskItems[slot2]:reset(TaskEnum.TaskType.Weekly, slot2, slot1)
	else
		slot0._taskItems[slot2] = TaskListCommonItem.New()

		slot0._taskItems[slot2]:init(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._gotaskitemcontent, "item" .. slot2), TaskEnum.TaskType.Weekly, slot2, slot1, slot3)
	end

	gohelper.setSibling(slot0._taskItems[slot2].go, slot2)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0._updateWeekly, slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.SetTaskList, slot0._updateWeekly, slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._updateWeekly, slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.OnShowTaskFinished, slot0._onShowTaskFinished, slot0)
	TaskDispatcher.cancelTask(slot0.showByLine, slot0)
	TaskDispatcher.cancelTask(slot0._updateItems, slot0)
	TaskDispatcher.cancelTask(slot0._refreshLeftTime, slot0)

	if slot0._tasklevels then
		for slot4, slot5 in pairs(slot0._tasklevels) do
			slot5:destroy()
		end

		slot0._tasklevels = nil
	end

	if slot0._taskItems then
		for slot4, slot5 in ipairs(slot0._taskItems) do
			slot5:destroy()
		end

		slot0._taskItems = nil
	end
end

return slot0
