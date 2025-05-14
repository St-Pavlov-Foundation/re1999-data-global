module("framework.gamescene.BaseSceneComp", package.seeall)

local var_0_0 = class("BaseSceneComp")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._sceneObj = arg_1_1
	arg_1_0.isOnStarted = nil

	LuaEventSystem.addEventMechanism(arg_1_0)
end

function var_0_0.getCurScene(arg_2_0)
	return arg_2_0._sceneObj
end

function var_0_0.onInit(arg_3_0)
	return
end

function var_0_0.onSceneStart(arg_4_0, arg_4_1, arg_4_2)
	return
end

function var_0_0.onScenePrepared(arg_5_0, arg_5_1, arg_5_2)
	return
end

function var_0_0.onSceneClose(arg_6_0)
	return
end

return var_0_0
