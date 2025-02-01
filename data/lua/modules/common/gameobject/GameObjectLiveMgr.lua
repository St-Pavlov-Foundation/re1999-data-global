module("modules.common.gameobject.GameObjectLiveMgr", package.seeall)

slot0 = class("GameObjectLiveMgr")
slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
