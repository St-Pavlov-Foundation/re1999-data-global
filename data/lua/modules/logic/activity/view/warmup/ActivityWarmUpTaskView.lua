module("modules.logic.activity.view.warmup.ActivityWarmUpTaskView", package.seeall)

local var_0_0 = class("ActivityWarmUpTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotaskitemcontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_task/viewport/#go_taskitemcontent")
	arg_1_0._godayitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_days/Viewport/Content/#go_dayitem")
	arg_1_0._btncloseview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeview")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncloseview:AddClickListener(arg_2_0._btncloseviewOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseviewOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncloseview:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._taskItems = {}
	arg_4_0._taskDayTabs = {}
end

function var_0_0.onDestroyView(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._taskItems) do
		gohelper.setActive(iter_5_1.go, true)
	end

	for iter_5_2, iter_5_3 in pairs(arg_5_0._taskDayTabs) do
		iter_5_3.btn:RemoveClickListener()
	end
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = arg_6_0.viewParam.index

	arg_6_0:addEventCb(ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskListUpdated, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskDayChanged, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskListNeedClose, arg_6_0.closeThis, arg_6_0)
	ActivityWarmUpTaskController.instance:init(arg_6_0.viewParam.actId, var_6_0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity106
	})
end

function var_0_0.onClose(arg_7_0)
	ActivityWarmUpTaskController.instance:release()
end

function var_0_0._btncloseviewOnClick(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0.refreshUI(arg_9_0)
	arg_9_0:refreshList()
	arg_9_0:refreshTab()
end

function var_0_0.refreshList(arg_10_0)
	local var_10_0 = ActivityWarmUpTaskListModel.instance:getList()
	local var_10_1 = math.max(#var_10_0, #arg_10_0._taskItems)

	for iter_10_0 = 1, var_10_1 do
		local var_10_2 = var_10_0[iter_10_0]
		local var_10_3 = arg_10_0:getOrCreateTaskItem(iter_10_0)

		if var_10_2 then
			gohelper.setActive(var_10_3.go, true)
			var_10_3.component:onUpdateMO(var_10_2)
		else
			gohelper.setActive(var_10_3.go, false)
		end
	end
end

function var_0_0.refreshTab(arg_11_0)
	local var_11_0 = ActivityWarmUpModel.instance:getTotalContentDays()
	local var_11_1 = ActivityWarmUpModel.instance:getCurrentDay()
	local var_11_2 = ActivityWarmUpTaskListModel.instance:getSelectedDay()

	for iter_11_0 = 1, var_11_0 do
		local var_11_3 = arg_11_0:getOrCreateTaskDayTab(iter_11_0)

		UISpriteSetMgr.instance:setActivityWarmUpSprite(var_11_3.imageChooseDay, "bg_rw" .. iter_11_0)

		var_11_3.txtUnchooseDay.text = tostring(iter_11_0)
		var_11_3.txtLockDay.text = tostring(iter_11_0)

		if iter_11_0 <= var_11_1 then
			gohelper.setActive(var_11_3.goLock, false)
			gohelper.setActive(var_11_3.goUnchoose, var_11_2 ~= iter_11_0)
			gohelper.setActive(var_11_3.goChoose, var_11_2 == iter_11_0)
		else
			gohelper.setActive(var_11_3.goLock, true)
		end

		local var_11_4 = ActivityWarmUpTaskListModel.instance:dayHasReward(iter_11_0)

		gohelper.setActive(var_11_3.goreddot, var_11_4)
	end
end

function var_0_0.getOrCreateTaskItem(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._taskItems[arg_12_1]

	if not var_12_0 then
		var_12_0 = arg_12_0:getUserDataTb_()

		local var_12_1 = arg_12_0.viewContainer:getSetting().otherRes[1]
		local var_12_2 = arg_12_0:getResInst(var_12_1, arg_12_0._gotaskitemcontent, "task_item" .. tostring(arg_12_1))
		local var_12_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_2, ActivityWarmUpTaskItem)

		var_12_3:initData(arg_12_1, var_12_2)

		var_12_0.go = var_12_2
		var_12_0.component = var_12_3
		arg_12_0._taskItems[arg_12_1] = var_12_0
	end

	return var_12_0
end

function var_0_0.getOrCreateTaskDayTab(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._taskDayTabs[arg_13_1]

	if not var_13_0 then
		var_13_0 = arg_13_0:getUserDataTb_()

		local var_13_1 = gohelper.cloneInPlace(arg_13_0._godayitem, "tabday_" .. tostring(arg_13_1))

		var_13_0.go = var_13_1
		var_13_0.goUnchoose = gohelper.findChild(var_13_1, "go_unselected")
		var_13_0.goChoose = gohelper.findChild(var_13_1, "go_selected")
		var_13_0.txtUnchooseDay = gohelper.findChildText(var_13_1, "go_unselected/txt_index")
		var_13_0.imageChooseDay = gohelper.findChildImage(var_13_1, "go_selected/img_index")
		var_13_0.goreddot = gohelper.findChild(var_13_1, "go_reddot")
		var_13_0.goLock = gohelper.findChild(var_13_1, "go_lock")
		var_13_0.txtLockDay = gohelper.findChildText(var_13_1, "go_lock/txt_index")
		var_13_0.btn = gohelper.findChildButtonWithAudio(var_13_1, "btn_click")

		var_13_0.btn:AddClickListener(var_0_0.onClickTabItem, {
			self = arg_13_0,
			index = arg_13_1
		})
		gohelper.setActive(var_13_0.go, true)

		arg_13_0._taskDayTabs[arg_13_1] = var_13_0
	end

	return var_13_0
end

function var_0_0.onClickTabItem(arg_14_0)
	local var_14_0 = arg_14_0.self
	local var_14_1 = arg_14_0.index
	local var_14_2 = ActivityWarmUpTaskListModel.instance:getSelectedDay()
	local var_14_3 = ActivityWarmUpModel.instance:getCurrentDay()
	local var_14_4 = ActivityWarmUpModel.instance:getSelectedDayOrders()

	if var_14_2 ~= var_14_1 and var_14_1 <= var_14_3 then
		ActivityWarmUpTaskController.instance:changeSelectedDay(var_14_1)
	end
end

return var_0_0
