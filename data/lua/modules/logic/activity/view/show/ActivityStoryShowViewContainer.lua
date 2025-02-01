module("modules.logic.activity.view.show.ActivityStoryShowViewContainer", package.seeall)

slot0 = class("ActivityStoryShowViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, ActivityStoryShowView.New())

	return slot1
end

return slot0
