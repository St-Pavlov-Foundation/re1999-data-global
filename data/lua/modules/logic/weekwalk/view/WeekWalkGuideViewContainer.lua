module("modules.logic.weekwalk.view.WeekWalkGuideViewContainer", package.seeall)

slot0 = class("WeekWalkGuideViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, WeekWalkGuideView.New())

	return slot1
end

return slot0
