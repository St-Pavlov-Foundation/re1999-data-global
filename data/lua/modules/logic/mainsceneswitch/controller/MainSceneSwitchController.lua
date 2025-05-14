module("modules.logic.mainsceneswitch.controller.MainSceneSwitchController", package.seeall)

local var_0_0 = class("MainSceneSwitchController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, arg_3_0._onGetInfoFinish, arg_3_0)
end

function var_0_0.reInit(arg_4_0)
	arg_4_0._startSwitchTime = 0

	GameSceneMgr.instance:unregisterCallback(SceneEventName.OnLevelLoaded, arg_4_0._onLevelLoaded, arg_4_0)
end

function var_0_0._onGetInfoFinish(arg_5_0)
	MainSceneSwitchModel.instance:initSceneId()
end

function var_0_0.isSwitching(arg_6_0)
	return Time.realtimeSinceStartup - arg_6_0._startSwitchTime <= 10
end

function var_0_0.switchScene(arg_7_0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		return
	end

	arg_7_0:dispatchEvent(MainSceneSwitchEvent.StartSwitchScene)

	arg_7_0._startSwitchTime = Time.realtimeSinceStartup

	GameSceneMgr.instance:registerCallback(SceneEventName.OnLevelLoaded, arg_7_0._onLevelLoaded, arg_7_0)
	GameSceneMgr.instance:getCurScene().level:switchLevel()
end

function var_0_0._onLevelLoaded(arg_8_0)
	local var_8_0 = Time.realtimeSinceStartup - arg_8_0._startSwitchTime

	arg_8_0._startSwitchTime = 0

	GameSceneMgr.instance:unregisterCallback(SceneEventName.OnLevelLoaded, arg_8_0._onLevelLoaded, arg_8_0)

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		return
	end

	arg_8_0:dispatchEvent(MainSceneSwitchEvent.SwitchSceneFinish)
end

function var_0_0.getLightColor(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1

	return lua_scene_settings.configDict[var_9_0]["lightColor" .. arg_9_0]
end

function var_0_0.getPrefabLightStartRotation(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1

	return lua_scene_settings.configDict[var_10_0].prefabLightStartRotation[arg_10_0]
end

function var_0_0.getEffectLightStartRotation(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1

	return lua_scene_settings.configDict[var_11_0].effectLightStartRotation[arg_11_0]
end

function var_0_0.closeReddot()
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.MainSceneSwitch, 0) then
		RedDotRpc.instance:sendShowRedDotRequest(RedDotEnum.DotNode.MainSceneSwitch, false)
	end
end

function var_0_0.AnySceneHasReddot()
	for iter_13_0, iter_13_1 in ipairs(lua_scene_switch.configList) do
		if iter_13_1.defaultUnlock ~= 1 and var_0_0.sceneHasReddot(iter_13_1.id) then
			return true
		end
	end

	return false
end

function var_0_0.sceneHasReddot(arg_14_0)
	return false
end

function var_0_0.closeSceneReddot(arg_15_0)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
