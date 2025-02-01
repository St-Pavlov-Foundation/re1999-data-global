module("modules.logic.seasonver.act166.view.talent.Season166TalentSelectViewContainer", package.seeall)

slot0 = class("Season166TalentSelectViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Season166TalentSelectView.New())
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
