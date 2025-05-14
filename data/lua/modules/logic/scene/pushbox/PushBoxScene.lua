module("modules.logic.scene.pushbox.PushBoxScene", package.seeall)

local var_0_0 = class("PushBoxScene", BaseScene)

function var_0_0._createAllComps(arg_1_0)
	arg_1_0:_addComp("director", PushBoxSceneDirector)
	arg_1_0:_addComp("preloader", PushBoxScenePreloader)
	arg_1_0:_addComp("camera", PushBoxSceneCameraComp)
	arg_1_0:_addComp("gameMgr", PushBoxGameMgr)
	arg_1_0:_addComp("view", PushBoxSceneViewComp)
end

return var_0_0
