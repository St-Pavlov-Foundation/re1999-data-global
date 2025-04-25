module("modules.logic.mainsceneswitch.view.MainSceneSwitchInfoViewContainer", package.seeall)

slot0 = class("MainSceneSwitchInfoViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, MainSceneSwitchInfoDisplayView.New())
	table.insert(slot1, MainSceneSwitchInfoView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			slot0.navigateView
		}
	end
end

return slot0
