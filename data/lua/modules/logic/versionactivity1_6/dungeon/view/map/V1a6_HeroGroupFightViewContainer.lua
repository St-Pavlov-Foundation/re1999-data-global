module("modules.logic.versionactivity1_6.dungeon.view.map.V1a6_HeroGroupFightViewContainer", package.seeall)

slot0 = class("V1a6_HeroGroupFightViewContainer", HeroGroupFightViewContainer)

function slot0.addFirstViews(slot0, slot1)
	uv0.super.addFirstViews(slot0, slot1)
	table.insert(slot1, V1a6_HeroGroupFightLayoutView.New())
end

function slot0.addLastViews(slot0, slot1)
	uv0.super.addLastViews(slot0, slot1)
	table.insert(slot1, V1a6HeroGroupSkillView.New())
end

return slot0
