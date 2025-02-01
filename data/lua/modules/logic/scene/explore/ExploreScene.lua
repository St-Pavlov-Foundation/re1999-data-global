module("modules.logic.scene.explore.ExploreScene", package.seeall)

slot0 = class("ExploreScene", BaseScene)

function slot0._createAllComps(slot0)
	slot0:_addComp("camera", ExploreSceneCameraComp)
	slot0:_addComp("director", ExploreSceneDirector)
	slot0:_addComp("spineMat", ExploreSceneSpineMat)
	slot0:_addComp("preloader", ExploreScenePreloader)
	slot0:_addComp("map", ExploreSceneMap)
	slot0:_addComp("level", ExploreSceneLevel)
	slot0:_addComp("view", ExploreSceneViewComp)
	slot0:_addComp("graphics", ExploreSceneGraphicsComp)
	slot0:_addComp("volume", ExploreScenePPVolume)
	slot0:_addComp("stat", ExploreStatComp)
	slot0:_addComp("audio", ExploreAudioComp)
end

function slot0.onPrepared(slot0)
	uv0.super.onPrepared(slot0)
end

return slot0
