module("modules.logic.versionactivity2_5.autochess.view.AutoChessFriendBattleViewContainer", package.seeall)

local var_0_0 = class("AutoChessFriendBattleViewContainer", BaseViewContainer)

function var_0_0._overrideClose(arg_1_0)
	AutoChessController.instance:openMainView()
	arg_1_0:closeThis()
end

function var_0_0.buildViews(arg_2_0)
	local var_2_0 = {}

	table.insert(var_2_0, AutoChessFriendBattleView.New())
	table.insert(var_2_0, TabViewGroup.New(1, "go_topleft"))

	return var_2_0
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		arg_3_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		arg_3_0.navigateView:setOverrideClose(arg_3_0._overrideClose, arg_3_0)

		return {
			arg_3_0.navigateView
		}
	end
end

return var_0_0
