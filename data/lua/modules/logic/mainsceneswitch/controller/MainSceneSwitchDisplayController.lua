module("modules.logic.mainsceneswitch.controller.MainSceneSwitchDisplayController", package.seeall)

slot0 = class("MainSceneSwitchDisplayController", BaseController)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.clear(slot0)
	if slot0._loaderMap then
		for slot4, slot5 in pairs(slot0._loaderMap) do
			slot5:dispose()
		end

		tabletool.clear(slot0._loaderMap)
	end

	if slot0._weatherCompMap then
		for slot4, slot5 in pairs(slot0._weatherCompMap) do
			for slot9, slot10 in ipairs(slot5) do
				slot10:onSceneClose()
			end
		end

		tabletool.clear(slot0._weatherCompMap)
	end

	if slot0._sceneNameMap then
		for slot4, slot5 in pairs(slot0._sceneNameMap) do
			gohelper.destroy(slot5)
		end

		tabletool.clear(slot0._sceneNameMap)
	end

	slot0._sceneRoot = nil
	slot0._callback = nil
	slot0._callbackTarget = nil
end

function slot0.hasSceneRoot(slot0)
	return slot0._sceneRoot ~= nil
end

function slot0.removeScene(slot0, slot1, slot2)
	slot3, slot4 = slot0:_getSceneConfig(slot1)

	if slot2 then
		slot5 = slot0._sceneNameMap[slot4]

		gohelper.destroy(slot5)
		gohelper.setActive(slot5, false)

		if slot0._loaderMap[slot4] then
			slot6:dispose()

			slot0._loaderMap[slot4] = nil
		end
	end

	slot0._sceneNameMap[slot4] = nil

	if slot0._weatherCompMap[slot4] then
		for slot9, slot10 in ipairs(slot5) do
			slot10:onSceneClose()
		end

		slot0._weatherCompMap[slot4] = nil
	end
end

function slot0.initMaps(slot0)
	slot0._loaderMap = {}
	slot0._sceneNameMap = {}
	slot0._weatherCompMap = {}
end

function slot0.setSceneRoot(slot0, slot1)
	slot0._sceneRoot = slot1

	for slot7 = slot0._sceneRoot.transform.childCount - 1, 0, -1 do
		slot8 = slot2:GetChild(slot7)
		slot0._sceneNameMap[slot8.name] = slot8.gameObject
	end
end

function slot0.hideScene(slot0)
	slot0._isShowScene = false

	if slot0._weatherCompMap then
		for slot4, slot5 in pairs(slot0._weatherCompMap) do
			for slot9, slot10 in pairs(slot5) do
				if slot10.onSceneHide then
					slot10:onSceneHide()
				end
			end
		end
	end
end

function slot0.showCurScene(slot0)
	if not slot0._curSceneId then
		return
	end

	slot0:showScene(slot0._curSceneId, slot0._callback, slot0._calbackTarget)
end

slot1 = "MainSceneSwitchDisplayController_showScene"

function slot0.showScene(slot0, slot1, slot2, slot3)
	slot0._curSceneId = slot1
	slot0._isShowScene = true
	slot0._callback = slot2
	slot0._callbackTarget = slot3
	slot4, slot5 = slot0:_getSceneConfig(slot1)

	if slot0._sceneNameMap[slot5] then
		slot0:_showScene(slot5)

		return
	end

	if not slot0._loaderMap[slot5] then
		UIBlockHelper.instance:startBlock(uv0, 1)

		slot6 = MultiAbLoader.New()
		slot0._loaderMap[slot5] = slot6
		slot6._sceneId = slot1

		slot6:addPath(slot4)
		slot6:startLoad(slot0._loadSceneFinish, slot0)
	end
end

function slot0._loadSceneFinish(slot0, slot1)
	UIBlockHelper.instance:endBlock(uv0)

	slot2 = slot1._sceneId
	slot3, slot4, slot5 = slot0:_getSceneConfig(slot2)
	slot7 = gohelper.clone(slot1:getFirstAssetItem():GetResource(slot3), slot0._sceneRoot)
	slot0._sceneNameMap[slot4] = slot7

	transformhelper.setLocalPosXY(slot7.transform, 10000, 0)

	slot8 = WeatherYearAnimationComp.New()
	slot9 = WeatherFrameComp.New()
	slot10 = WeatherComp.New()
	slot11 = WeatherSwitchComp.New()
	slot12 = WeatherEggContainerComp.New()
	slot13 = WeatherSceneEffectComp.New()
	slot0._weatherCompMap[slot4] = {
		slot10,
		slot8,
		slot9,
		slot11,
		slot12,
		slot13
	}

	slot11:onInit(slot2, slot10)
	slot12:onInit(slot2)
	slot12:initSceneGo(slot7)
	slot13:onInit(slot2)
	slot13:initSceneGo(slot7)
	slot8:onInit()
	slot8:initSceneGo(slot7)
	slot9:onInit(slot2)
	slot9:initSceneGo(slot7)
	slot10:addRoleBlendCallback(slot0._onRoleBlendCallback, {
		slot9,
		slot13
	})
	slot10:setSceneResName(slot5)
	slot10:onInit()
	slot10:setSceneId(slot2)
	slot10:initSceneGo(slot7, function ()
		uv0:_showScene(uv1)
	end, slot10)
	slot10:addChangeReportCallback(slot12.onReportChange, slot12, true)
end

function slot0._onRoleBlendCallback(slot0, slot1, slot2, slot3)
	for slot7, slot8 in ipairs(slot0) do
		slot8:onRoleBlend(slot1, slot2, slot3)
	end
end

function slot0.setSwitchCompContinue(slot0, slot1, slot2)
	if not slot0:getSwitchComp(slot1) then
		return
	end

	if slot2 then
		slot3:continue()
	else
		slot3:pause()
	end
end

function slot0.getSwitchComp(slot0, slot1)
	slot2, slot3, slot4 = slot0:_getSceneConfig(slot1)

	return slot0._weatherCompMap[slot3] and slot5[4]
end

function slot0._getSceneConfig(slot0, slot1)
	slot3 = lua_scene_switch.configDict[slot1].resName

	return ResUrl.getSceneRes(slot3), slot3 .. "_p(Clone)", slot3
end

function slot0._showScene(slot0, slot1)
	for slot5, slot6 in pairs(slot0._sceneNameMap) do
		if slot5 == slot1 then
			transformhelper.setLocalPosXY(slot6.transform, 0, 0)
		end
	end

	slot2 = nil

	for slot6, slot7 in pairs(slot0._weatherCompMap) do
		if slot6 == slot1 and slot0._isShowScene then
			slot2 = slot7
		else
			for slot12, slot13 in pairs(slot7) do
				if slot13.onSceneHide then
					slot13:onSceneHide()
				end
			end
		end
	end

	if slot2 then
		for slot6, slot7 in pairs(slot2) do
			if slot7.onSceneShow then
				slot7:onSceneShow()
			end
		end
	end

	if slot0._callback then
		slot3(slot0._callbackTarget)
	end

	slot0._callback = nil
	slot0._callbackTarget = nil
end

slot0.instance = slot0.New()

return slot0
