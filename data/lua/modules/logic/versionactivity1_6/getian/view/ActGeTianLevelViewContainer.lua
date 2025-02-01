module("modules.logic.versionactivity1_6.getian.view.ActGeTianLevelViewContainer", package.seeall)

slot0 = class("ActGeTianLevelViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, ActGeTianLevelView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0._navigateButtonsView
		}
	end
end

return slot0
