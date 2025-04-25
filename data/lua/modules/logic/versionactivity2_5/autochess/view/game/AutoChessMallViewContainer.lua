module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessMallViewContainer", package.seeall)

slot0 = class("AutoChessMallViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0.mainView = AutoChessMallView.New()

	table.insert(slot1, slot0.mainView)
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		slot0.navigateView:setOverrideClose(slot0.mainView._overrideClose, slot0.mainView)

		return {
			slot0.navigateView
		}
	end
end

return slot0
