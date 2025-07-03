module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6LevelViewContainer", package.seeall)

local var_0_0 = class("LengZhou6LevelViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		LengZhou6LevelView.New(),
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

		arg_2_0.navigationView:setOverrideClose(arg_2_0._overrideClose, arg_2_0)

		return {
			arg_2_0.navigationView
		}
	end
end

return var_0_0
