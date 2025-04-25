module("modules.logic.scene.room.comp.RoomSceneWeatherComp", package.seeall)

slot0 = class("RoomSceneWeatherComp", BaseSceneComp)
slot0.WeatherUpdateRate = 60
slot0.WeatherSwitchTime = 30

function slot0.onInit(slot0)
	slot0._lightModeParamList = {
		{
			LightIntensity = 1,
			AmbientColor = Color(0.71, 0.698, 0.647, 1),
			FogColor = Color(0.718, 0.749, 0.722, 1),
			LightColor = Color(0.612, 0.487, 0.396, 1)
		},
		{
			LightIntensity = 1,
			AmbientColor = Color(0.447, 0.561, 0.596, 1),
			FogColor = Color(0.404, 0.514, 0.592, 1),
			LightColor = Color(0.6, 0.592, 0.541, 1)
		},
		{
			LightIntensity = 1,
			AmbientColor = Color(0.655, 0.624, 0.58),
			FogColor = Color(0.702, 0.478, 0.388, 1),
			LightColor = Color(0.706, 0.459, 0.353, 1)
		},
		{
			LightIntensity = 1,
			AmbientColor = Color(0.314, 0.467, 0.655, 1),
			FogColor = Color(0.118, 0.31, 0.486, 1),
			LightColor = Color(0.388, 0.627, 0.757, 1)
		}
	}
end

function slot0.init(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()
	slot0._curReportConfig = nil
	slot0._curReportEndTime = nil
	slot0._curLightMode = nil

	if not RoomController.instance:isDebugMode() then
		slot0:_initWeather()
		TaskDispatcher.runRepeat(slot0._checkReport, slot0, uv0.WeatherUpdateRate)
	end

	WeatherController.instance:registerCallback(WeatherEvent.WeatherChanged, slot0._weatherChanged, slot0)
end

function slot0.tweenLightModeParam(slot0, slot1, slot2, slot3)
	if slot0._tweenLightModeParamId then
		slot0._scene.tween:killById(slot0._tweenLightModeParamId)

		slot0._tweenLightModeParamId = nil
	end

	if slot3 then
		slot0:_changeLightModeParam(slot2)
	else
		slot0._tweenLightModeParamId = slot0._scene.tween:tweenFloat(0, 1, uv0.WeatherSwitchTime, slot0._tweenLightModeFrame, slot0._tweenLightModeFinish, slot0, {
			preLightModeParam = slot1,
			curLightModeParam = slot2
		})
	end
end

function slot0._tweenLightModeFrame(slot0, slot1, slot2)
	slot0:_changeLightModeParam({
		AmbientColor = slot2.preLightModeParam.AmbientColor:Lerp(slot2.curLightModeParam.AmbientColor, slot1),
		FogColor = slot2.preLightModeParam.FogColor:Lerp(slot2.curLightModeParam.FogColor, slot1),
		LightColor = slot2.preLightModeParam.LightColor:Lerp(slot2.curLightModeParam.LightColor, slot1),
		LightIntensity = slot2.preLightModeParam.LightIntensity + (slot2.curLightModeParam.LightIntensity - slot2.preLightModeParam.LightIntensity) * slot1
	})
end

function slot0._tweenLightModeFinish(slot0, slot1)
	slot0:_changeLightModeParam(slot1.curLightModeParam)
end

function slot0._changeLightModeParam(slot0, slot1)
end

function slot0._getLightModeParam(slot0)
	return {
		AmbientColor = slot0._scene.bending:getAmbientColor(),
		FogColor = slot0._scene.bending:getFogColor(),
		LightColor = slot0._scene.light:getLightColor(),
		LightIntensity = slot0._scene.light:getLightIntensity()
	}
end

function slot0.setLightMode(slot0, slot1, slot2)
	if slot0._curLightMode == slot1 and not slot2 then
		return
	end

	slot0._curLightMode = slot1

	slot0:tweenLightModeParam(slot0:_getLightModeParam(), slot0._lightModeParamList[slot1] or slot0._lightModeParamList[#slot0._lightModeParamList], slot2)
end

function slot0.setReport(slot0, slot1, slot2)
	if slot0._curReportConfig == slot1 and not slot2 then
		return
	end

	slot0._curReportConfig = slot1

	slot0:setLightMode(slot1.lightMode, slot2)
end

function slot0._initWeather(slot0)
	slot0:updateReport(true)

	if not slot0._curLightMode then
		slot0:setLightMode(1, true)
	end
end

function slot0._weatherChanged(slot0, slot1, slot2)
	slot0:changeReport(slot1, slot2)
end

function slot0.changeReport(slot0, slot1, slot2, slot3)
	if not slot1 or not WeatherConfig.instance:getReport(slot1) or not slot2 then
		return
	end

	slot0:setReport(slot4, slot3)

	slot0._curReportEndTime = ServerTime.now() + slot2
end

function slot0.updateReport(slot0, slot1)
	slot2, slot3 = slot0:_getReport()

	slot0:changeReport(slot2.id, slot3, slot1)
end

function slot0._checkReport(slot0)
	if slot0._curReportEndTime and slot0._curReportEndTime <= ServerTime.now() then
		slot0:updateReport()
	end
end

function slot0._getReport(slot0)
	slot1, slot2 = WeatherModel.instance:getReport()

	return slot1, slot2
end

function slot0.onSceneClose(slot0)
	if slot0._tweenLightModeParamId then
		slot0._scene.tween:killById(slot0._tweenLightModeParamId)

		slot0._tweenLightModeParamId = nil
	end

	WeatherController.instance:unregisterCallback(WeatherEvent.WeatherChanged, slot0._weatherChanged, slot0)
	TaskDispatcher.cancelTask(slot0._checkReport, slot0)
end

return slot0
