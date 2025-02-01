module("modules.logic.seasonver.act123.view.Season123ResetViewContainer", package.seeall)

slot0 = class("Season123ResetViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123CheckCloseView.New(),
		Season123ResetView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		slot0._navigateButtonView:setHelpId(HelpEnum.HelpId.Season1_7ResetViewHelp)

		return {
			slot0._navigateButtonView
		}
	end
end

return slot0
