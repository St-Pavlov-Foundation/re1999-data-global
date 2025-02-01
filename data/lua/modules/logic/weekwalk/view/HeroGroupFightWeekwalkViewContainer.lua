module("modules.logic.weekwalk.view.HeroGroupFightWeekwalkViewContainer", package.seeall)

slot0 = class("HeroGroupFightWeekwalkViewContainer", HeroGroupFightViewContainer)

function slot0.defineFightView(slot0)
	uv0.super.defineFightView(slot0)

	slot0._heroGroupFightListView = WeekWalkHeroGroupListView.New()
end

function slot0.addLastViews(slot0, slot1)
	table.insert(slot1, HeroGroupFightWeekWalkView.New())
end

return slot0
