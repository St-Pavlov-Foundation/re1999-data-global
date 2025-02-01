module("modules.logic.main.view.MainThumbnailViewContainer", package.seeall)

slot0 = class("MainThumbnailViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		MainThumbnailView.New(),
		MainThumbnailHeroView.New(),
		MainThumbnailRecommendView.New(),
		MainThumbnailBtnView.New(),
		MainThumbnailBgmView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function slot0.buildTabViews(slot0, slot1)
	slot0.navigationView = NavigateButtonsView.New({
		true,
		false,
		false
	}, 101)

	return {
		slot0.navigationView
	}
end

function slot0.getThumbnailNav(slot0)
	return slot0.navigationView
end

function slot0.playCloseTransition(slot0)
	uv0.super.playCloseTransition(slot0, {
		duration = 1
	})
end

return slot0
