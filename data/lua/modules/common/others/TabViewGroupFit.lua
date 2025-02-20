module("modules.common.others.TabViewGroupFit", package.seeall)

slot0 = class("TabViewGroupFit", BaseView)

function slot0.ctor(slot0, slot1, slot2)
	uv0.super.ctor(slot0)

	slot0._tabContainerId = slot1 or 1
	slot0._tabGOContainerPath = slot2
	slot0._tabGOContainer = nil
	slot0._tabAbLoaders = {}
	slot0._tabCanvasGroup = {}
	slot0._tabViews = nil
	slot0._curTabId = nil
	slot0._hasOpenFinish = false
	slot0._UIBlockKey = nil
end

function slot0.onInitView(slot0)
	slot0._UIBlockKey = slot0.viewName .. UIBlockKey.TabViewOpening .. slot0._tabContainerId
	slot0._tabGOContainer = slot0.viewGO

	if not string.nilorempty(slot0._tabGOContainerPath) then
		slot0._tabGOContainer = gohelper.findChild(slot0.viewGO, slot0._tabGOContainerPath)
	end

	if not slot0._tabGOContainer then
		logError(slot0.viewName .. " tabGOContainer not exist: " .. slot0._tabGOContainerPath)
	end

	slot0._tabViews = slot0.viewContainer:buildTabViews(slot0._tabContainerId)
	slot0._rawGetRes = slot0.viewContainer.getRes
	slot0._rawGetResInst = slot0.viewContainer.getResInst

	slot0:_setHook()
end

function slot0.onOpen(slot0)
	slot0.viewContainer:registerCallback(ViewEvent.ToSwitchTab, slot0._toSwitchTab, slot0)
	slot0:_openTabView(slot0.viewParam and type(slot0.viewParam) == "table" and slot0.viewParam.defaultTabIds and slot0.viewParam.defaultTabIds[slot0._tabContainerId] or 1)
end

function slot0.onOpenFinish(slot0)
	for slot4, slot5 in pairs(slot0._tabViews) do
		if slot0._tabAbLoaders[slot4] and slot6.isTabLoadFinished then
			slot5:onOpenFinishInternal()
		end
	end

	slot0._hasOpenFinish = true
end

function slot0.onUpdateParam(slot0)
	for slot4, slot5 in pairs(slot0._tabViews) do
		if slot0._tabAbLoaders[slot4] and slot6.isTabLoadFinished then
			slot5:onUpdateParamInternal()
		end
	end
end

function slot0.onClose(slot0)
	slot0._hasOpenFinish = false
	slot4 = ViewEvent.ToSwitchTab
	slot5 = slot0._toSwitchTab

	slot0.viewContainer:unregisterCallback(slot4, slot5, slot0)

	for slot4, slot5 in pairs(slot0._tabViews) do
		slot0:_closeTabView(slot4)
	end
end

function slot0.onCloseFinish(slot0)
	for slot4, slot5 in pairs(slot0._tabViews) do
		if slot0._tabAbLoaders[slot4] and slot6.isTabLoadFinished then
			slot5:onCloseFinishInternal()
		end
	end

	slot0._curTabId = nil
end

function slot0.removeEvents(slot0)
	if slot0._tabViews then
		for slot4, slot5 in pairs(slot0._tabViews) do
			if slot0._tabAbLoaders[slot4] and slot6.isTabLoadFinished then
				slot5:removeEventsInternal()
			end
		end
	end
end

function slot0.onDestroyView(slot0)
	slot0:_resetHook()

	if slot0._tabViews then
		for slot4, slot5 in pairs(slot0._tabViews) do
			if slot0._tabAbLoaders[slot4] and slot6.isTabLoadFinished then
				slot5:onDestroyViewInternal()
				slot5:__onDispose()
			end
		end
	end

	for slot4, slot5 in pairs(slot0._tabAbLoaders) do
		slot5:dispose()
	end

	slot0._tabAbLoaders = nil
	slot0._tabCanvasGroup = nil
	slot0._tabGOContainer = nil
	slot0._tabViews = nil
