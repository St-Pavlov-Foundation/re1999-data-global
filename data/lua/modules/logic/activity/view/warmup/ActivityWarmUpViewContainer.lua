module("modules.logic.activity.view.warmup.ActivityWarmUpViewContainer", package.seeall)

slot0 = class("ActivityWarmUpViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, ActivityWarmUpView.New())

	return slot1
end

return slot0
