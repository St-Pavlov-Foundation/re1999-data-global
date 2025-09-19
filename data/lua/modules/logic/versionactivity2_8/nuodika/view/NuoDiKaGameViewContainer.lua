module("modules.logic.versionactivity2_8.nuodika.view.NuoDiKaGameViewContainer", package.seeall)

local var_0_0 = class("NuoDiKaGameViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		NuoDiKaGameView.New(),
		NuoDiKaGameMapView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = NavigateButtonsView.New({
			true,
			true,
			true
		})

		var_2_0:setOverrideClose(arg_2_0._onCloseGameView, arg_2_0)
		var_2_0:setOverrideHome(arg_2_0._onHomeCloseGameView, arg_2_0)
		var_2_0:setOverrideHelp(arg_2_0._onEnterInfoClick, arg_2_0)

		return {
			var_2_0
		}
	end
end

function var_0_0._onCloseGameView(arg_3_0)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.OnActiveClose)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.OnBackToLevel)
	arg_3_0:closeThis()
end

function var_0_0._onHomeCloseGameView(arg_4_0)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.OnActiveClose)
	NavigateButtonsView.homeClick()
end

function var_0_0._onEnterInfoClick(arg_5_0)
	NuoDiKaController.instance:enterInfosView()
end

return var_0_0
