module("modules.logic.main.view.FeedBackViewContainer", package.seeall)

slot0 = class("FeedBackViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FeedBackView.New(),
		TabViewGroup.New(1, "browser")
	}
end

function slot0.buildTabViews(slot0, slot1)
	slot0.navigationView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		slot0.navigationView
	}
end

function slot0.onContainerOpenFinish(slot0)
	slot0.navigationView:resetCloseBtnAudioId(AudioEnum.UI.play_ui_feedback_close)
end

return slot0
