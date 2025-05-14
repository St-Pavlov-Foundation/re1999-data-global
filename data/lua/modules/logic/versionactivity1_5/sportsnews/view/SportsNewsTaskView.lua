module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsTaskView", package.seeall)

local var_0_0 = class("SportsNewsTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrolltablist = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_tablist")
	arg_1_0._simagepaperbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_paperbg")
	arg_1_0._scrolltasklist = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_tasklist")
	arg_1_0._gotaskitemcontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_tasklist/Viewport/task")
	arg_1_0._gotabitemcontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_tablist/Viewport/content")
	arg_1_0._btnclosebtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closebtn")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclosebtn:AddClickListener(arg_2_0._btnclosebtnOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btnclosebtnOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclosebtn:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btnclosebtnOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._taskItems = {}
	arg_5_0._taskDayTabs = {}
end

function var_0_0.onDestroyView(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0._taskItems) do
		gohelper.setActive(iter_6_1.go, true)
	end

	for iter_6_2, iter_6_3 in pairs(arg_6_0._taskDayTabs) do
		iter_6_3:onDestroyView()
	end
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = arg_7_0.viewParam.index

	arg_7_0:addEventCb(ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskListInit, arg_7_0.taskListInit, arg_7_0)
	arg_7_0:addEventCb(ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskListUpdated, arg_7_0.refreshUI, arg_7_0)
	arg_7_0:addEventCb(ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskDayChanged, arg_7_0.refreshUI, arg_7_0)
	arg_7_0:addEventCb(ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskListNeedClose, arg_7_0.closeThis, arg_7_0)
	ActivityWarmUpTaskController.instance:init(arg_7_0.viewParam.actId, var_7_0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity106
	})
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)

	arg_7_0.jumpTab = SportsNewsModel.instance:getJumpToTab(arg_7_0.viewParam.actId)

	if arg_7_0.jumpTab then
		ActivityWarmUpTaskListModel.instance:init(arg_7_0.viewParam.actId)
		ActivityWarmUpTaskController.instance:changeSelectedDay(arg_7_0.jumpTab)
	end
end

function var_0_0.onClose(arg_8_0)
	arg_8_0:removeEventCb(ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskListInit, arg_8_0.taskListInit, arg_8_0)
	arg_8_0:removeEventCb(ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskListUpdated, arg_8_0.refreshUI, arg_8_0)
	arg_8_0:removeEventCb(ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskDayChanged, arg_8_0.refreshUI, arg_8_0)
	arg_8_0:removeEventCb(ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskListNeedClose, arg_8_0.closeThis, arg_8_0)
	ActivityWarmUpTaskController.instance:release()

	if arg_8_0._taskItems then
		for iter_8_0, iter_8_1 in pairs(arg_8_0._taskItems) do
			iter_8_1:onClose()
			TaskDispatcher.cancelTask(function()
				iter_8_1:_playOpenInner()
			end)
		end
	end
end

function var_0_0.onClickModalMask(arg_10_0)
	arg_10_0:closeThis()
end

function var_0_0.refreshUI(arg_11_0)
	arg_11_0:refreshList()
	arg_11_0:refreshTab()
end

function var_0_0.taskListInit(arg_12_0)
	if arg_12_0._taskItems then
		for iter_12_0, iter_12_1 in pairs(arg_12_0._taskItems) do
			local var_12_0 = (iter_12_0 - 1) * 0.06

			TaskDispatcher.runDelay(function()
				iter_12_1:_playOpenInner()
			end, arg_12_0, var_12_0)
		end
	end
end

function var_0_0.refreshList(arg_14_0)
	local var_14_0 = ActivityWarmUpTaskListModel.instance:getList()
	local var_14_1 = math.max(#var_14_0, #arg_14_0._taskItems)

	for iter_14_0 = 1, var_14_1 do
		local var_14_2 = var_14_0[iter_14_0]
		local var_14_3 = arg_14_0:getOrCreateTaskItem(iter_14_0)

		if var_14_2 then
			var_14_3:onUpdateMO(var_14_2)
		else
			gohelper.setActive(var_14_3.go, false)
		end
	end
end

function var_0_0.refreshTab(arg_15_0)
	local var_15_0 = ActivityWarmUpModel.instance:getTotalContentDays()

	for iter_15_0 = 1, var_15_0 do
		local var_15_1 = arg_15_0:getOrCreateTaskDayTab(iter_15_0)

		var_15_1:onRefresh()

		local var_15_2 = ActivityWarmUpTaskListModel.instance:dayHasReward(iter_15_0)

		gohelper.setActive(var_15_1.goreddot, var_15_2)
	end
end

function var_0_0.getOrCreateTaskItem(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0._taskItems[arg_16_1]

	if not var_16_0 then
		var_16_0 = arg_16_0:getUserDataTb_()

		local var_16_1 = arg_16_0.viewContainer:getSetting().otherRes[1]
		local var_16_2 = arg_16_0:getResInst(var_16_1, arg_16_0._gotaskitemcontent, "task_item" .. tostring(arg_16_1))

		var_16_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_16_2, SportsNewsTaskItem)

		var_16_0:initData(arg_16_1, var_16_2, arg_16_0)

		arg_16_0._taskItems[arg_16_1] = var_16_0
	end

	return var_16_0
end

function var_0_0.getOrCreateTaskDayTab(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._taskDayTabs[arg_17_1]

	if not var_17_0 then
		var_17_0 = arg_17_0:getUserDataTb_()

		local var_17_1 = arg_17_0.viewContainer:getSetting().otherRes[2]
		local var_17_2 = arg_17_0:getResInst(var_17_1, arg_17_0._gotabitemcontent, "tab_item" .. tostring(arg_17_1))

		var_17_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_17_2, SportsNewsTaskPageTabItem)

		var_17_0:initData(arg_17_1, var_17_2)

		arg_17_0._taskDayTabs[arg_17_1] = var_17_0
	end

	return var_17_0
end

return var_0_0
