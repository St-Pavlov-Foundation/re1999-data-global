module("modules.common.work.OpenSceneWork", package.seeall)

local var_0_0 = class("OpenSceneWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.sceneType = arg_1_1
	arg_1_0.sceneId = arg_1_2
	arg_1_0.levelId = arg_1_3
	arg_1_0.forceStarting = arg_1_4
	arg_1_0.forceSceneType = arg_1_5
end

function var_0_0.onStart(arg_2_0)
	GameSceneMgr.instance:startScene(arg_2_0.sceneType, arg_2_0.sceneId, arg_2_0.levelId, arg_2_0.forceStarting, arg_2_0.forceSceneType)
	GameSceneMgr.instance:registerCallback(arg_2_0.sceneType, arg_2_0.onSceneLoadDone, arg_2_0)
end

function var_0_0.onSceneLoadDone(arg_3_0)
	GameSceneMgr.instance:unregisterCallback(arg_3_0.sceneType, arg_3_0.onSceneLoadDone, arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	GameSceneMgr.instance:unregisterCallback(arg_4_0.sceneType, arg_4_0.onSceneLoadDone, arg_4_0)
end

return var_0_0
