module("modules.common.gameobject.GameObjectLiveEventComp", package.seeall)

local var_0_0 = class("GameObjectLiveEventComp", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	GameObjectLiveMgr.instance:dispatchEvent(GameObjectLiveEvent.OnStart, arg_2_0.go)
end

function var_0_0.onDestroy(arg_3_0)
	GameObjectLiveMgr.instance:dispatchEvent(GameObjectLiveEvent.OnDestroy, arg_3_0.go)
end

return var_0_0
