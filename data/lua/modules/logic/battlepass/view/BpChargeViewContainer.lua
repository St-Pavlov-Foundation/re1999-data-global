module("modules.logic.battlepass.view.BpChargeViewContainer", package.seeall)

slot0 = class("BpChargeViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))
	table.insert(slot1, BpChargeView.New())

	return slot1
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

function slot0.playOpenTransition(slot0)
	slot1 = "open"

	if slot0.viewParam and slot0.viewParam.first then
		slot1 = "first"
	end

	uv0.super.playOpenTransition(slot0, {
		duration = 3,
		anim = slot1
	})
end

return slot0
