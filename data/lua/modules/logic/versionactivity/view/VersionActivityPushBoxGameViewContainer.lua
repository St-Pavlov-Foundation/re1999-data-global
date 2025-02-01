module("modules.logic.versionactivity.view.VersionActivityPushBoxGameViewContainer", package.seeall)

slot0 = class("VersionActivityPushBoxGameViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		TabViewGroup.New(1, "#go_btns"),
		VersionActivityPushBoxGameView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.PushBox)

		return {
			slot0._navigateButtonView
		}
	end
end

return slot0
