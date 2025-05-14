module("modules.logic.scene.common.CommonSceneDirector", package.seeall)

local var_0_0 = class("CommonSceneDirector", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	arg_1_0._scene = arg_1_0:getCurScene()
end

function var_0_0.onSceneStart(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._scene.level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, arg_2_0._onLevelLoaded, arg_2_0)
end

function var_0_0.onSceneClose(arg_3_0)
	arg_3_0._scene.level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, arg_3_0._onLevelLoaded, arg_3_0)
end

function var_0_0._onLevelLoaded(arg_4_0, arg_4_1)
	arg_4_0._scene.level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, arg_4_0._onLevelLoaded, arg_4_0)
	arg_4_0._scene:onPrepared()
end

return var_0_0
