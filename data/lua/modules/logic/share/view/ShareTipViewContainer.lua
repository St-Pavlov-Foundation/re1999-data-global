module("modules.logic.share.view.ShareTipViewContainer", package.seeall)

slot0 = class("ShareTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		ShareTipView.New()
	}
end

return slot0
