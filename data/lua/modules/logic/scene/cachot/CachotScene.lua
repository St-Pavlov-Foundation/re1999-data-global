module("modules.logic.scene.cachot.CachotScene", package.seeall)

local var_0_0 = class("CachotScene", BaseScene)

function var_0_0._createAllComps(arg_1_0)
	arg_1_0:_addComp("bgm", CachotBGMComp)
	arg_1_0:_addComp("player", CachotPlayerComp)
	arg_1_0:_addComp("camera", CachotSceneCamera)
	arg_1_0:_addComp("director", CachotSceneDirector)
	arg_1_0:_addComp("level", CachotSceneLevel)
	arg_1_0:_addComp("preloader", CachotScenePreloader)
	arg_1_0:_addComp("view", CachotSceneViewComp)
	arg_1_0:_addComp("event", CachotEventComp)
	arg_1_0:_addComp("light", CachotLightComp)
end

return var_0_0
