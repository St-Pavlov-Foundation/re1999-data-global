module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTeamViewContainer", package.seeall)

slot0 = class("V1a6_CachotTeamViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		V1a6_CachotTeamItemListView.New(),
		V1a6_CachotTeamView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function slot0.buildTabViews(slot0, slot1)
	return {
		NavigateButtonsView.New({
			true,
			false,
			false
		})
	}
end

return slot0
