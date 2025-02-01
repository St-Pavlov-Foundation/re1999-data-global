module("modules.logic.activity.view.ActivityNoviceInsightViewContainer", package.seeall)

slot0 = class("ActivityNoviceInsightViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, ActivityNoviceInsightView.New())

	return slot1
end

return slot0
