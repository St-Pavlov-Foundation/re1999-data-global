module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.V1a2_HeroGroupFightViewContainer", package.seeall)

slot0 = class("V1a2_HeroGroupFightViewContainer", HeroGroupFightViewContainer)

function slot0.defineFightView(slot0)
	uv0.super.defineFightView(slot0)

	slot0._heroGroupFightView = VersionActivity_1_2_HeroGroupView.New()
end

function slot0.addLastViews(slot0, slot1)
	uv0.super.addLastViews(slot0)
	table.insert(slot1, VersionActivity_1_2_HeroGroupBuildView.New())
end

return slot0
