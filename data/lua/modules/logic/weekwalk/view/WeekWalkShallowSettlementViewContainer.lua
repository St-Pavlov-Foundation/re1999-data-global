module("modules.logic.weekwalk.view.WeekWalkShallowSettlementViewContainer", package.seeall)

slot0 = class("WeekWalkShallowSettlementViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		WeekWalkShallowSettlementView.New()
	}
end

return slot0
