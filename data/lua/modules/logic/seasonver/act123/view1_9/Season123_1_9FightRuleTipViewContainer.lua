module("modules.logic.seasonver.act123.view1_9.Season123_1_9FightRuleTipViewContainer", package.seeall)

slot0 = class("Season123_1_9FightRuleTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		TabViewGroup.New(1, "root/contain"),
		Season123_1_9FightRuleTipView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	return {
		Season123_1_9FightRuleView.New(),
		Season123_1_9FightCardView.New()
	}
end

function slot0.switchTab(slot0, slot1)
	slot0:dispatchEvent(ViewEvent.ToSwitchTab, 1, slot1)
end

return slot0
