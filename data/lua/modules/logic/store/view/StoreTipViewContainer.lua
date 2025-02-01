module("modules.logic.store.view.StoreTipViewContainer", package.seeall)

slot0 = class("StoreTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		StoreTipView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
