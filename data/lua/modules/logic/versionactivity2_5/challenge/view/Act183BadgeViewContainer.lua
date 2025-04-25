module("modules.logic.versionactivity2_5.challenge.view.Act183BadgeViewContainer", package.seeall)

slot0 = class("Act183BadgeViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TabViewGroup.New(1, "root/#go_topleft"))
	table.insert(slot1, Act183BadgeView.New())

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
