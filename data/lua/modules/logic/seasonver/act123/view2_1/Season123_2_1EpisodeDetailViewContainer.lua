module("modules.logic.seasonver.act123.view2_1.Season123_2_1EpisodeDetailViewContainer", package.seeall)

slot0 = class("Season123_2_1EpisodeDetailViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Season123_2_1CheckCloseView.New())
	table.insert(slot1, Season123_2_1EpisodeDetailView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_info/#go_btns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	slot0._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	}, 100, slot0._closeCallback, slot0._homeCallback, nil, slot0)

	return {
		slot0._navigateButtonView
	}
end

function slot0._closeCallback(slot0)
	slot0:closeThis()
end

function slot0._homeCallback(slot0)
	slot0:closeThis()
end

return slot0
