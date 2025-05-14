module("modules.logic.toughbattle.view.ToughBattleMapViewContainer", package.seeall)

local var_0_0 = class("ToughBattleMapViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._mapScene = ToughBattleMapScene.New()

	return {
		arg_1_0._mapScene,
		ToughBattleMapView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0.navigateView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		arg_2_0.navigateView
	}
end

function var_0_0.setVisibleInternal(arg_3_0, arg_3_1)
	var_0_0.super.setVisibleInternal(arg_3_0, arg_3_1)

	if arg_3_0._mapScene then
		arg_3_0._mapScene:setSceneVisible(arg_3_1)
	end
end

function var_0_0.playCloseTransition(arg_4_0)
	arg_4_0:_cancelBlock()
	arg_4_0:_stopOpenCloseAnim()
	arg_4_0:startViewCloseBlock()

	local var_4_0 = arg_4_0:__getAnimatorPlayer()

	if not gohelper.isNil(var_4_0) then
		local var_4_1 = "close"

		var_4_0:Play(var_4_1, arg_4_0.onPlayCloseTransitionFinish, arg_4_0)
	end

	local var_4_2 = 2

	TaskDispatcher.runDelay(arg_4_0.onPlayCloseTransitionFinish, arg_4_0, var_4_2)
end

return var_0_0
