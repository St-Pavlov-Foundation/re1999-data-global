module("modules.logic.weather.controller.WeatherSceneController", package.seeall)

local var_0_0 = class("WeatherSceneController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clearInfo()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clearInfo()
end

function var_0_0.clearInfo(arg_3_0)
	arg_3_0._hideMainViewTime = 0
	arg_3_0._hideStartTime = nil
end

function var_0_0.onInitFinish(arg_4_0)
	return
end

function var_0_0.addConstEvents(arg_5_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_5_0._onOpenView, arg_5_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_5_0._onCloseView, arg_5_0, LuaEventSystem.Low)
	MainController.instance:registerCallback(MainEvent.OnDailyPopupFlowFinish, arg_5_0._onDailyPopupFlowFinish, arg_5_0)
end

function var_0_0._onOpenView(arg_6_0, arg_6_1)
	if MainSceneSwitchModel.instance:getCurSceneId() ~= MainSceneSwitchEnum.SpSceneId then
		arg_6_0:clearInfo()

		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(ViewName.MainView) then
		arg_6_0._hideStartTime = arg_6_0._hideStartTime or Time.time
	end
end

function var_0_0._onCloseView(arg_7_0, arg_7_1)
	if MainSceneSwitchModel.instance:getCurSceneId() ~= MainSceneSwitchEnum.SpSceneId then
		arg_7_0:clearInfo()

		return
	end

	if ViewHelper.instance:checkViewOnTheTop(ViewName.MainView) and arg_7_0._hideStartTime then
		arg_7_0._hideMainViewTime = arg_7_0._hideMainViewTime + Time.time - arg_7_0._hideStartTime
		arg_7_0._hideStartTime = nil

		if MainController.instance:isInPopupFlow() then
			return
		end

		WeatherController.instance:dispatchEvent(WeatherEvent.MainViewHideTimeUpdate, arg_7_0._hideMainViewTime)
	end
end

function var_0_0._onDailyPopupFlowFinish(arg_8_0)
	WeatherController.instance:dispatchEvent(WeatherEvent.MainViewHideTimeUpdate, arg_8_0._hideMainViewTime)
end

var_0_0.instance = var_0_0.New()

return var_0_0
