module("modules.logic.seasonver.act123.view1_8.Season123_1_8FightRuleTipViewContainer", package.seeall)

local var_0_0 = class("Season123_1_8FightRuleTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		TabViewGroup.New(1, "root/contain"),
		Season123_1_8FightRuleTipView.New()
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	return {
		Season123_1_8FightRuleView.New(),
		Season123_1_8FightCardView.New()
	}
end

function var_0_0.switchTab(arg_3_0, arg_3_1)
	arg_3_0:dispatchEvent(ViewEvent.ToSwitchTab, 1, arg_3_1)
end

return var_0_0
