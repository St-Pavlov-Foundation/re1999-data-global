module("modules.logic.tower.view.fight.TowerHeroGroupFightViewContainer", package.seeall)

slot0 = class("TowerHeroGroupFightViewContainer", HeroGroupFightViewContainer)

function slot0.addLastViews(slot0, slot1)
	table.insert(slot1, TowerHeroGroupBossView.New())
end

function slot0.defineFightView(slot0)
	slot0._heroGroupFightView = TowerHeroGroupFightView.New()
	slot0._heroGroupFightListView = TowerHeroGroupListView.New()
end

function slot0._closeCallback(slot0)
	slot0:closeThis()
	MainController.instance:enterMainScene(true, false)
end

function slot0.defaultOverrideCloseCheck(slot0, slot1, slot2)
	return true
end

return slot0
