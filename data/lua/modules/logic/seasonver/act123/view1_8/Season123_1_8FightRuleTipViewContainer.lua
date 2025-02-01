module("modules.logic.seasonver.act123.view1_8.Season123_1_8FightRuleTipViewContainer", package.seeall)

slot0 = class("Season123_1_8FightRuleTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		TabViewGroup.New(1, "root/contain"),
		Season123_1_8FightRuleTipView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	return {
		Season123_1_8FightRuleView.New(),
		Season123_1_8FightCardView.New()
	}
end

function slot0.switchTab(slot0, slot1)
	slot0:dispatchEvent(ViewEvent.ToSwitchTab, 1, slot1)
end

return slot0
