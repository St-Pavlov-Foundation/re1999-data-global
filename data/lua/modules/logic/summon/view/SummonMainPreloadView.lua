module("modules.logic.summon.view.SummonMainPreloadView", package.seeall)

slot0 = class("SummonMainPreloadView", TabViewGroup)

function slot0.preloadTab(slot0, slot1)
	slot0._tabIdPreloadList = slot1
	slot0._tabAbPreloaders = {}
end

function slot0.onOpen(slot0)
	if not slot0._tabIdPreloadList then
		return
	end

	slot0:addPreloadTab(slot0._tabIdPreloadList[1])
	uv0.super.onOpen(slot0)
end

function slot0.checkPreload(slot0)
	for slot4, slot5 in ipairs(slot0._tabIdPreloadList) do
		slot0:addPreloadTab(slot5)
	end
end

function slot0.addPreloadTab(slot0, slot1)
	if not slot0._tabAbLoaders[slot1] and not slot0._tabAbPreloaders[slot1] then
		slot0._tabAbPreloaders[slot1] = MultiAbLoader.New()

		if slot0.viewContainer:getSetting().tabRes and slot3[slot0._tabContainerId] and slot3[slot0._tabContainerId][slot1] then
			slot2:setPathList(slot4)
			slot2:startLoad(slot0._onItemPreloaded, slot0)
		else
			logError(string.format("SummonMainPreloadView no res: tabContainerId_%d, tabId_%d", slot0._tabContainerId, slot1))
		end
	end
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0._tabAbPreloaders) do
		if slot0._tabAbLoaders[slot4] ~= slot5 then
			slot5:dispose()
		end
	end

	slot0._tabAbPreloaders = nil

	uv0.super.onDestroyView(slot0)
end

function slot0._openTabView(slot0, slot1)
	if not slot0._tabAbLoaders[slot1] and slot0._tabAbPreloaders[slot1] and not slot2.isLoading then
		slot0:_closeTabView()

		slot0._curTabId = slot1
		slot0._tabAbLoaders[slot0._curTabId] = slot2

		slot0:_finishCallback(slot2)

		return
	end

	uv0.super._openTabView(slot0, slot1)
end

function slot0._onItemPreloaded(slot0, slot1)
end

return slot0
