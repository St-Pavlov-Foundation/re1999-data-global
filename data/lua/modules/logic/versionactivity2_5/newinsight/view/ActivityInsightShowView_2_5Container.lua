module("modules.logic.versionactivity2_5.newinsight.view.ActivityInsightShowView_2_5Container", package.seeall)

slot0 = class("ActivityInsightShowView_2_5Container", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, ActivityInsightShowView_2_5.New())

	return slot1
end

return slot0
