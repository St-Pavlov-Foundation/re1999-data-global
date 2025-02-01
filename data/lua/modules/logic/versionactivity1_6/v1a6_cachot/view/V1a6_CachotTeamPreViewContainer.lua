module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTeamPreViewContainer", package.seeall)

slot0 = class("V1a6_CachotTeamPreViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		V1a6_CachotTeamPreView.New()
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
