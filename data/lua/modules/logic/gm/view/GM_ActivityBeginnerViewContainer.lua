module("modules.logic.gm.view.GM_ActivityBeginnerViewContainer", package.seeall)

slot0 = class("GM_ActivityBeginnerViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		GM_ActivityBeginnerView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	ViewMgr.instance:closeView(slot0.viewName)
end

function slot0.addEvents(slot0)
	GMController.instance:registerCallback(GMEvent.ActivityBeginnerView_ShowAllTabIdUpdate, slot0._gm_showAllTabIdUpdate, slot0)
end

function slot0.removeEvents(slot0)
	GMController.instance:unregisterCallback(GMEvent.ActivityBeginnerView_ShowAllTabIdUpdate, slot0._gm_showAllTabIdUpdate, slot0)
end

return slot0
