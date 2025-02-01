module("modules.logic.activity.view.warmup.ActivityWarmUpTipsContainer", package.seeall)

slot0 = class("ActivityWarmUpTipsContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, ActivityWarmUpTips.New())

	return slot1
end

return slot0
