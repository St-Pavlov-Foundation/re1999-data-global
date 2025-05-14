module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoGameViewContainer", package.seeall)

local var_0_0 = class("FeiLinShiDuoGameViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0.feiLinShiDuoSceneView = FeiLinShiDuoSceneView.New()
	arg_1_0.feiLinShiDuoGameView = FeiLinShiDuoGameView.New()

	table.insert(var_1_0, arg_1_0.feiLinShiDuoSceneView)
	table.insert(var_1_0, arg_1_0.feiLinShiDuoGameView)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.getSceneView(arg_3_0)
	return arg_3_0.feiLinShiDuoSceneView
end

function var_0_0.getGameView(arg_4_0)
	return arg_4_0.feiLinShiDuoGameView
end

function var_0_0.setOverrideCloseClick(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.navigateView:setOverrideClose(arg_5_1, arg_5_2)
end

return var_0_0
