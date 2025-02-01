module("modules.logic.weekwalk.view.WeekWalkDeepLayerNoticeViewContainer", package.seeall)

slot0 = class("WeekWalkDeepLayerNoticeViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		WeekWalkDeepLayerNoticeView.New()
	}
end

return slot0
