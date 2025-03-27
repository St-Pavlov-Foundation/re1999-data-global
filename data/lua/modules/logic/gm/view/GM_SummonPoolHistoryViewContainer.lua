module("modules.logic.gm.view.GM_SummonPoolHistoryViewContainer", package.seeall)

slot0 = class("GM_SummonPoolHistoryViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		GM_SummonPoolHistoryView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	ViewMgr.instance:closeView(slot0.viewName)
end

function slot0.addEvents(slot0)
	GMController.instance:registerCallback(GMEvent.SummonPoolHistoryView_ShowAllTabIdUpdate, slot0._gm_showAllTabIdUpdate, slot0)
end

function slot0.removeEvents(slot0)
	GMController.instance:unregisterCallback(GMEvent.SummonPoolHistoryView_ShowAllTabIdUpdate, slot0._gm_showAllTabIdUpdate, slot0)
end

return slot0
