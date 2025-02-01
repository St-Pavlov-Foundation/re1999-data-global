module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsTipsContainer", package.seeall)

slot0 = class("SportsNewsTipsContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, SportsNewsTips.New())

	return slot1
end

return slot0
