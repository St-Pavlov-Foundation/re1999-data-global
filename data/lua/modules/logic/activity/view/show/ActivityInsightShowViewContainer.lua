module("modules.logic.activity.view.show.ActivityInsightShowViewContainer", package.seeall)

slot0 = class("ActivityInsightShowViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, ActivityInsightShowView.New())

	return slot1
end

return slot0
