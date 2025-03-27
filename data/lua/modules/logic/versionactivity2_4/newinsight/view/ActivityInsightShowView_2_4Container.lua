module("modules.logic.versionactivity2_4.newinsight.view.ActivityInsightShowView_2_4Container", package.seeall)

slot0 = class("ActivityInsightShowView_2_4Container", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, ActivityInsightShowView_2_4.New())

	return slot1
end

return slot0
