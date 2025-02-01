module("modules.common.gameobject.GameObjectLiveEventComp", package.seeall)

slot0 = class("GameObjectLiveEventComp", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
end

function slot0.onStart(slot0)
	GameObjectLiveMgr.instance:dispatchEvent(GameObjectLiveEvent.OnStart, slot0.go)
end

function slot0.onDestroy(slot0)
	GameObjectLiveMgr.instance:dispatchEvent(GameObjectLiveEvent.OnDestroy, slot0.go)
end

return slot0
