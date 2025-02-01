module("modules.logic.activity.view.warmup.ActivityWarmUpTaskViewContainer", package.seeall)

slot0 = class("ActivityWarmUpTaskViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, ActivityWarmUpTaskView.New())

	return slot1
end

return slot0
