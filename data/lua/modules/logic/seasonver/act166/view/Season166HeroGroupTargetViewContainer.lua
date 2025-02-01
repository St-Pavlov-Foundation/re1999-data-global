module("modules.logic.seasonver.act166.view.Season166HeroGroupTargetViewContainer", package.seeall)

slot0 = class("Season166HeroGroupTargetViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Season166HeroGroupTargetView.New())

	return slot1
end

return slot0
