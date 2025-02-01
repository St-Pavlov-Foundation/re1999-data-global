module("modules.logic.voyage.view.VoyagePopupRewardViewContainer", package.seeall)

slot0 = class("VoyagePopupRewardViewContainer", BaseViewContainer)

function slot0.ctor(slot0)
	uv0.super.ctor(slot0)
	ViewMgr.instance:registerCallback(ViewEvent.BeforeOpenView, slot0._beforeOpenView, slot0)
end

function slot0.buildViews(slot0)
	return {
		VoyagePopupRewardView.New()
	}
end

function slot0._beforeOpenView(slot0, slot1, slot2)
	if slot1 == ViewName.VoyagePopupRewardView and slot2 and slot2.openFromGuide then
		-- Nothing
	end
end

return slot0
