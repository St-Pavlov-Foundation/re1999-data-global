module("modules.logic.season.view.SeasonFightRuleTipViewContainer", package.seeall)

slot0 = class("SeasonFightRuleTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		TabViewGroup.New(1, "root/contain"),
		SeasonFightRuleTipView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	return {
		SeasonFightRuleView.New(),
		SeasonFightCardView.New()
	}
end

function slot0.switchTab(slot0, slot1)
	slot0:dispatchEvent(ViewEvent.ToSwitchTab, 1, slot1)
end

return slot0
