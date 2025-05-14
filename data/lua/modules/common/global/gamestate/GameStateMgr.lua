module("modules.common.global.gamestate.GameStateMgr", package.seeall)

local var_0_0 = class("GameStateMgr")

function var_0_0.ctor(arg_1_0)
	LuaEventSystem.addEventMechanism(arg_1_0)

	arg_1_0._hasLogLowMemory = nil
end

function var_0_0.init(arg_2_0)
	SLFramework.GameState.Instance:SetApplicationPauseCallback(arg_2_0.onApplicationPause, arg_2_0)
	SLFramework.GameState.Instance:SetApplicationLowMemoryCallback(arg_2_0.onApplicationLowMemory, arg_2_0)

	if SLFramework.FrameworkSettings.IsEditor then
		arg_2_0:_addApplicationQuit()
	end
end

function var_0_0._addApplicationQuit(arg_3_0)
	setGlobal("OnApplicationQuit", function()
		var_0_0.instance:dispatchEvent(GameStateEvent.OnApplicationQuit)
	end)
end

function var_0_0.onApplicationPause(arg_5_0, arg_5_1)
	var_0_0.instance:dispatchEvent(GameStateEvent.onApplicationPause, arg_5_1)
end

function var_0_0.onApplicationLowMemory(arg_6_0)
	if not arg_6_0._hasLogLowMemory then
		arg_6_0._hasLogLowMemory = true

		logWarn("可用内存不足")
	end

	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC, arg_6_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
