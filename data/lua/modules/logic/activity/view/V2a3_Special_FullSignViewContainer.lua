module("modules.logic.activity.view.V2a3_Special_FullSignViewContainer", package.seeall)

slot0 = class("V2a3_Special_FullSignViewContainer", V2a3_Special_SignItemViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._view = V2a3_Special_FullSignView.New()

	table.insert(slot1, slot0._view)

	return slot1
end

function slot0.view(slot0)
	return slot0._view
end

return slot0
