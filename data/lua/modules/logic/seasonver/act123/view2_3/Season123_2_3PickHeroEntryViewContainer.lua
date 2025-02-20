module("modules.logic.seasonver.act123.view2_3.Season123_2_3PickHeroEntryViewContainer", package.seeall)

slot0 = class("Season123_2_3PickHeroEntryViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123_2_3CheckCloseView.New(),
		Season123_2_3PickHeroEntryView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		slot0._navigateButtonView:setHelpId(HelpEnum.HelpId.Season2_3SelectHeroHelp)
		slot0._navigateButtonView:hideHelpIcon()

		return {
			slot0._navigateButtonView
		}
	end
end

return slot0
