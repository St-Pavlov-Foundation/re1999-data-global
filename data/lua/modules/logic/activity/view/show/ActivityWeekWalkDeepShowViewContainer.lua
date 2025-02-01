module("modules.logic.activity.view.show.ActivityWeekWalkDeepShowViewContainer", package.seeall)

slot0 = class("ActivityWeekWalkDeepShowViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, ActivityWeekWalkDeepShowView.New())

	return slot1
end

return slot0
