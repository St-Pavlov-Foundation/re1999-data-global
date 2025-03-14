module("modules.logic.tower.view.assistboss.TowerAssistBossTalentViewContainer", package.seeall)

slot0 = class("TowerAssistBossTalentViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TowerAssistBossTalentView.New())
	table.insert(slot1, TowerAssistBossTalentTreeView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_lefttop"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.TowerTalent)

		return {
			slot0.navigateView
		}
	end
end

return slot0
