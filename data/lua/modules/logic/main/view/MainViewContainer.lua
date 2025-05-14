module("modules.logic.main.view.MainViewContainer", package.seeall)

local var_0_0 = class("MainViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._mainHeroNoInteractive = MainHeroNoInteractive.New()
	arg_1_0._mainHeroView = MainHeroView.New()
	arg_1_0._mainActivityEnterView = MainActivityEnterView.New()

	return {
		MainView.New(),
		arg_1_0._mainHeroNoInteractive,
		arg_1_0._mainHeroView,
		MainHeroMipView.New(),
		arg_1_0._mainActivityEnterView,
		MainActExtraDisplay.New(),
		TabViewGroup.New(1, "#go_righttop"),
		MainViewCamera.New(),
		MainActivityCenterView.New(),
		MainNoticeRequestView.New()
	}
end

function var_0_0.getNoInteractiveComp(arg_2_0)
	return arg_2_0._mainHeroNoInteractive
end

function var_0_0.getMainHeroView(arg_3_0)
	return arg_3_0._mainHeroView
end

function var_0_0.getMainActivityEnterView(arg_4_0)
	return arg_4_0._mainActivityEnterView
end

function var_0_0.buildTabViews(arg_5_0, arg_5_1)
	local var_5_0 = CurrencyEnum.CurrencyType
	local var_5_1 = {
		var_5_0.Diamond,
		var_5_0.FreeDiamondCoupon,
		var_5_0.Gold
	}

	return {
		CurrencyView.New(var_5_1)
	}
end

function var_0_0.onContainerOpenFinish(arg_6_0)
	arg_6_0:forceRefreshMainSceneYearAnimation()
end

function var_0_0.forceRefreshMainSceneYearAnimation(arg_7_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Main then
		GameSceneMgr.instance:getCurScene().yearAnimation:forcePlayAni()
	end
end

function var_0_0._checkSceneVisible(arg_8_0, arg_8_1)
	if ViewMgr.instance:isOpen(ViewName.SummonView) then
		TaskDispatcher.cancelTask(arg_8_0._checkSceneVisible, arg_8_0)

		return
	end

	local var_8_0 = GameSceneMgr.instance:getCurScene()
	local var_8_1 = var_8_0 and var_8_0:getSceneContainerGO()

	if var_8_1 and not var_8_1.activeSelf then
		TaskDispatcher.cancelTask(arg_8_0._checkSceneVisible, arg_8_0)

		local var_8_2

		if arg_8_0._isVisible then
			local var_8_3 = GameGlobalMgr.instance:getFullViewState()

			var_8_3:forceSceneCameraActive(true)

			local var_8_4 = var_8_3:getOpenFullViewNames()

			logError(string.format("MainViewContainer _checkSceneVisible isVisible:%s,viewName:%s,names:%s", arg_8_0._isVisible, arg_8_1, var_8_4))
		end
	end
end

function var_0_0._onCloseFullView(arg_9_0, arg_9_1)
	if arg_9_0._isVisible then
		TaskDispatcher.cancelTask(arg_9_0._checkSceneVisible, arg_9_0)
		TaskDispatcher.runRepeat(arg_9_0._checkSceneVisible, arg_9_0, 0, 3)
		arg_9_0:_checkSceneVisible(arg_9_1)
	end
end

function var_0_0.onContainerOpen(arg_10_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseFullView, arg_10_0._onCloseFullView, arg_10_0, LuaEventSystem.Low)
end

function var_0_0.onContainerClose(arg_11_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseFullView, arg_11_0._onCloseFullView, arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._checkSceneVisible, arg_11_0)
end

return var_0_0
