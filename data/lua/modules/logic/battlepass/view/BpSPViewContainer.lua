module("modules.logic.battlepass.view.BpSPViewContainer", package.seeall)

slot0 = class("BpSPViewContainer", BaseViewContainer)
slot1 = 1
slot2 = 2

function slot0.buildViews(slot0)
	return {
		BpBuyBtn.New(),
		TabViewGroup.New(uv0, "#go_btns"),
		BPTabViewGroup.New(uv1, "#go_container"),
		BpSPView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == uv0 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0._navigateButtonView
		}
	elseif slot1 == uv1 then
		return {
			BpSPBonusView.New()
		}
	end
end

function slot0.playOpenTransition(slot0)
	slot1 = "open"

	if slot0.viewParam and slot0.viewParam.isSwitch then
		slot1 = "switch"
	end

	uv0.super.playOpenTransition(slot0, {
		duration = 1,
		anim = slot1
	})
end

function slot0.playCloseTransition(slot0)
	slot0:onPlayCloseTransitionFinish()
end

return slot0
