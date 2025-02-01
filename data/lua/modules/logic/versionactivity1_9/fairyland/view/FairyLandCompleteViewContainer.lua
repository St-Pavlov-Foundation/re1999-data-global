module("modules.logic.versionactivity1_9.fairyland.view.FairyLandCompleteViewContainer", package.seeall)

slot0 = class("FairyLandCompleteViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, FairyLandCompleteView.New())

	return slot1
end

return slot0
