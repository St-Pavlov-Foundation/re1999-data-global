module("modules.logic.scene.explore.ExploreScene", package.seeall)

local var_0_0 = class("ExploreScene", BaseScene)

function var_0_0._createAllComps(arg_1_0)
	arg_1_0:_addComp("camera", ExploreSceneCameraComp)
	arg_1_0:_addComp("director", ExploreSceneDirector)
	arg_1_0:_addComp("spineMat", ExploreSceneSpineMat)
	arg_1_0:_addComp("preloader", ExploreScenePreloader)
	arg_1_0:_addComp("map", ExploreSceneMap)
	arg_1_0:_addComp("level", ExploreSceneLevel)
	arg_1_0:_addComp("view", ExploreSceneViewComp)
	arg_1_0:_addComp("graphics", ExploreSceneGraphicsComp)
	arg_1_0:_addComp("volume", ExploreScenePPVolume)
	arg_1_0:_addComp("stat", ExploreStatComp)
	arg_1_0:_addComp("audio", ExploreAudioComp)
end

function var_0_0.onPrepared(arg_2_0)
	var_0_0.super.onPrepared(arg_2_0)
end

return var_0_0
