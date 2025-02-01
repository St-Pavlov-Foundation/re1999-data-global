module("modules.logic.weekwalk.view.WeekWalkRuleViewContainer", package.seeall)

slot0 = class("WeekWalkRuleViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		WeekWalkRuleView.New()
	}
end

return slot0
