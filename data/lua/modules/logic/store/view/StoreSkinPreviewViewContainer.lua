module("modules.logic.store.view.StoreSkinPreviewViewContainer", package.seeall)

slot0 = class("StoreSkinPreviewViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, StoreSkinPreviewRightView.New())
	table.insert(slot1, CharacterSkinLeftView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btntopleft"))
	table.insert(slot1, StoreSkinPreviewSpineGCView.New())
	table.insert(slot1, StoreSkinPreviewVideoView.New())

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

function slot0.onPlayOpenTransitionFinish(slot0)
	uv0.super.onPlayOpenTransitionFinish(slot0)

	slot0.viewGO:GetComponent(typeof(UnityEngine.Animator)).enabled = true
end

return slot0
