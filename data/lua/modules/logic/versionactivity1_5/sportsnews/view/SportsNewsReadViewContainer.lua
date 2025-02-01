module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsReadViewContainer", package.seeall)

slot0 = class("SportsNewsReadViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, SportsNewsReadView.New())

	return slot1
end

return slot0
