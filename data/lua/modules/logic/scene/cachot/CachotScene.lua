module("modules.logic.scene.cachot.CachotScene", package.seeall)

slot0 = class("CachotScene", BaseScene)

function slot0._createAllComps(slot0)
	slot0:_addComp("bgm", CachotBGMComp)
	slot0:_addComp("player", CachotPlayerComp)
	slot0:_addComp("camera", CachotSceneCamera)
	slot0:_addComp("director", CachotSceneDirector)
	slot0:_addComp("level", CachotSceneLevel)
	slot0:_addComp("preloader", CachotScenePreloader)
	slot0:_addComp("view", CachotSceneViewComp)
	slot0:_addComp("event", CachotEventComp)
	slot0:_addComp("light", CachotLightComp)
end

return slot0
