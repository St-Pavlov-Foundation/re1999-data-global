module("modules.logic.seasonver.act123.view2_1.Season123_2_1ResetViewContainer", package.seeall)

slot0 = class("Season123_2_1ResetViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123_2_1CheckCloseView.New(),
		Season123_2_1ResetView.New(),
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

		slot0._navigateButtonView:setHelpId(HelpEnum.HelpId.Season2_1ResetViewHelp)
		slot0._navigateButtonView:hideHelpIcon()

		return {
			slot0._navigateButtonView
		}
	end
end

return slot0
