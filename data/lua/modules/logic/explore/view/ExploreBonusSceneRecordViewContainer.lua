module("modules.logic.explore.view.ExploreBonusSceneRecordViewContainer", package.seeall)

slot0 = class("ExploreBonusSceneRecordViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		ExploreBonusSceneRecordView.New()
	}
end

return slot0
