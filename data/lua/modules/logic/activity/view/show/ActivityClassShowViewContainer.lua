module("modules.logic.activity.view.show.ActivityClassShowViewContainer", package.seeall)

slot0 = class("ActivityClassShowViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, ActivityClassShowView.New())

	return slot1
end

return slot0
