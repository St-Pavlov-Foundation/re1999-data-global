module("modules.logic.season.view1_2.Season1_2FightRuleTipViewContainer", package.seeall)

local var_0_0 = class("Season1_2FightRuleTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		TabViewGroup.New(1, "root/contain"),
		Season1_2FightRuleTipView.New()
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	return {
		Season1_2FightRuleView.New(),
		Season1_2FightCardView.New()
	}
end

function var_0_0.switchTab(arg_3_0, arg_3_1)
	arg_3_0:dispatchEvent(ViewEvent.ToSwitchTab, 1, arg_3_1)
end

return var_0_0
