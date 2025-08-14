module("modules.logic.weather.eggs.SceneEggMainSceneTransition", package.seeall)

local var_0_0 = class("SceneEggMainSceneTransition", SceneBaseEgg)

function var_0_0._onEnable(arg_1_0)
	if not arg_1_0._context.isMainScene then
		return
	end
end

function var_0_0._onDisable(arg_2_0)
	if not arg_2_0._context.isMainScene then
		return
	end
end

function var_0_0._onInit(arg_3_0)
	if not arg_3_0._context.isMainScene then
		return
	end

	arg_3_0._showSecond = tonumber(arg_3_0._eggConfig.actionParams)

	MainController.instance:registerCallback(MainEvent.OnMainPopupFlowFinish, arg_3_0._onMainPopupFlowFinish, arg_3_0)
	WeatherController.instance:registerCallback(WeatherEvent.MainViewHideTimeUpdate, arg_3_0._onMainViewHideTimeUpdate, arg_3_0)
end

function var_0_0._onMainViewHideTimeUpdate(arg_4_0, arg_4_1)
	if arg_4_1 and arg_4_1 >= arg_4_0._showSecond then
		WeatherSceneController.instance:clearInfo()
		arg_4_0:_showEffect()
	end
end

function var_0_0._onMainPopupFlowFinish(arg_5_0)
	local var_5_0 = arg_5_0:_getZeroTime()

	PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.SceneEggMainSceneTransition), var_5_0)
	arg_5_0:_showEffect()
end

function var_0_0._showEffect(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._delayHideGoList, arg_6_0)
	TaskDispatcher.runDelay(arg_6_0._delayHideGoList, arg_6_0, 2)
	arg_6_0:setGoListVisible(true)
	PostProcessingMgr.instance:setUnitPPValue("sceneMaskTexDownTimes", 0)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, "SceneEggMainSceneTransition", true)
end

function var_0_0._delayHideGoList(arg_7_0)
	arg_7_0:setGoListVisible(false)
	PostProcessingMgr.instance:setUnitPPValue("sceneMaskTexDownTimes", 1)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, "SceneEggMainSceneTransition", false)
end

function var_0_0._onSceneClose(arg_8_0)
	if not arg_8_0._context.isMainScene then
		return
	end

	MainController.instance:unregisterCallback(MainEvent.OnMainPopupFlowFinish, arg_8_0._onMainPopupFlowFinish, arg_8_0)
	WeatherController.instance:unregisterCallback(WeatherEvent.MainViewHideTimeUpdate, arg_8_0._onMainViewHideTimeUpdate, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._delayHideGoList, arg_8_0)
	arg_8_0:_delayHideGoList()
end

function var_0_0._hasDailyShow(arg_9_0)
	if arg_9_0:_getZeroTime() ~= PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.SceneEggMainSceneTransition), 0) then
		return true
	end

	return false
end

function var_0_0._getZeroTime(arg_10_0)
	local var_10_0 = os.date("*t", os.time())

	var_10_0.hour = 0
	var_10_0.min = 0
	var_10_0.sec = 0

	return (os.time(var_10_0))
end

return var_0_0
