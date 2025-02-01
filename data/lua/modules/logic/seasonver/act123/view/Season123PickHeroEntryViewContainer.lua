module("modules.logic.seasonver.act123.view.Season123PickHeroEntryViewContainer", package.seeall)

slot0 = class("Season123PickHeroEntryViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123CheckCloseView.New(),
		Season123PickHeroEntryView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			true
		})

		slot0._navigateButtonView:setHelpId(HelpEnum.HelpId.Season1_7SelectHeroHelp)

		return {
			slot0._navigateButtonView
		}
	end
end

return slot0
