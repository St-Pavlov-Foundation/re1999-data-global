module("modules.logic.activity.view.ActivityTipViewContainer", package.seeall)

slot0 = class("ActivityTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		ActivityTipView.New()
	}
end

return slot0
