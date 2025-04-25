module("modules.logic.weather.controller.WeatherController", package.seeall)

slot0 = class("WeatherController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
	slot0._weatherComp = WeatherComp.New(slot0, true)

	slot0._weatherComp:onInit()
	slot0:registerCallback(WeatherEvent.OnRoleBlend, slot0._onWeatherOnRoleBlend, slot0)
end

function slot0.resetWeatherChangeVoiceFlag(slot0)
	slot0._weatherComp:resetWeatherChangeVoiceFlag()
end

function slot0.setLightModel(slot0, slot1)
	slot0._weatherComp:setLightModel(slot1)
end

function slot0.initRoleGo(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0._weatherComp:initRoleGo(slot1, slot2, slot3, slot4, slot5)
end

function slot0.changeRoleGo(slot0, slot1)
	slot0._weatherComp:changeRoleGo(slot1)
end

function slot0.clearMat(slot0)
	slot0._weatherComp:clearMat()
end

function slot0.setRoleMaskEnabled(slot0, slot1)
	slot0._weatherComp:setRoleMaskEnabled(slot1)
end

function slot0.getSceneNode(slot0, slot1)
	return slot0._weatherComp:getSceneNode(slot1)
end

function slot0.playAnim(slot0, slot1)
	slot0._weatherComp:playAnim(slot1)
end

function slot0.initSceneGo(slot0, slot1, slot2, slot3)
	slot0._weatherComp:setSceneId(MainSceneSwitchModel.instance:getCurSceneId())
	slot0._weatherComp:initSceneGo(slot1, slot2, slot3)
end

function slot0.updateOtherComps(slot0, slot1)
	slot2 = MainSceneSwitchModel.instance:getCurSceneId()

	if slot0._eggContainer then
		slot0._eggContainer:onSceneClose()

		slot0._eggContainer = nil
	end

	slot0._eggContainer = WeatherEggContainerComp.New()

	slot0._eggContainer:onInit(slot2, true)
	slot0._eggContainer:initSceneGo(slot1)
	slot0._weatherComp:addChangeReportCallback(slot0._eggContainer.onReportChange, slot0._eggContainer, true)

	if slot0._weatherSceneEffectComp then
		slot0._weatherSceneEffectComp:onSceneClose()

		slot0._weatherSceneEffectComp = nil
	end

	slot0._weatherSceneEffectComp = WeatherSceneEffectComp.New()

	slot0._weatherSceneEffectComp:onInit(slot2, true)
	slot0._weatherSceneEffectComp:initSceneGo(slot1)
end

function slot0._onWeatherOnRoleBlend(slot0, slot1)
	if slot0._weatherSceneEffectComp then
		slot0._weatherSceneEffectComp:onRoleBlend(slot0._weatherComp, slot1[1], slot1[2])
	end
end

function slot0.setReportId(slot0, slot1)
	slot0._weatherComp:setReportId(slot1)
end

function slot0.getPrevLightMode(slot0)
	return slot0._weatherComp:getPrevLightMode()
end

function slot0.getCurLightMode(slot0)
	return slot0._weatherComp:getCurLightMode()
end

function slot0.getCurrReport(slot0)
	return slot0._weatherComp:getCurrReport()
end

function slot0.getMainColor(slot0)
	return slot0._weatherComp:getMainColor()
end

function slot0.playWeatherAudio(slot0)
	slot0._weatherComp:playWeatherAudio()
end

function slot0.stopWeatherAudio(slot0)
	slot0._weatherComp:stopWeatherAudio()
end

function slot0.setStateByString(slot0, slot1, slot2)
	slot0._weatherComp:setStateByString(slot1, slot2)
end

function slot0.lerpColorRGBA(slot0, slot1, slot2, slot3)
	return slot0._weatherComp:lerpColorRGBA(slot1, slot2, slot3)
end

function slot0.onSceneHide(slot0, slot1)
	if slot0._weatherComp then
		gohelper.setActive(slot0._weatherComp:getSceneGo(), slot1 and true or false)
		slot0._weatherComp:onSceneHide()
	end

	if slot0._eggContainer then
		slot0._eggContainer:onSceneHide()
	end

	if slot0._weatherSceneEffectComp then
		slot0._weatherSceneEffectComp:onSceneHide()
	end
end

function slot0.FakeShowScene(slot0, slot1)
	if slot0._weatherComp then
		gohelper.setActive(slot0._weatherComp:getSceneGo(), slot1)
	end
end

function slot0.onSceneShow(slot0)
	if slot0._weatherComp then
		gohelper.setActive(slot0._weatherComp:getSceneGo(), true)
		slot0._weatherComp:onSceneShow()
	end

	if slot0._eggContainer then
		slot0._eggContainer:onSceneShow()
	end

	if slot0._weatherSceneEffectComp then
		slot0._weatherSceneEffectComp:onSceneShow()
	end
end

function slot0.onSceneClose(slot0)
	slot0._weatherComp:onSceneClose()

	if slot0._eggContainer then
		slot0._eggContainer:onSceneClose()

		slot0._eggContainer = nil
	end
end

slot0.instance = slot0.New()

return slot0
