module("modules.logic.commandstation.view.CommandStationPaperViewContainer", package.seeall)

local var_0_0 = class("CommandStationPaperViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		CommandStationPaperView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
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

function var_0_0.playOpenTransition(arg_3_0)
	local var_3_0 = arg_3_0:__getAnimatorPlayer()

	if not var_3_0 or not var_3_0.isActiveAndEnabled then
		arg_3_0:onPlayOpenTransitionFinish()

		return
	end

	local var_3_1 = "open1"
	local var_3_2 = 2
	local var_3_3 = CommandStationConfig.instance:getPaperList()
	local var_3_4 = var_3_3[CommandStationModel.instance.paper]
	local var_3_5 = var_3_3[CommandStationModel.instance.paper + 1]
	local var_3_6 = var_3_4 and CommandStationConfig.instance:getCurTotalPaperCount(var_3_4.versionId) or 0
	local var_3_7 = CommandStationConfig.instance:getCurPaperCount() - var_3_6

	if var_3_5 and var_3_7 >= var_3_5.allNum then
		var_3_1 = "open2"
	end

	var_0_0.super.playOpenTransition(arg_3_0, {
		anim = var_3_1,
		duration = var_3_2
	})
end

return var_0_0
