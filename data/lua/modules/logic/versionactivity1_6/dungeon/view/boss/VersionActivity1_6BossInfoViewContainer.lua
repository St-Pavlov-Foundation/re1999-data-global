module("modules.logic.versionactivity1_6.dungeon.view.boss.VersionActivity1_6BossInfoViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_6BossInfoViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._bossRushViewRule = VersionActivity1_6_BossInfoRuleView.New()

	return {
		VersionActivity1_6BossInfoView.New(),
		TabViewGroup.New(1, "#go_btns"),
		arg_1_0._bossRushViewRule
	}
end

function var_0_0.getBossRushViewRule(arg_2_0)
	return arg_2_0._bossRushViewRule
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		arg_3_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		}, 100, arg_3_0._closeCallback, nil, nil, arg_3_0)

		return {
			arg_3_0._navigateButtonView
		}
	end
end

function var_0_0.diffRootChild(arg_4_0, arg_4_1)
	return false
end

return var_0_0
