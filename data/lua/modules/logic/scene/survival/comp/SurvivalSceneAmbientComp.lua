module("modules.logic.scene.survival.comp.SurvivalSceneAmbientComp", package.seeall)

local var_0_0 = class("SurvivalSceneAmbientComp", BaseSceneComp)

function var_0_0.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	SurvivalController.instance:registerCallback(SurvivalEvent.SceneLightLoaded, arg_1_0._onLightLoaded, arg_1_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapGameTimeUpdate, arg_1_0.updateSceneAmbient, arg_1_0)
end

function var_0_0._onLightLoaded(arg_2_0, arg_2_1)
	SurvivalSceneAmbientUtil.instance:_onLightLoaded(arg_2_1)
end

function var_0_0.updateSceneAmbient(arg_3_0)
	SurvivalSceneAmbientUtil.instance:updateSceneAmbient()
end

function var_0_0.onSceneClose(arg_4_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.SceneLightLoaded, arg_4_0._onLightLoaded, arg_4_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapGameTimeUpdate, arg_4_0.updateSceneAmbient, arg_4_0)
	SurvivalSceneAmbientUtil.instance:disable()
end

return var_0_0
