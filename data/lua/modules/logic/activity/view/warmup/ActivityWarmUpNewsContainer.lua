module("modules.logic.activity.view.warmup.ActivityWarmUpNewsContainer", package.seeall)

slot0 = class("ActivityWarmUpNewsContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, ActivityWarmUpNews.New())

	return slot1
end

return slot0
