module("modules.logic.tower.view.bosstower.TowerBossEpisodeViewContainer", package.seeall)

slot0 = class("TowerBossEpisodeViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TowerBossEpisodeView.New())
	table.insert(slot1, TowerBossEpisodeLeftView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.TowerBoss)

		return {
			slot0.navigateView
		}
	end
end

function slot0.isSp(slot0)
	return false
end

return slot0
