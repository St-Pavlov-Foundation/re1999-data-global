module("modules.logic.versionactivity2_5.challenge.view.Act183HeroGroupFightViewContainer", package.seeall)

slot0 = class("Act183HeroGroupFightViewContainer", HeroGroupFightViewContainer)

function slot0.addLastViews(slot0, slot1)
end

function slot0.defineFightView(slot0)
	slot0._heroGroupFightView = Act183HeroGroupFightView.New()
	slot0._heroGroupFightListView = Act183HeroGroupListView.New()
	slot0._heroGroupLevelView = Act183HeroGroupFightView_Level.New()
end

function slot0.addCommonViews(slot0, slot1)
	table.insert(slot1, slot0._heroGroupFightView)
	table.insert(slot1, HeroGroupAnimView.New())
	table.insert(slot1, slot0._heroGroupFightListView.New())
	table.insert(slot1, slot0._heroGroupLevelView.New())
	table.insert(slot1, HeroGroupFightViewRule.New())
	table.insert(slot1, HeroGroupInfoScrollView.New())
	table.insert(slot1, CheckActivityEndView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_container/btnContain/commonBtns"))
	table.insert(slot1, TabViewGroup.New(2, "#go_righttop/#go_power"))
end

function slot0.defaultOverrideCloseCheck(slot0, slot1, slot2)
	return true
end

return slot0
