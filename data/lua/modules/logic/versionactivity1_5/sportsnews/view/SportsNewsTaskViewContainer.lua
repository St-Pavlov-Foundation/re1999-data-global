module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsTaskViewContainer", package.seeall)

slot0 = class("SportsNewsTaskViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, SportsNewsTaskView.New())

	return slot1
end

return slot0
