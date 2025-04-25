module("modules.logic.popup.controller.PopupController", package.seeall)

slot0 = class("PopupController", BaseController)

function slot0.onInit(slot0)
	slot0._popupList = PriorityQueue.New(function (slot0, slot1)
		return slot1[1] < slot0[1]
	end)
	slot0._locked = nil
	slot0._curPopup = nil
	slot0._addEvents = nil
	slot0._subPriorityDict = {}
	slot0._pauseDict = {}
end

function slot0.reInit(slot0)
	slot0._popupHistory = {}
	slot0._popupList = PriorityQueue.New(function (slot0, slot1)
		return slot1[1] < slot0[1]
	end)
	slot0._locked = nil
	slot0._curPopup = nil
	slot0._addEvents = nil
	slot0._subPriorityDict = {}
	slot0._pauseDict = {}
end

function slot0.clear(slot0)
	slot0:reInit()
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0._getSubPriority(slot0, slot1)
	slot2 = 0
	slot0._subPriorityDict[slot1] = (slot0._subPriorityDict[slot1] or 0) - 1e-05

	return slot1 + slot0._subPriorityDict[slot1]
end

function slot0._resetSubPriority(slot0)
	slot0._subPriorityDict = {}
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot0._curPopup and slot1 == slot0._curPopup[2] then
		slot0:_checkViewCloseGC(slot1)
		slot0:_endPopupView()
	end
end

function slot0.addPopupView(slot0, slot1, slot2, slot3)
	slot0._popupList:add({
		slot0:_getSubPriority(slot1),
		slot2,
		slot3
	})
	slot0:_tryShowView()
end

function slot0._tryShowView(slot0)
	if not slot0._locked then
		UIBlockMgr.instance:startBlock("PopupController")
		TaskDispatcher.cancelTask(slot0._showPopupView, slot0)
		TaskDispatcher.runDelay(slot0._showPopupView, slot0, 0.1)
	end

	if SLFramework.FrameworkSettings.IsEditor then
		ViewMgr.instance:closeView(ViewName.GMToolView)
	end
end

function slot0._showPopupView(slot0)
	UIBlockMgr.instance:endBlock("PopupController")

	if slot0:isPause() then
		return
	end

	if slot0._locked or slot0._popupList:getSize() == 0 then
		if slot0._popupList:getSize() == 0 then
			slot0:_resetSubPriority()
		end

		return
	end

	slot0._locked = true
	slot0._curPopup = slot0._popupList:getFirstAndRemove()
	slot2 = slot0._curPopup[3]

	if slot0._curPopup[2] == ViewName.MessageBoxView then
		if type(slot2.extra) == "table" then
			GameFacade.showMessageBox(slot2.messageBoxId, slot2.msgBoxType, slot2.yesCallback, slot2.noCallback, slot2.openCallback, slot2.yesCallbackObj, slot2.noCallbackObj, slot2.openCallbackObj, unpack(slot2.extra))
		else
			GameFacade.showMessageBox(slot2.messageBoxId, slot2.msgBoxType, slot2.yesCallback, slot2.noCallback, slot2.openCallback, slot2.yesCallbackObj, slot2.noCallbackObj, slot2.openCallbackObj)
		end
	else
		ViewMgr.instance:openView(slot1, slot2)
	end

	if not slot0._addEvents then
		slot0._addEvents = true

		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	end
end

function slot0._endPopupView(slot0)
	slot0._locked = false

	if slot0._addEvents then
		slot0._addEvents = nil

		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	end

	slot0:_showPopupView()
end

function slot0._checkViewCloseGC(slot0, slot1)
	if (slot0._popupHistory and #slot0._popupHistory or 0) >= 2 and slot1 == slot0._popupHistory[slot2] then
		slot0._popupHistory = {}

		GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 0.1, slot0)
	else
		slot0._popupHistory = slot0._popupHistory or {}

		table.insert(slot0._popupHistory, slot1)
	end
end

function slot0.setPause(slot0, slot1, slot2)
	if slot2 then
		slot0._pauseDict[slot1] = true
	else
		slot0._pauseDict[slot1] = nil
	end

	if not slot0:isPause() then
		slot0:_tryShowView()
	end
end

function slot0.isPause(slot0)
	for slot4, slot5 in pairs(slot0._pauseDict) do
		if slot5 then
			return true
		end
	end

	return false
end

function slot0.getPopupCount(slot0)
	return slot0._popupList:getSize()
end

slot0.instance = slot0.New()

return slot0
