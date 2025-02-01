module("modules.logic.weekwalk.view.WeekWalkReviveViewContainer", package.seeall)

slot0 = class("WeekWalkReviveViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		WeekWalkReviveView.New()
	}
end

return slot0
