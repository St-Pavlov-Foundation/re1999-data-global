module("modules.common.others.TabViewGroupDynamic", package.seeall)

slot0 = class("TabViewGroupDynamic", BaseView)

function slot0.ctor(slot0, slot1, slot2)
	uv0.super.ctor(slot0)

	slot0._tabContainerId = slot1 or 1
	slot0._tabGOContainerPath = slot2
	slot0._tabGOContainer = nil
	slot0._tabAbLoaders = {}
	slot0._tabMainRes = {}
	slot0._tabCanvasGroup = {}
	slot0._tabViews = nil
	slot0._curTabId = nil
	slot0._hasOpenFinish = false
	slot0._UIBlockKey = nil
end

function slot0.setDynamicNodeContainers(slot0, slot1)
	slot0._dynamicNodeContainers = slot1
end

function slot0.setDynamicNodeResHandlers(slot0, slot1)
	slot0._dynamicNodeResHandlers = slot1
end

function slot0.stopOpenDefaultTab(slot0, slot1)
	slot0._isStopOpenDefaultTab = slot1
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
end

function slot0.onOpen(slot0)
	slot0.viewContainer:registerCallback(ViewEvent.ToSwitchTab, slot0._toSwitchTab, slot0)

	if slot0._isStopOpenDefaultTab then
		return
	end

	slot0:_openTabView(slot0.viewParam and type(slot0.viewParam) == "table" and slot0.viewParam.defaultTabIds and slot0.viewParam.defaultTabIds[slot0._tabContainerId] or 1)
end

function slot0.onOpenFinish(slot0)
	if slot0:_hasLoaded(slot0._curTabId) then
		slot0._tabViews[slot0._curTabId]:onOpenFinishInternal()
	else
		slot0._hasOpenFinish = true
	end
end

function slot0.onUpdateParam(slot0)
	if slot0:_hasLoaded(slot0._curTabId) then
		slot0._tabViews[slot0._curTabId]:onUpdateParamInternal()
	end
end

function slot0.onClose(slot0)
	slot0._hasOpenFinish = false

	slot0.viewContainer:unregisterCallback(ViewEvent.ToSwitchTab, slot0._toSwitchTab, slot0)
	slot0:_closeTabView()
end

function slot0.onCloseFinish(slot0)
	if slot0:_hasLoaded(slot0._curTabId) then
		slot0._tabViews[slot0._curTabId]:onCloseFinishInternal()
	end

	slot0._curTabId = nil
end

function slot0.removeEvents(slot0)
	if slot0._tabViews then
		for slot4, slot5 in pairs(slot0._tabViews) do
			if slot0._tabAbLoaders[slot4] and not slot6.isLoading then
				slot5:removeEventsInternal()
			end
		end
	end
end

function slot0.onDestroyView(slot0)
	if slot0._tabViews then
		for slot4, slot5 in pairs(slot0._tabViews) do
			if slot0._tabAbLoaders[slot4] and not slot6.isLoading then
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
	if slot0._curTabId == slot1 then
		return
	end

	slot0:_closeTabView()

	slot0._curTabId = slot1

	if not slot0._curTabId then
		return
	end

	if slot0._tabAbLoaders[slot0._curTabId] then
		slot0:_setVisible(slot0._curTabId, true)
		slot0._tabViews[slot0._curTabId]:onOpenInternal()
	else
		slot0._tabAbLoaders[slot0._curTabId] = MultiAbLoader.New()
		slot0._tabMainRes[slot0._curTabId] = (slot0.viewContainer:getSetting().tabRes and slot3[slot0._tabContainerId] and slot3[slot0._tabContainerId][slot0._curTabId])[1]

		if slot0._dynamicNodeResHandlers and slot0._dynamicNodeResHandlers[slot0._curTabId] then
			slot6 = {}

			tabletool.addValues(slot6, slot4)
			tabletool.addValues(slot6, slot0._dynamicNodeResHandlers[slot0._curTabId]())

			slot4 = slot6
		end

		if slot4 then
			UIBlockMgr.instance:startBlock(slot0._UIBlockKey)
			slot2:setPathList(slot4)
			slot2:startLoad(slot0._finishCallback, slot0)
		else
			logError(string.format("TabView no res: tabContainerId_%d, tabId_%d", slot0._tabContainerId, slot0._curTabId))
		end
	end
end

function slot0._closeTabView(slot0)
	if slot0._curTabId and slot0._tabAbLoaders[slot0._curTabId] then
		if slot1.isLoading then
			slot1:dispose()

			slot0._tabAbLoaders[slot0._curTabId] = nil

			UIBlockMgr.instance:endBlock(slot0._UIBlockKey)
		else
			slot0._tabViews[slot0._curTabId]:onCloseInternal()
			slot0:_setVisible(slot0._curTabId, false)
		end
	end
end

function slot0._setVisible(slot0, slot1, slot2)
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

function slot0._getTabGoContainer(slot0)
	if slot0._dynamicNodeContainers and slot0._dynamicNodeContainers[slot0._curTabId] then
		return gohelper.findChild(slot0.viewGO, slot1)
	end

	return slot0._tabGOContainer
end

function slot0._finishCallback(slot0, slot1)
	UIBlockMgr.instance:endBlock(slot0._UIBlockKey)

	if slot0._tabViews[slot0._curTabId] then
		slot5:__onInit()

		slot5.rootGO = slot0.viewGO
		slot5.viewGO = gohelper.clone(slot1:getAssetItem(slot0._tabMainRes[slot0._curTabId]):GetResource(), slot0:_getTabGoContainer())
		slot5.tabContainer = slot0
		slot5.viewContainer = slot0.viewContainer
		slot5.viewName = slot0.viewName
		slot5.viewParam = slot0.viewParam

		slot0:_setVisible(slot0._curTabId, true)
		slot5:onInitViewInternal()
		slot5:addEventsInternal()
		slot5:onOpenInternal()

		if slot0._hasOpenFinish then
			slot5:onOpenFinishInternal()
		end
	else
		logError(string.format("TabView not exist: tabContainerId_%d, tabId_%d", slot0._tabContainerId, slot0._curTabId))
	end
end

function slot0._hasLoaded(slot0, slot1)
	slot2 = slot0._tabAbLoaders and slot0._tabAbLoaders[slot1]

	return slot2 and not slot2.isLoading
end

return slot0
