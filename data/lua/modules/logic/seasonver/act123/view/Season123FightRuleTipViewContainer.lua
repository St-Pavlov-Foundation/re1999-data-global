module("modules.logic.seasonver.act123.view.Season123FightRuleTipViewContainer", package.seeall)

slot0 = class("Season123FightRuleTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		TabViewGroup.New(1, "root/contain"),
		Season123FightRuleTipView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	return {
		Season123FightRuleView.New(),
		Season123FightCardView.New()
	}
end

function slot0.switchTab(slot0, slot1)
	slot0:dispatchEvent(ViewEvent.ToSwitchTab, 1, slot1)
end

return slot0
