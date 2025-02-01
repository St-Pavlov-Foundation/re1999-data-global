module("modules.logic.seasonver.act123.view1_9.Season123_1_9PickHeroEntryViewContainer", package.seeall)

slot0 = class("Season123_1_9PickHeroEntryViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123_1_9CheckCloseView.New(),
		Season123_1_9PickHeroEntryView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		slot0._navigateButtonView:setHelpId(HelpEnum.HelpId.Season1_9SelectHeroHelp)
		slot0._navigateButtonView:hideHelpIcon()

		return {
			slot0._navigateButtonView
		}
	end
end

return slot0
