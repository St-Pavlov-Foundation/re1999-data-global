module("modules.common.global.gamestate.GameStateMgr", package.seeall)

slot0 = class("GameStateMgr")

function slot0.ctor(slot0)
	LuaEventSystem.addEventMechanism(slot0)

	slot0._hasLogLowMemory = nil
end

function slot0.init(slot0)
	SLFramework.GameState.Instance:SetApplicationPauseCallback(slot0.onApplicationPause, slot0)
	SLFramework.GameState.Instance:SetApplicationLowMemoryCallback(slot0.onApplicationLowMemory, slot0)

	if SLFramework.FrameworkSettings.IsEditor then
		slot0:_addApplicationQuit()
	end
end

function slot0._addApplicationQuit(slot0)
	setGlobal("OnApplicationQuit", function ()
		uv0.instance:dispatchEvent(GameStateEvent.OnApplicationQuit)
	end)
end

function slot0.onApplicationPause(slot0, slot1)
	uv0.instance:dispatchEvent(GameStateEvent.onApplicationPause, slot1)
end

function slot0.onApplicationLowMemory(slot0)
	if not slot0._hasLogLowMemory then
		slot0._hasLogLowMemory = true

		logWarn("可用内存不足")
	end

	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC, slot0)
end

slot0.instance = slot0.New()

return slot0
