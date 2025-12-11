module("modules.logic.scene.shelter.comp.SurvivalShelterSceneAmbientComp", package.seeall)

local var_0_0 = class("SurvivalShelterSceneAmbientComp", SurvivalSceneAmbientComp)

function var_0_0.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	SurvivalController.instance:registerCallback(SurvivalEvent.SceneLightLoaded, arg_1_0._onLightLoaded, arg_1_0)
end

return var_0_0
