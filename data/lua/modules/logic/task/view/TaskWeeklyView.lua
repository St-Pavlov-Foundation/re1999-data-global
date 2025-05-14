module("modules.logic.task.view.TaskWeeklyView", package.seeall)

local var_0_0 = class("TaskWeeklyView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goleft = gohelper.findChild(arg_1_0.viewGO, "#go_left")
	arg_1_0._goallcomplete = gohelper.findChild(arg_1_0.viewGO, "#go_allcomplete")
	arg_1_0._gonormaltask = gohelper.findChild(arg_1_0.viewGO, "#go_left/Viewport/#go_normaltask")
	arg_1_0._gotasklevel = gohelper.findChild(arg_1_0.viewGO, "#go_left/Viewport/#go_normaltask/#go_tasklevel")
	arg_1_0._goright = gohelper.findChild(arg_1_0.viewGO, "#go_right")
	arg_1_0._gotaskitemcontent = gohelper.findChild(arg_1_0.viewGO, "#go_right/viewport/#go_taskitemcontent")
	arg_1_0._txtLeftTime = gohelper.findChildText(arg_1_0.viewGO, "#txtLeftTime")
	arg_1_0._allCompleteAni = arg_1_0._goallcomplete:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._goallcomplete, false)

	arg_4_0._tasklevels = {}
	arg_4_0._taskItems = {}
end

function var_0_0.onUpdateParam(arg_5_0)
	arg_5_0:_refreshWeekly()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_6_0._updateWeekly, arg_6_0)
	arg_6_0:addEventCb(TaskController.instance, TaskEvent.SetTaskList, arg_6_0._updateWeekly, arg_6_0)
	arg_6_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_6_0._updateWeekly, arg_6_0)
	arg_6_0:addEventCb(TaskController.instance, TaskEvent.OnShowTaskFinished, arg_6_0._onShowTaskFinished, arg_6_0)

	local var_6_0 = TaskModel.instance:getMaxStage(TaskEnum.TaskType.Weekly)
	local var_6_1 = TaskModel.instance:getTaskActivityMO(TaskEnum.TaskType.Weekly).defineId + 1
	local var_6_2 = var_6_0 - var_6_1 >= 5 and 160 * (var_6_1 - 1) or 160 * (var_6_0 - 5)

	transformhelper.setLocalPosXY(arg_6_0._gonormaltask.transform, 0, var_6_2)

	local var_6_3 = TaskView.getInitTaskType()

	if TaskModel.instance:getRefreshCount() == 0 and var_6_3 ~= TaskEnum.TaskType.Weekly then
		return
	end

	if #arg_6_0._taskItems < 1 then
		arg_6_0:_refreshWeekly()
	end

	arg_6_0:_showAllComplete()
end

function var_0_0._onShowTaskFinished(arg_7_0, arg_7_1)
	if arg_7_1 == TaskEnum.TaskType.Weekly then
		return
	end

	arg_7_0:_refreshWeekly()
end

function var_0_0._refreshWeekly(arg_8_0)
	local var_8_0 = TaskModel.instance:getRefreshCount() < 2

	arg_8_0:_refreshLeftTime()
	TaskDispatcher.cancelTask(arg_8_0._refreshLeftTime, arg_8_0)
	TaskDispatcher.runRepeat(arg_8_0._refreshLeftTime, arg_8_0, 1)
	arg_8_0:_refreshTaskLevelItem(var_8_0)
	arg_8_0:_setCommonTaskItem(var_8_0)
end

function var_0_0._updateWeekly(arg_9_0)
	local var_9_0 = TaskModel.instance:getMaxStage(TaskEnum.TaskType.Weekly)
	local var_9_1 = TaskModel.instance:getTaskActivityMO(TaskEnum.TaskType.Weekly).defineId + 1
	local var_9_2 = var_9_0 - var_9_1 >= 5 and 160 * (var_9_1 - 1) or 160 * (var_9_0 - 5)

	transformhelper.setLocalPosXY(arg_9_0._gonormaltask.transform, 0, var_9_2)
	TaskDispatcher.cancelTask(arg_9_0._refreshLeftTime, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._updateItems, arg_9_0)
	UIBlockMgr.instance:startBlock("taskupdateitems")
	TaskDispatcher.runDelay(arg_9_0._updateItems, arg_9_0, 0.4)
