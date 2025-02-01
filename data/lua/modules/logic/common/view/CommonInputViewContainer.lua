module("modules.logic.common.view.CommonInputViewContainer", package.seeall)

slot0 = class("CommonInputViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		CommonInputView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