end

function slot0.getTabContainerId(slot0)
	return slot0._tabContainerId
end

function slot0.getCurTabId(slot0)
	return slot0._curTabId
end

function slot0._toSwitchTab(slot0, slot1, slot2)
	if slot1 == slot0._tabContainerId then
		slot0:_openTabView(slot2)
	end
end

function slot0._openTabView(slot0, slot1)
	slot0:_switchCloseTabView(slot0._curTabId)

	slot0._curTabId = slot1

	ViewMgr.instance:dispatchEvent(ViewEvent.BeforeOpenTabView, {
		tabGroupView = slot0,
		viewName = slot0.viewName,
		tabView = slot0._tabViews[slot0._curTabId]
	})

	if slot0._tabAbLoaders[slot0._curTabId] then
		if not slot2.isTabLoadFinished then
			return
		end

		slot0:_setVisible(slot0._curTabId, true)

		if slot0._tabViews[slot0._curTabId].onTabSwitchOpen then
			slot3:onTabSwitchOpen()
		end

		if slot0._tabOpenFinishCallback then
			slot0._tabOpenFinishCallback(slot0._tabOpenFinishCallbackObj, slot0._curTabId, slot3, false)
		end
	else
		slot0._tabAbLoaders[slot0._curTabId] = MultiAbLoader.New()

		if slot0.viewContainer:getSetting().tabRes and slot4[slot0._tabContainerId] and slot4[slot0._tabContainerId][slot0._curTabId] then
			UIBlockMgr.instance:startBlock(slot0._UIBlockKey)
			slot3:setPathList(slot5)
			slot3:startLoad(slot0._finishCallback, slot0)
		else
			logError(string.format("TabView no res: tabContainerId_%d, tabId_%d", slot0._tabContainerId, slot0._curTabId))
		end
	end
end

function slot0._switchCloseTabView(slot0, slot1)
	if slot1 and slot0._tabAbLoaders[slot1] then
		if slot2.isLoading then
			slot2:dispose()

			slot0._tabAbLoaders[slot1] = nil

			UIBlockMgr.instance:endBlock(slot0._UIBlockKey)
		elseif slot2.isTabLoadFinished then
			if slot0._tabViews[slot1].onTabSwitchClose then
				slot3:onTabSwitchClose()
			end

			slot0:_setVisible(slot1, false)

			if slot0._tabCloseFinishCallback then
				slot0._tabCloseFinishCallback(slot0._tabCloseFinishCallbackObj, slot1, slot3)
			end
		end
	end
end

function slot0._closeTabView(slot0, slot1)
	if slot1 and slot0._tabAbLoaders[slot1] then
		if slot2.isLoading then
			slot2:dispose()

			slot0._tabAbLoaders[slot1] = nil

			UIBlockMgr.instance:endBlock(slot0._UIBlockKey)
		elseif slot2.isTabLoadFinished then
			if slot0._tabViews[slot1].onTabSwitchClose then
				slot3:onTabSwitchClose(true)
			end

			slot3:onCloseInternal()

			if slot0._keepCloseVisible then
				return
			end

			slot0:_setVisible(slot1, false)
		end
	end
end

function slot0._setVisible(slot0, slot1, slot2)
	if not slot0._tabCanvasGroup then
		return
	end

	if not slot0._tabCanvasGroup[slot1] then
		slot0._tabCanvasGroup[slot1] = gohelper.onceAddComponent(slot0._tabViews[slot1].viewGO, typeof(UnityEngine.CanvasGroup))
	end

	if slot2 then
		slot3.alpha = 1
		slot3.interactable = true
		slot3.blocksRaycasts = true
	else
		slot3.alpha = 0
		slot3.interactable = false
		slot3.blocksRaycasts = false
	end
