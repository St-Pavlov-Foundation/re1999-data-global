module("modules.logic.tips.view.MaterialPackageTipViewContainer", package.seeall)

slot0 = class("MaterialPackageTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		MaterialTipView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
