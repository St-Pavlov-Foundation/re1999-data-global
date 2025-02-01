module("modules.logic.seasonver.act123.view1_8.Season123_1_8PickHeroEntryViewContainer", package.seeall)

slot0 = class("Season123_1_8PickHeroEntryViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123_1_8CheckCloseView.New(),
		Season123_1_8PickHeroEntryView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		slot0._navigateButtonView:setHelpId(HelpEnum.HelpId.Season1_8SelectHeroHelp)
		slot0._navigateButtonView:hideHelpIcon()

		return {
			slot0._navigateButtonView
		}
	end
end

return slot0
