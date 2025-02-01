module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsPaperViewContainer", package.seeall)

slot0 = class("SportsNewsPaperViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, SportsNewsPaperView.New())

	return slot1
end

return slot0
