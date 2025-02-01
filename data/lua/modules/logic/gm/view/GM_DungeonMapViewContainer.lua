module("modules.logic.gm.view.GM_DungeonMapViewContainer", package.seeall)

slot0 = class("GM_DungeonMapViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		GM_DungeonMapView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	ViewMgr.instance:closeView(slot0.viewName)
end

function slot0.addEvents(slot0)
	GMController.instance:registerCallback(GMEvent.DungeonMapView_ShowAllTabIdUpdate, slot0._gm_showAllTabIdUpdate, slot0)
end

function slot0.removeEvents(slot0)
	GMController.instance:unregisterCallback(GMEvent.DungeonMapView_ShowAllTabIdUpdate, slot0._gm_showAllTabIdUpdate, slot0)
end

return slot0