end

function var_0_0._updateItems(arg_10_0)
	arg_10_0:_refreshTaskLevelItem()
	arg_10_0:_setCommonTaskItem()
	arg_10_0:_refreshLeftTime()
	TaskDispatcher.cancelTask(arg_10_0._refreshLeftTime, arg_10_0)
	TaskDispatcher.runRepeat(arg_10_0._refreshLeftTime, arg_10_0, 1)
	arg_10_0:_showAllComplete()
	UIBlockMgr.instance:endBlock("taskupdateitems")
end

function var_0_0._showAllComplete(arg_11_0)
	local var_11_0 = TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Weekly)

	gohelper.setActive(arg_11_0._goallcomplete, var_11_0)

	if var_11_0 then
		for iter_11_0, iter_11_1 in pairs(arg_11_0._tasklevels) do
			iter_11_1:showAllComplete()
		end

		for iter_11_2, iter_11_3 in pairs(arg_11_0._taskItems) do
			iter_11_3:showAllComplete()
		end
	end
end

function var_0_0._refreshLeftTime(arg_12_0)
	local var_12_0 = TaskModel.instance:getTaskTypeExpireTime(TaskEnum.TaskType.Weekly) - ServerTime.now()

	if var_12_0 > 0 then
		local var_12_1 = TimeUtil.getFormatTime_overseas(var_12_0)

		arg_12_0._txtLeftTime.text = var_12_1 and luaLang("task_remaintime") .. var_12_1 or ""
	else
		arg_12_0._txtLeftTime.text = luaLang("bp_dateLeft_timeout")
	end
end

function var_0_0._refreshTaskLevelItem(arg_13_0, arg_13_1)
	local var_13_0 = TaskConfig.instance:getTaskActivityBonusConfig(TaskEnum.TaskType.Weekly)
	local var_13_1 = TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Weekly)

	for iter_13_0 = 1, #var_13_0 do
		if not arg_13_0._tasklevels[iter_13_0] then
			local var_13_2 = gohelper.cloneInPlace(arg_13_0._gotasklevel.gameObject)

			gohelper.setActive(var_13_2, true)

			arg_13_0._tasklevels[iter_13_0] = TaskListCommonLevelItem.New()

			arg_13_0._tasklevels[iter_13_0]:init(var_13_2, arg_13_0._goleft)
		end

		arg_13_0._tasklevels[iter_13_0]:setItem(iter_13_0, var_13_0[iter_13_0], TaskEnum.TaskType.Weekly, arg_13_1)
	end

	arg_13_0:_showAllComplete()

	if var_13_1 then
		if arg_13_1 then
			arg_13_0._allCompleteAni:Play(UIAnimationName.Open)
		else
			arg_13_0._allCompleteAni:Play(UIAnimationName.Idle)
		end
	end
end

function var_0_0._setCommonTaskItem(arg_14_0, arg_14_1)
	if arg_14_0._taskItems then
		for iter_14_0, iter_14_1 in pairs(arg_14_0._taskItems) do
			gohelper.setActive(iter_14_1.go, false)
		end
	end

	local var_14_0 = TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Weekly) and {} or TaskModel.instance:getAllRewardUnreceivedTasks(TaskEnum.TaskType.Weekly)
	local var_14_1 = TaskListModel.instance:getTaskList(TaskEnum.TaskType.Weekly)
	local var_14_2 = #var_14_0 >= 2 and #var_14_1 + 1 or #var_14_1

	if arg_14_1 then
		UIBlockMgr.instance:startBlock("taskani")

		arg_14_0._repeatCount = 0

		TaskDispatcher.runRepeat(arg_14_0.showByLine, arg_14_0, 0.04, var_14_2)
	else
		for iter_14_2 = 1, var_14_2 do
			local var_14_3

			if #var_14_0 >= 2 and (iter_14_2 ~= 1 or true) then
				var_14_3 = var_14_1[iter_14_2 - 1]
			else
				var_14_3 = var_14_1[iter_14_2]
			end

			arg_14_0:setItem(var_14_3, iter_14_2, false)
		end
	end
