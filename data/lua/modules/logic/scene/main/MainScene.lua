module("modules.logic.scene.main.MainScene", package.seeall)

local var_0_0 = class("MainScene", BaseScene)

function var_0_0._createAllComps(arg_1_0)
	arg_1_0:_addComp("director", MainSceneDirector)
	arg_1_0:_addComp("level", MainSceneLevelComp)
	arg_1_0:_addComp("camera", MainSceneCameraComp)
	arg_1_0:_addComp("view", MainSceneViewComp)
	arg_1_0:_addComp("gyro", MainSceneGyroComp)
	arg_1_0:_addComp("bgm", CommonSceneBgmComp)
	arg_1_0:_addComp("yearAnimation", MainSceneYearAnimationComp)
end

return var_0_0
