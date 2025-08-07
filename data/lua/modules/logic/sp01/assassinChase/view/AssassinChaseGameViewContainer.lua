module("modules.logic.sp01.assassinChase.view.AssassinChaseGameViewContainer", package.seeall)

local var_0_0 = class("AssassinChaseGameViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, AssassinChaseGameView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		arg_2_0.navigateView:setOverrideClose(arg_2_0.overrideClose, arg_2_0)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.overrideClose(arg_3_0)
	local var_3_0 = arg_3_0._views[1]

	if var_3_0.state == AssassinChaseEnum.ViewState.Select and var_3_0.infoMo:isSelect() then
		var_3_0:refreshUI()

		return
	end

	arg_3_0:closeThis()
end

return var_0_0