end

function var_0_0.showByLine(arg_15_0)
	arg_15_0._repeatCount = arg_15_0._repeatCount + 1

	local var_15_0 = TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Weekly) and {} or TaskModel.instance:getAllRewardUnreceivedTasks(TaskEnum.TaskType.Weekly)
	local var_15_1 = TaskListModel.instance:getTaskList(TaskEnum.TaskType.Weekly)
	local var_15_2 = #var_15_0 >= 2 and #var_15_1 + 1 or #var_15_1
	local var_15_3

	if #var_15_0 >= 2 and (arg_15_0._repeatCount ~= 1 or true) then
		var_15_3 = var_15_1[arg_15_0._repeatCount - 1]
	else
		var_15_3 = var_15_1[arg_15_0._repeatCount]
	end

	arg_15_0:setItem(var_15_3, arg_15_0._repeatCount, true)

	if var_15_2 <= arg_15_0._repeatCount then
		UIBlockMgr.instance:endBlock("taskani")
		TaskDispatcher.cancelTask(arg_15_0.showByLine, arg_15_0)
		TaskDispatcher.runDelay(arg_15_0._onStartTaskFinished, arg_15_0, 0.5)
	end
end

function var_0_0._onStartTaskFinished(arg_16_0)
	local var_16_0 = TaskModel.instance:getRefreshCount()

	TaskModel.instance:setRefreshCount(var_16_0 + 1)
	TaskController.instance:dispatchEvent(TaskEvent.OnShowTaskFinished, TaskEnum.TaskType.Weekly)
end

function var_0_0.setItem(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if not arg_17_0._taskItems then
		arg_17_0._taskItems = {}
	end

	if arg_17_0._taskItems[arg_17_2] then
		arg_17_0._taskItems[arg_17_2]:showIdle()
		arg_17_0._taskItems[arg_17_2]:reset(TaskEnum.TaskType.Weekly, arg_17_2, arg_17_1)
	else
		local var_17_0 = arg_17_0.viewContainer:getSetting().otherRes[1]
		local var_17_1 = arg_17_0:getResInst(var_17_0, arg_17_0._gotaskitemcontent, "item" .. arg_17_2)

		arg_17_0._taskItems[arg_17_2] = TaskListCommonItem.New()

		arg_17_0._taskItems[arg_17_2]:init(var_17_1, TaskEnum.TaskType.Weekly, arg_17_2, arg_17_1, arg_17_3)
	end

	gohelper.setSibling(arg_17_0._taskItems[arg_17_2].go, arg_17_2)
end

function var_0_0.onClose(arg_18_0)
	return
end

function var_0_0.onDestroyView(arg_19_0)
	arg_19_0:removeEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_19_0._updateWeekly, arg_19_0)
	arg_19_0:removeEventCb(TaskController.instance, TaskEvent.SetTaskList, arg_19_0._updateWeekly, arg_19_0)
	arg_19_0:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_19_0._updateWeekly, arg_19_0)
	arg_19_0:removeEventCb(TaskController.instance, TaskEvent.OnShowTaskFinished, arg_19_0._onShowTaskFinished, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0.showByLine, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._updateItems, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._refreshLeftTime, arg_19_0)

	if arg_19_0._tasklevels then
		for iter_19_0, iter_19_1 in pairs(arg_19_0._tasklevels) do
			iter_19_1:destroy()
		end

		arg_19_0._tasklevels = nil
	end

	if arg_19_0._taskItems then
		for iter_19_2, iter_19_3 in ipairs(arg_19_0._taskItems) do
			iter_19_3:destroy()
		end

		arg_19_0._taskItems = nil
	end
end

return var_0_0
