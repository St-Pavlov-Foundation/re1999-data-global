module("modules.logic.antique.view.AntiqueViewContainer", package.seeall)

slot0 = class("AntiqueViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		AntiqueView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0.navigationView
		}
	end
end

return slot0
