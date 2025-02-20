module("modules.logic.seasonver.act123.view2_3.Season123_2_3FightRuleTipViewContainer", package.seeall)

slot0 = class("Season123_2_3FightRuleTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		TabViewGroup.New(1, "root/contain"),
		Season123_2_3FightRuleTipView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	return {
		Season123_2_3FightRuleView.New(),
		Season123_2_3FightCardView.New()
	}
end

function slot0.switchTab(slot0, slot1)
	slot0:dispatchEvent(ViewEvent.ToSwitchTab, 1, slot1)
end

return slot0
