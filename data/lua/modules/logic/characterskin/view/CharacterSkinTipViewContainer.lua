module("modules.logic.characterskin.view.CharacterSkinTipViewContainer", package.seeall)

slot0 = class("CharacterSkinTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, CharacterSkinTipRightView.New())
	table.insert(slot1, CharacterSkinLeftView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btntopleft"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	slot0.navigateView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		slot0.navigateView
	}
end

function slot0.setHomeBtnVisible(slot0, slot1)
	if slot0.navigateView then
		slot0.navigateView:setParam({
			true,
			slot1,
			false
		})
	end
end

function slot0.onPlayOpenTransitionFinish(slot0)
	uv0.super.onPlayOpenTransitionFinish(slot0)

	slot0.viewGO:GetComponent(typeof(UnityEngine.Animator)).enabled = true
end

return slot0
