module("modules.logic.season.view1_6.Season1_6TaskView", package.seeall)

slot0 = class("Season1_6TaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._goScroll = gohelper.findChild(slot0.viewGO, "#scroll_tasklist")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "#scroll_tasklist/Viewport/Content")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(SeasonViewHelper.getSeasonIcon("full/bg1.png"))

	slot0._items = {}
end

function slot0.onOpen(slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0.updateTask, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0.updateTask, slot0)
	slot0:refreshTask(true)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0.updateTask, slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0.updateTask, slot0)
end

function slot0.updateTask(slot0)
	TaskDispatcher.cancelTask(slot0.refreshTask, slot0)
	TaskDispatcher.runDelay(slot0.refreshTask, slot0, 0.2)
end

function slot0.refreshTask(slot0, slot1)
	slot3 = {
		[slot8] = slot9
	}

	for slot8, slot9 in ipairs(Activity104TaskModel.instance:getTaskSeasonList()) do
		if slot9.hasFinished then
			slot4 = 0 + 1
		end
	end

	if slot4 > 1 then
		table.insert(slot3, 1, {
			isTotalGet = true
		})
	end

	slot0._dataList = slot3

	TaskDispatcher.cancelTask(slot0.showByLine, slot0)

	if slot1 then
		for slot8, slot9 in ipairs(slot0._items) do
			slot9:hide()
		end

		slot0._repeatCount = 0

		TaskDispatcher.runRepeat(slot0.showByLine, slot0, 0.04, #slot0._dataList)
	else
		slot8 = #slot0._items

		for slot8 = 1, math.max(#slot0._dataList, slot8) do
			slot0:getItem(slot8):onUpdateMO(slot0._dataList[slot8])
		end
	end
end

function slot0.showByLine(slot0)
	slot0._repeatCount = slot0._repeatCount + 1
	slot1 = slot0._repeatCount

	slot0:getItem(slot1):onUpdateMO(slot0._dataList[slot1], true)

	if slot1 >= #slot0._dataList then
		TaskDispatcher.cancelTask(slot0.showByLine, slot0)
	end
end

function slot0.getItem(slot0, slot1)
	if slot0._items[slot1] then
		return slot0._items[slot1]
	end

	slot4 = Season1_6TaskItem.New(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._goContent, "item" .. slot1), slot0._goScroll)
	slot0._items[slot1] = slot4

	return slot4
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.refreshTask, slot0)
	TaskDispatcher.cancelTask(slot0.showByLine, slot0)
	slot0._simagebg:UnLoadImage()

	for slot4, slot5 in pairs(slot0._items) do
		slot5:destroy()
	end

	slot0._items = nil
end

return slot0
