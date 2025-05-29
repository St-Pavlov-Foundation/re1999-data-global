module("modules.logic.versionactivity1_6.dungeon.view.boss.VersionActivity1_6DungeonBossViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_6DungeonBossViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._bossRuleView = VersionActivity1_6_BossRuleView.New()

	return {
		VersionActivity1_6DungeonBossView.New(),
		TabViewGroup.New(1, "#go_BackBtns"),
		arg_1_0._bossRuleView
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0.navigateView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		arg_2_0.navigateView
	}
end

function var_0_0.onContainerInit(arg_3_0)
	return
end

function var_0_0.getBossRuleView(arg_4_0)
	return arg_4_0._bossRuleView
end

return var_0_0
