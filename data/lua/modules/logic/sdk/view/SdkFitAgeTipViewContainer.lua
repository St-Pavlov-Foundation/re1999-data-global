module("modules.logic.sdk.view.SdkFitAgeTipViewContainer", package.seeall)

slot0 = class("SdkFitAgeTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		SdkFitAgeTipView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
