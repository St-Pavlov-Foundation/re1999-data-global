module("modules.logic.seasonver.act166.view.talent.Season166TalentViewContainer", package.seeall)

slot0 = class("Season166TalentViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Season166TalentView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.Season166TalentTreeHelp)

		return {
			slot0.navigateView
		}
	end
end

return slot0
