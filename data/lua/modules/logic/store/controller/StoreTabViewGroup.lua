module("modules.logic.store.controller.StoreTabViewGroup", package.seeall)

slot0 = class("StoreTabViewGroup", TabViewGroup)

function slot0.onOpen(slot0)
	slot0.viewContainer:registerCallback(ViewEvent.ToSwitchTab, slot0._toSwitchTab, slot0)
	slot0:_openTabView(slot0.viewParam and type(slot0.viewParam) == "table" and slot0.viewParam.defaultTabIds and slot0.viewParam.defaultTabIds[slot0._tabContainerId] or 1)
end

function slot0._toSwitchTab(slot0, slot1, slot2)
	if slot1 == slot0._tabContainerId then
		slot0:_openTabView(slot2)
	end
end

function slot0._openTabView(slot0, slot1)
	slot0:_closeTabView()

	slot0._curTabId = slot1

	if slot0._tabAbLoaders[slot0._curTabId] then
		slot0:_setVisible(slot0._curTabId, true)
		slot0._tabViews[slot0._curTabId]:onOpenInternal()
	else
		slot0._tabAbLoaders[slot0._curTabId] = MultiAbLoader.New()
		slot3 = slot0.viewContainer:getSetting().tabRes

		for slot7, slot8 in pairs(lua_store_recommend.configDict) do
			if slot8.isCustomLoad == 1 and slot8.prefab == slot0._curTabId then
				slot3[slot0._tabContainerId][slot8.prefab] = {
					string.format("ui/viewres/%s.prefab", slot8.res)
				}
				slot0._tabViews[slot0._curTabId] = _G[slot8.className].New()
				slot0._tabViews[slot0._curTabId].config = slot8
			end
		end

		if slot3 and slot3[slot0._tabContainerId] and slot3[slot0._tabContainerId][slot0._curTabId] then
			UIBlockMgr.instance:startBlock(slot0._UIBlockKey)
			slot2:setPathList(slot4)
			slot2:startLoad(slot0._finishCallback, slot0)
		else
			logError(string.format("TabView no res: tabContainerId_%d, tabId_%d", slot0._tabContainerId, slot0._curTabId))
		end
	end
end

return slot0
