module("modules.logic.seasonver.act123.view1_9.Season123_1_9EnemyViewContainer", package.seeall)

local var_0_0 = class("Season123_1_9EnemyViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Season123_1_9EnemyView.New(),
		Season123_1_9EnemyTabList.New(),
		Season123_1_9EnemyRule.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0.navigationView
		}
	end
end

function var_0_0.onContainerOpenFinish(arg_3_0)
	return
end

return var_0_0
