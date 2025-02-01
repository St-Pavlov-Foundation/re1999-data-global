module("modules.logic.commonbufftip.CommonBuffTipViewContainer", package.seeall)

slot0 = class("CommonBuffTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		CommonBuffTipView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
