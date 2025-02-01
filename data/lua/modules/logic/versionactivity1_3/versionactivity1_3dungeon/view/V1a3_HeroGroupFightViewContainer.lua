module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.V1a3_HeroGroupFightViewContainer", package.seeall)

slot0 = class("V1a3_HeroGroupFightViewContainer", HeroGroupFightViewContainer)

function slot0.addFirstViews(slot0, slot1)
	uv0.super.addFirstViews(slot0, slot1)
	table.insert(slot1, HeroGroupFairyLandView.New())
end

return slot0
