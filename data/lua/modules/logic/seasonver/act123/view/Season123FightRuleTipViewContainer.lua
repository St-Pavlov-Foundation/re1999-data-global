module("modules.logic.seasonver.act123.view.Season123FightRuleTipViewContainer", package.seeall)

local var_0_0 = class("Season123FightRuleTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		TabViewGroup.New(1, "root/contain"),
		Season123FightRuleTipView.New()
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	return {
		Season123FightRuleView.New(),
		Season123FightCardView.New()
	}
end

function var_0_0.switchTab(arg_3_0, arg_3_1)
	arg_3_0:dispatchEvent(ViewEvent.ToSwitchTab, 1, arg_3_1)
end

return var_0_0
