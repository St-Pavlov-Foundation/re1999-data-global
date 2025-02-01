module("modules.logic.weekwalk.view.WeekWalkSelectTarotViewContainer", package.seeall)

slot0 = class("WeekWalkSelectTarotViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		WeekWalkSelectTarotView.New()
	}
end

return slot0
