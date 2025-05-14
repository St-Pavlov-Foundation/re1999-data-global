module("modules.logic.seasonver.act123.view2_3.Season123_2_3FightRuleTipViewContainer", package.seeall)

local var_0_0 = class("Season123_2_3FightRuleTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		TabViewGroup.New(1, "root/contain"),
		Season123_2_3FightRuleTipView.New()
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	return {
		Season123_2_3FightRuleView.New(),
		Season123_2_3FightCardView.New()
	}
end

function var_0_0.switchTab(arg_3_0, arg_3_1)
	arg_3_0:dispatchEvent(ViewEvent.ToSwitchTab, 1, arg_3_1)
end

return var_0_0
