module("modules.logic.season.view1_5.Season1_5SumViewContainer", package.seeall)

slot0 = class("Season1_5SumViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Season1_5SumView.New())

	return slot1
end

return slot0
