module("modules.logic.scene.rouge.RougeScene", package.seeall)

local var_0_0 = class("RougeScene", BaseScene)

function var_0_0._createAllComps(arg_1_0)
	arg_1_0:_addComp("camera", RougeSceneCameraComp)
	arg_1_0:_addComp("director", RougeSceneDirector)
	arg_1_0:_addComp("model", RougeSceneModel)
	arg_1_0:_addComp("map", RougeSceneMap)
	arg_1_0:_addComp("view", RougeSceneViewComp)
	arg_1_0:_addComp("bgm", RougeSceneBgmComp)
end

return var_0_0
