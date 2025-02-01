module("modules.logic.weekwalk.view.WeekWalkDegradeViewContainer", package.seeall)

slot0 = class("WeekWalkDegradeViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, WeekWalkDegradeView.New())

	return slot1
end

return slot0
