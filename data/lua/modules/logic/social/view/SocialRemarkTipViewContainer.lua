module("modules.logic.social.view.SocialRemarkTipViewContainer", package.seeall)

slot0 = class("SocialRemarkTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		SocialRemarkTipView.New()
	}
end

return slot0
