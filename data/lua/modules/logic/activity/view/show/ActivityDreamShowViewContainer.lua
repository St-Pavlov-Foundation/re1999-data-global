module("modules.logic.activity.view.show.ActivityDreamShowViewContainer", package.seeall)

slot0 = class("ActivityDreamShowViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, ActivityDreamShowView.New())

	return slot1
end

return slot0
