module("modules.logic.season.view1_2.Season1_2FightRuleTipViewContainer", package.seeall)

slot0 = class("Season1_2FightRuleTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		TabViewGroup.New(1, "root/contain"),
		Season1_2FightRuleTipView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	return {
		Season1_2FightRuleView.New(),
		Season1_2FightCardView.New()
	}
end

function slot0.switchTab(slot0, slot1)
	slot0:dispatchEvent(ViewEvent.ToSwitchTab, 1, slot1)
end

return slot0
