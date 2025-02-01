module("modules.logic.seasonver.act166.view.Season166ResultViewContainer", package.seeall)

slot0 = class("Season166ResultViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Season166ResultView.New())

	return slot1
end

return slot0
