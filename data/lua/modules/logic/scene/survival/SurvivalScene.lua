module("modules.logic.scene.survival.SurvivalScene", package.seeall)

local var_0_0 = class("SurvivalScene", BaseScene)

function var_0_0._createAllComps(arg_1_0)
	arg_1_0:_addComp("pointEffect", SurvivalPointEffectComp)
	arg_1_0:_addComp("fog", SurvivalSceneFogComp)
	arg_1_0:_addComp("camera", SurvivalSceneCameraComp)
	arg_1_0:_addComp("director", SurvivalSceneDirector)
	arg_1_0:_addComp("block", SurvivalSceneMapBlock)
	arg_1_0:_addComp("path", SurvivalSceneMapPath)
	arg_1_0:_addComp("unit", SurvivaSceneMapUnitComp)
	arg_1_0:_addComp("level", SurvivalSceneLevel)
	arg_1_0:_addComp("view", SurvivalSceneViewComp)
	arg_1_0:_addComp("preloader", SurvivalScenePreloader)
	arg_1_0:_addComp("volume", SurvivalScenePPVolume)
	arg_1_0:_addComp("graphics", SurvivalSceneGraphicsComp)
end

function var_0_0.onClose(arg_2_0)
	local var_2_0 = GameSceneMgr.instance:getNextSceneType()

	if var_2_0 ~= SceneType.Survival and var_2_0 ~= SceneType.SurvivalShelter then
		SurvivalMapHelper.instance:clear()
	end

	var_0_0.super.onClose(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.stop_ui_fuleyuan_tansuo_dutiao_loop)
end

return var_0_0
