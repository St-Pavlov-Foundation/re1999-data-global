module("modules.logic.weekwalk.view.WeekWalkEnemyInfoViewContainer", package.seeall)

local var_0_0 = class("WeekWalkEnemyInfoViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0.weekWalkOriginalEnemyInfoView = WeekWalkOriginalEnemyInfoView.New()
	arg_1_0.weekWalkEnemyInfoViewRule = WeekWalkEnemyInfoViewRule.New()

	return {
		WeekWalkEnemyInfoView.New(),
		arg_1_0.weekWalkOriginalEnemyInfoView,
		arg_1_0.weekWalkEnemyInfoViewRule,
		TabViewGroup.New(1, "#go_btns")
	}
end

function var_0_0.getEnemyInfoView(arg_2_0)
	return arg_2_0.weekWalkOriginalEnemyInfoView
end

function var_0_0.getWeekWalkEnemyInfoViewRule(arg_3_0)
	return arg_3_0.weekWalkEnemyInfoViewRule
end

function var_0_0.buildTabViews(arg_4_0, arg_4_1)
	if arg_4_1 == 1 then
		arg_4_0.navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_4_0.navigationView
		}
	end
end

function var_0_0.onContainerOpenFinish(arg_5_0)
	return
end

return var_0_0
