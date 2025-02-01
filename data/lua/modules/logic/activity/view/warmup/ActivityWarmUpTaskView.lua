module("modules.logic.activity.view.warmup.ActivityWarmUpTaskView", package.seeall)

slot0 = class("ActivityWarmUpTaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._gotaskitemcontent = gohelper.findChild(slot0.viewGO, "#scroll_task/viewport/#go_taskitemcontent")
	slot0._godayitem = gohelper.findChild(slot0.viewGO, "#scroll_days/Viewport/Content/#go_dayitem")
	slot0._btncloseview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closeview")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncloseview:AddClickListener(slot0._btncloseviewOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseviewOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncloseview:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._taskItems = {}
	slot0._taskDayTabs = {}
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0._taskItems) do
		gohelper.setActive(slot5.go, true)
	end

	for slot4, slot5 in pairs(slot0._taskDayTabs) do
		slot5.btn:RemoveClickListener()
	end
end

function slot0.onOpen(slot0)
	slot0:addEventCb(ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskListUpdated, slot0.refreshUI, slot0)
	slot0:addEventCb(ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskDayChanged, slot0.refreshUI, slot0)
	slot0:addEventCb(ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskListNeedClose, slot0.closeThis, slot0)
	ActivityWarmUpTaskController.instance:init(slot0.viewParam.actId, slot0.viewParam.index)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity106
	})
end

function slot0.onClose(slot0)
	ActivityWarmUpTaskController.instance:release()
end

function slot0._btncloseviewOnClick(slot0)
	slot0:closeThis()
end

function slot0.refreshUI(slot0)
	slot0:refreshList()
	slot0:refreshTab()
end

function slot0.refreshList(slot0)
	for slot6 = 1, math.max(#ActivityWarmUpTaskListModel.instance:getList(), #slot0._taskItems) do
		slot8 = slot0:getOrCreateTaskItem(slot6)

		if slot1[slot6] then
			gohelper.setActive(slot8.go, true)
			slot8.component:onUpdateMO(slot7)
		else
			gohelper.setActive(slot8.go, false)
		end
	end
end

function slot0.refreshTab(slot0)
	slot3 = ActivityWarmUpTaskListModel.instance:getSelectedDay()

	for slot7 = 1, ActivityWarmUpModel.instance:getTotalContentDays() do
		slot8 = slot0:getOrCreateTaskDayTab(slot7)

		UISpriteSetMgr.instance:setActivityWarmUpSprite(slot8.imageChooseDay, "bg_rw" .. slot7)

		slot8.txtUnchooseDay.text = tostring(slot7)
		slot8.txtLockDay.text = tostring(slot7)

		if slot7 <= ActivityWarmUpModel.instance:getCurrentDay() then
			gohelper.setActive(slot8.goLock, false)
			gohelper.setActive(slot8.goUnchoose, slot3 ~= slot7)
			gohelper.setActive(slot8.goChoose, slot3 == slot7)
		else
			gohelper.setActive(slot8.goLock, true)
		end

		gohelper.setActive(slot8.goreddot, ActivityWarmUpTaskListModel.instance:dayHasReward(slot7))
	end
end

function slot0.getOrCreateTaskItem(slot0, slot1)
	if not slot0._taskItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot4 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._gotaskitemcontent, "task_item" .. tostring(slot1))
		slot5 = MonoHelper.addNoUpdateLuaComOnceToGo(slot4, ActivityWarmUpTaskItem)

		slot5:initData(slot1, slot4)

		slot2.go = slot4
		slot2.component = slot5
		slot0._taskItems[slot1] = slot2
	end

	return slot2
end

function slot0.getOrCreateTaskDayTab(slot0, slot1)
	if not slot0._taskDayTabs[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot3 = gohelper.cloneInPlace(slot0._godayitem, "tabday_" .. tostring(slot1))
		slot2.go = slot3
		slot2.goUnchoose = gohelper.findChild(slot3, "go_unselected")
		slot2.goChoose = gohelper.findChild(slot3, "go_selected")
		slot2.txtUnchooseDay = gohelper.findChildText(slot3, "go_unselected/txt_index")
		slot2.imageChooseDay = gohelper.findChildImage(slot3, "go_selected/img_index")
		slot2.goreddot = gohelper.findChild(slot3, "go_reddot")
		slot2.goLock = gohelper.findChild(slot3, "go_lock")
		slot2.txtLockDay = gohelper.findChildText(slot3, "go_lock/txt_index")
		slot2.btn = gohelper.findChildButtonWithAudio(slot3, "btn_click")

		slot2.btn:AddClickListener(uv0.onClickTabItem, {
			self = slot0,
			index = slot1
		})
		gohelper.setActive(slot2.go, true)

		slot0._taskDayTabs[slot1] = slot2
	end

	return slot2
end

function slot0.onClickTabItem(slot0)
	slot1 = slot0.self
	slot5 = ActivityWarmUpModel.instance:getSelectedDayOrders()

	if ActivityWarmUpTaskListModel.instance:getSelectedDay() ~= slot0.index and slot2 <= ActivityWarmUpModel.instance:getCurrentDay() then
		ActivityWarmUpTaskController.instance:changeSelectedDay(slot2)
	end
end

return slot0
