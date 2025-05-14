module("modules.logic.seasonver.act123.view2_0.Season123_2_0EnemyViewContainer", package.seeall)

local var_0_0 = class("Season123_2_0EnemyViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Season123_2_0EnemyView.New(),
		Season123_2_0EnemyTabList.New(),
		Season123_2_0EnemyRule.New(),
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
