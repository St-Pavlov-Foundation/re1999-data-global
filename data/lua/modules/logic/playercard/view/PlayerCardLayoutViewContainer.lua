module("modules.logic.playercard.view.PlayerCardLayoutViewContainer", package.seeall)

slot0 = class("PlayerCardLayoutViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0.layoutView = PlayerCardLayoutView.New()

	table.insert(slot1, slot0.layoutView)
	table.insert(slot1, TabViewGroup.New(1, "#go_lefttop"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		slot0.navigateView:setOverrideClose(slot0._closeFunc, slot0)

		return {
			slot0.navigateView
		}
	end
end

function slot0._closeFunc(slot0)
	if slot0.layoutView then
		slot0.layoutView:playCloseAnim()
	end
end

return slot0
