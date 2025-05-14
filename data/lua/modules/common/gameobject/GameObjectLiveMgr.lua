module("modules.common.gameobject.GameObjectLiveMgr", package.seeall)

local var_0_0 = class("GameObjectLiveMgr")

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
