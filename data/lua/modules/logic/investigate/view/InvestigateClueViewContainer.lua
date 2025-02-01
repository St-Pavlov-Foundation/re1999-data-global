module("modules.logic.investigate.view.InvestigateClueViewContainer", package.seeall)

slot0 = class("InvestigateClueViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		InvestigateClueView.New()
	}
end

return slot0
