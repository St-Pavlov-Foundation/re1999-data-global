module("modules.logic.seasonver.act123.view.Season123StageFinishViewContainer", package.seeall)

slot0 = class("Season123StageFinishViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123StageFinishView.New()
	}
end

return slot0
