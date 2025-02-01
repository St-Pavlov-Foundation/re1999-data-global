module("modules.logic.mainsceneswitch.controller.MainSceneSwitchController", package.seeall)

slot0 = class("MainSceneSwitchController", BaseController)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, slot0._onGetInfoFinish, slot0)
end

function slot0.reInit(slot0)
	slot0._startSwitchTime = 0

	GameSceneMgr.instance:unregisterCallback(SceneEventName.OnLevelLoaded, slot0._onLevelLoaded, slot0)
end

function slot0._onGetInfoFinish(slot0)
	MainSceneSwitchModel.instance:initSceneId()
end

function slot0.isSwitching(slot0)
	return Time.realtimeSinceStartup - slot0._startSwitchTime <= 10
end

function slot0.switchScene(slot0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		return
	end

	slot0:dispatchEvent(MainSceneSwitchEvent.StartSwitchScene)

	slot0._startSwitchTime = Time.realtimeSinceStartup

	GameSceneMgr.instance:registerCallback(SceneEventName.OnLevelLoaded, slot0._onLevelLoaded, slot0)
	GameSceneMgr.instance:getCurScene().level:switchLevel()
end

function slot0._onLevelLoaded(slot0)
	slot1 = Time.realtimeSinceStartup - slot0._startSwitchTime
	slot0._startSwitchTime = 0

	GameSceneMgr.instance:unregisterCallback(SceneEventName.OnLevelLoaded, slot0._onLevelLoaded, slot0)

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		return
	end

	slot0:dispatchEvent(MainSceneSwitchEvent.SwitchSceneFinish)
end

function slot0.getLightColor(slot0)
	return lua_scene_settings.configDict[MainSceneSwitchModel.instance:getCurSceneId()]["lightColor" .. slot0]
end

function slot0.getPrefabLightStartRotation(slot0)
	return lua_scene_settings.configDict[MainSceneSwitchModel.instance:getCurSceneId()].prefabLightStartRotation[slot0]
end

function slot0.getEffectLightStartRotation(slot0)
	return lua_scene_settings.configDict[MainSceneSwitchModel.instance:getCurSceneId()].effectLightStartRotation[slot0]
end

slot0.instance = slot0.New()

return slot0
