module("modules.logic.seasonver.act123.view2_0.Season123_2_0PickHeroEntryViewContainer", package.seeall)

slot0 = class("Season123_2_0PickHeroEntryViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123_2_0CheckCloseView.New(),
		Season123_2_0PickHeroEntryView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		slot0._navigateButtonView:setHelpId(HelpEnum.HelpId.Season2_0SelectHeroHelp)
		slot0._navigateButtonView:hideHelpIcon()

		return {
			slot0._navigateButtonView
		}
	end
end

return slot0
