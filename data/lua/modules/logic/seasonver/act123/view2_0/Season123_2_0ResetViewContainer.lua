module("modules.logic.seasonver.act123.view2_0.Season123_2_0ResetViewContainer", package.seeall)

slot0 = class("Season123_2_0ResetViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123_2_0CheckCloseView.New(),
		Season123_2_0ResetView.New(),
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

		slot0._navigateButtonView:setHelpId(HelpEnum.HelpId.Season2_0ResetViewHelp)
		slot0._navigateButtonView:hideHelpIcon()

		return {
			slot0._navigateButtonView
		}
	end
end

return slot0
