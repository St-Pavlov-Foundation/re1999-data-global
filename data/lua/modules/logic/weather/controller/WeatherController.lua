module("modules.logic.weather.controller.WeatherController", package.seeall)

local var_0_0 = class("WeatherController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	arg_2_0._weatherComp = WeatherComp.New(arg_2_0, true)

	arg_2_0._weatherComp:onInit()
	arg_2_0:registerCallback(WeatherEvent.OnRoleBlend, arg_2_0._onWeatherOnRoleBlend, arg_2_0)
end

function var_0_0.resetWeatherChangeVoiceFlag(arg_3_0)
	arg_3_0._weatherComp:resetWeatherChangeVoiceFlag()
end

function var_0_0.setLightModel(arg_4_0, arg_4_1)
	arg_4_0._weatherComp:setLightModel(arg_4_1)
end

function var_0_0.initRoleGo(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	arg_5_0._weatherComp:initRoleGo(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
end

function var_0_0.changeRoleGo(arg_6_0, arg_6_1)
	arg_6_0._weatherComp:changeRoleGo(arg_6_1)
end

function var_0_0.clearMat(arg_7_0)
	arg_7_0._weatherComp:clearMat()
end

function var_0_0.setRoleMaskEnabled(arg_8_0, arg_8_1)
	arg_8_0._weatherComp:setRoleMaskEnabled(arg_8_1)
end

function var_0_0.getSceneNode(arg_9_0, arg_9_1)
	return arg_9_0._weatherComp:getSceneNode(arg_9_1)
end

function var_0_0.playAnim(arg_10_0, arg_10_1)
	arg_10_0._weatherComp:playAnim(arg_10_1)
end

function var_0_0.initSceneGo(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = MainSceneSwitchModel.instance:getCurSceneId()

	arg_11_0._weatherComp:setSceneId(var_11_0)
	arg_11_0._weatherComp:initSceneGo(arg_11_1, arg_11_2, arg_11_3)
end

function var_0_0.updateOtherComps(arg_12_0, arg_12_1)
	local var_12_0 = MainSceneSwitchModel.instance:getCurSceneId()

	if arg_12_0._eggContainer then
		arg_12_0._eggContainer:onSceneClose()

		arg_12_0._eggContainer = nil
	end

	arg_12_0._eggContainer = WeatherEggContainerComp.New()

	arg_12_0._eggContainer:onInit(var_12_0, true)
	arg_12_0._eggContainer:initSceneGo(arg_12_1)
	arg_12_0._weatherComp:addChangeReportCallback(arg_12_0._eggContainer.onReportChange, arg_12_0._eggContainer, true)

	if arg_12_0._weatherSceneEffectComp then
		arg_12_0._weatherSceneEffectComp:onSceneClose()

		arg_12_0._weatherSceneEffectComp = nil
	end

	arg_12_0._weatherSceneEffectComp = WeatherSceneEffectComp.New()

	arg_12_0._weatherSceneEffectComp:onInit(var_12_0, true)
	arg_12_0._weatherSceneEffectComp:initSceneGo(arg_12_1)
end

function var_0_0._onWeatherOnRoleBlend(arg_13_0, arg_13_1)
	if arg_13_0._weatherSceneEffectComp then
		arg_13_0._weatherSceneEffectComp:onRoleBlend(arg_13_0._weatherComp, arg_13_1[1], arg_13_1[2])
	end
end

function var_0_0.setReportId(arg_14_0, arg_14_1)
	arg_14_0._weatherComp:setReportId(arg_14_1)
end

function var_0_0.getPrevLightMode(arg_15_0)
	return arg_15_0._weatherComp:getPrevLightMode()
end

function var_0_0.getCurLightMode(arg_16_0)
	return arg_16_0._weatherComp:getCurLightMode()
end

function var_0_0.getCurrReport(arg_17_0)
	return arg_17_0._weatherComp:getCurrReport()
end

function var_0_0.getMainColor(arg_18_0)
	return arg_18_0._weatherComp:getMainColor()
end

function var_0_0.playWeatherAudio(arg_19_0)
	arg_19_0._weatherComp:playWeatherAudio()
end

function var_0_0.stopWeatherAudio(arg_20_0)
	arg_20_0._weatherComp:stopWeatherAudio()
end

function var_0_0.setStateByString(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0._weatherComp:setStateByString(arg_21_1, arg_21_2)
end

function var_0_0.lerpColorRGBA(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	return arg_22_0._weatherComp:lerpColorRGBA(arg_22_1, arg_22_2, arg_22_3)
end

function var_0_0.onSceneHide(arg_23_0, arg_23_1)
	if arg_23_0._weatherComp then
		gohelper.setActive(arg_23_0._weatherComp:getSceneGo(), arg_23_1 and true or false)
		arg_23_0._weatherComp:onSceneHide()
	end

	if arg_23_0._eggContainer then
		arg_23_0._eggContainer:onSceneHide()
	end

	if arg_23_0._weatherSceneEffectComp then
		arg_23_0._weatherSceneEffectComp:onSceneHide()
	end
end

function var_0_0.FakeShowScene(arg_24_0, arg_24_1)
	if arg_24_0._weatherComp then
		gohelper.setActive(arg_24_0._weatherComp:getSceneGo(), arg_24_1)
	end
end

function var_0_0.onSceneShow(arg_25_0)
	if arg_25_0._weatherComp then
		gohelper.setActive(arg_25_0._weatherComp:getSceneGo(), true)
		arg_25_0._weatherComp:onSceneShow()
	end

	if arg_25_0._eggContainer then
		arg_25_0._eggContainer:onSceneShow()
	end

	if arg_25_0._weatherSceneEffectComp then
		arg_25_0._weatherSceneEffectComp:onSceneShow()
	end
end

function var_0_0.onSceneClose(arg_26_0)
	arg_26_0._weatherComp:onSceneClose()

	if arg_26_0._eggContainer then
		arg_26_0._eggContainer:onSceneClose()

		arg_26_0._eggContainer = nil
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
