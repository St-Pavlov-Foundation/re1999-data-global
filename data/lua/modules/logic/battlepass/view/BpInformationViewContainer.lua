module("modules.logic.battlepass.view.BpInformationViewContainer", package.seeall)

slot0 = class("BpInformationViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		BpInformationView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