end

function slot0.setTabCloseFinishCallback(slot0, slot1, slot2)
	slot0._tabCloseFinishCallback = slot1
	slot0._tabCloseFinishCallbackObj = slot2
end

function slot0.setTabOpenFinishCallback(slot0, slot1, slot2)
	slot0._tabOpenFinishCallback = slot1
	slot0._tabOpenFinishCallbackObj = slot2
end

function slot0.setTabAlpha(slot0, slot1, slot2)
	if not slot0._tabCanvasGroup then
		return
	end

	if not slot0._tabCanvasGroup[slot1] then
		if not slot0._tabViews[slot1].viewGO then
			return
		end

		slot0._tabCanvasGroup[slot1] = gohelper.onceAddComponent(slot4, typeof(UnityEngine.CanvasGroup))
	end

	if slot3 then
		slot3.alpha = slot2
	end
end

function slot0.keepCloseVisible(slot0, slot1)
	slot0._keepCloseVisible = slot1
end

function slot0._setHook(slot0)
	function slot0.viewContainer.getRes(slot0, slot1)
		if uv0:_getRes(slot1) then
			return slot2
		end

		return uv0._rawGetRes(slot0, slot1)
	end

	function slot0.viewContainer.getResInst(slot0, slot1, slot2, slot3)
		if uv0:_getResInst(slot1, slot2, slot3) then
			return slot4
		end

		return uv0._rawGetResInst(slot0, slot1, slot2, slot3)
	end
end

function slot0._resetHook(slot0)
	slot0.viewContainer.getRes = slot0._rawGetRes
	slot0.viewContainer.getResInst = slot0._rawGetResInst
	slot0._rawGetRes = nil
	slot0._rawGetResInst = nil
end

function slot0._getRes(slot0, slot1)
	for slot5, slot6 in pairs(slot0._tabAbLoaders) do
		if slot6.isTabLoadFinished and slot6:getAssetItem(slot1) then
			return slot7:GetResource(slot1)
		end
	end

	return nil
end

function slot0._getResInst(slot0, slot1, slot2, slot3)
	for slot7, slot8 in pairs(slot0._tabAbLoaders) do
		if slot8.isTabLoadFinished and slot8:getAssetItem(slot1) and slot9:GetResource(slot1) then
			return gohelper.clone(slot10, slot2, slot3)
		end
	end
end

function slot0._finishCallback(slot0, slot1)
	UIBlockMgr.instance:endBlock(slot0._UIBlockKey)

	if slot0._tabViews[slot0._curTabId] then
		slot1.isTabLoadFinished = true

		slot5:__onInit()

		slot5.rootGO = slot0.viewGO
		slot5.viewGO = gohelper.clone(slot1:getFirstAssetItem():GetResource(), slot0._tabGOContainer)
		slot5.tabContainer = slot0
		slot5.viewContainer = slot0.viewContainer
		slot5.viewName = slot0.viewName
		slot5.viewParam = slot0.viewParam

		slot0:_setVisible(slot0._curTabId, true)
		slot5:onInitViewInternal()
		slot5:addEventsInternal()
		slot5:onOpenInternal()

		if slot5.onTabSwitchOpen then
			slot5:onTabSwitchOpen()
		end

		if slot0._hasOpenFinish then
			slot5:onOpenFinishInternal()
		end

		if slot0._tabOpenFinishCallback then
			slot0._tabOpenFinishCallback(slot0._tabOpenFinishCallbackObj, slot0._curTabId, slot5, true)
		end
	else
		logError(string.format("TabView not exist: tabContainerId_%d, tabId_%d", slot0._tabContainerId, slot0._curTabId))
	end
end

function slot0._hasLoaded(slot0, slot1)
	slot2 = slot0._tabAbLoaders and slot0._tabAbLoaders[slot1]

	return slot2 and slot2.isTabLoadFinished
end

return slot0
