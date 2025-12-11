module("modules.logic.scene.shelter.SurvivalShelterScene", package.seeall)

local var_0_0 = class("SurvivalShelterScene", BaseScene)

function var_0_0._createAllComps(arg_1_0)
	arg_1_0:_addComp("camera", SurvivalSceneCameraComp)
	arg_1_0:_addComp("director", SurvivalShelterSceneDirector)
	arg_1_0:_addComp("block", SurvivalShelterSceneMapBlock)
	arg_1_0:_addComp("level", SurvivalShelterSceneLevel)
	arg_1_0:_addComp("view", SurvivalShelterSceneViewComp)
	arg_1_0:_addComp("preloader", SurvivalShelterScenePreloader)
	arg_1_0:_addComp("unit", SurvivalShelterSceneMapUnitComp)
	arg_1_0:_addComp("graphics", SurvivalShelterSceneGraphicsComp)
	arg_1_0:_addComp("volume", SurvivalScenePPVolume)
	arg_1_0:_addComp("path", SurvivalShelterScenePathComp)
	arg_1_0:_addComp("fog", SurvivalShelterSceneFogComp)
	arg_1_0:_addComp("ambient", SurvivalShelterSceneAmbientComp)
	arg_1_0:_addComp("bubble", SurvivalBubbleComp)
end

function var_0_0.onClose(arg_2_0)
	local var_2_0 = GameSceneMgr.instance:getNextSceneType()

	if var_2_0 ~= SceneType.Survival and var_2_0 ~= SceneType.SurvivalShelter and var_2_0 ~= SceneType.SurvivalSummaryAct then
		SurvivalMapHelper.instance:clear()
	end

	var_0_0.super.onClose(arg_2_0)
end

return var_0_0
