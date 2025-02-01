module("modules.logic.versionactivity1_5.dungeon.view.map.V1a5_HeroGroupFightViewContainer", package.seeall)

slot0 = class("V1a5_HeroGroupFightViewContainer", HeroGroupFightViewContainer)

function slot0.addFirstViews(slot0, slot1)
	uv0.super.addFirstViews(slot0, slot1)
	table.insert(slot1, V1a5_HeroGroupFightLayoutView.New())
end

function slot0.addLastViews(slot0, slot1)
	uv0.super.addLastViews(slot0, slot1)
	table.insert(slot1, V1a5HeroGroupBuildingView.New())
end

return slot0
