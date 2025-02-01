module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotDifficultyViewContainer", package.seeall)

slot0 = class("V1a6_CachotDifficultyViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		V1a6_CachotDifficultyView.New()
	}
end

return slot0
