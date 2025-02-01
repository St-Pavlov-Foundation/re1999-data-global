module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsTaskView", package.seeall)

slot0 = class("SportsNewsTaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrolltablist = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_tablist")
	slot0._simagepaperbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_paperbg")
	slot0._scrolltasklist = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_tasklist")
	slot0._gotaskitemcontent = gohelper.findChild(slot0.viewGO, "#scroll_tasklist/Viewport/task")
	slot0._gotabitemcontent = gohelper.findChild(slot0.viewGO, "#scroll_tablist/Viewport/content")
	slot0._btnclosebtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closebtn")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclosebtn:AddClickListener(slot0._btnclosebtnOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btnclosebtnOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclosebtn:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btnclosebtnOnClick(slot0)
	slot0:closeThis()
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
		slot5:onDestroyView()
	end
end

function slot0.onOpen(slot0)
	slot0:addEventCb(ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskListInit, slot0.taskListInit, slot0)
	slot0:addEventCb(ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskListUpdated, slot0.refreshUI, slot0)
	slot0:addEventCb(ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskDayChanged, slot0.refreshUI, slot0)
	slot0:addEventCb(ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskListNeedClose, slot0.closeThis, slot0)
	ActivityWarmUpTaskController.instance:init(slot0.viewParam.actId, slot0.viewParam.index)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity106
	})
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)

	slot0.jumpTab = SportsNewsModel.instance:getJumpToTab(slot0.viewParam.actId)

	if slot0.jumpTab then
		ActivityWarmUpTaskListModel.instance:init(slot0.viewParam.actId)
		ActivityWarmUpTaskController.instance:changeSelectedDay(slot0.jumpTab)
	end
end

function slot0.onClose(slot0)
	slot0:removeEventCb(ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskListInit, slot0.taskListInit, slot0)
	slot0:removeEventCb(ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskListUpdated, slot0.refreshUI, slot0)
	slot0:removeEventCb(ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskDayChanged, slot0.refreshUI, slot0)
	slot0:removeEventCb(ActivityWarmUpTaskController.instance, ActivityWarmUpEvent.TaskListNeedClose, slot0.closeThis, slot0)
	ActivityWarmUpTaskController.instance:release()

	if slot0._taskItems then
		for slot4, slot5 in pairs(slot0._taskItems) do
			slot5:onClose()
			TaskDispatcher.cancelTask(function ()
				uv0:_playOpenInner()
			end)
		end
	end
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0.refreshUI(slot0)
	slot0:refreshList()
	slot0:refreshTab()
end

function slot0.taskListInit(slot0)
	if slot0._taskItems then
		for slot4, slot5 in pairs(slot0._taskItems) do
			TaskDispatcher.runDelay(function ()
				uv0:_playOpenInner()
			end, slot0, (slot4 - 1) * 0.06)
		end
	end
end

function slot0.refreshList(slot0)
	for slot6 = 1, math.max(#ActivityWarmUpTaskListModel.instance:getList(), #slot0._taskItems) do
		if slot1[slot6] then
			slot0:getOrCreateTaskItem(slot6):onUpdateMO(slot7)
		else
			gohelper.setActive(slot8.go, false)
		end
	end
end

function slot0.refreshTab(slot0)
	for slot5 = 1, ActivityWarmUpModel.instance:getTotalContentDays() do
		slot6 = slot0:getOrCreateTaskDayTab(slot5)

		slot6:onRefresh()
		gohelper.setActive(slot6.goreddot, ActivityWarmUpTaskListModel.instance:dayHasReward(slot5))
	end
end

function slot0.getOrCreateTaskItem(slot0, slot1)
	if not slot0._taskItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot4 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._gotaskitemcontent, "task_item" .. tostring(slot1))
		slot2 = MonoHelper.addNoUpdateLuaComOnceToGo(slot4, SportsNewsTaskItem)

		slot2:initData(slot1, slot4, slot0)

		slot0._taskItems[slot1] = slot2
	end

	return slot2
end

function slot0.getOrCreateTaskDayTab(slot0, slot1)
	if not slot0._taskDayTabs[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot4 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], slot0._gotabitemcontent, "tab_item" .. tostring(slot1))
		slot2 = MonoHelper.addNoUpdateLuaComOnceToGo(slot4, SportsNewsTaskPageTabItem)

		slot2:initData(slot1, slot4)

		slot0._taskDayTabs[slot1] = slot2
	end

	return slot2
end

return slot0
