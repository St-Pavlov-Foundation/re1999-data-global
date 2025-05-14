module("modules.logic.skin.SkinOffsetController", package.seeall)

local var_0_0 = class("SkinOffsetController", BaseController)

var_0_0.Event = {
	OnSelectSkinChange = 1
}
var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)
var_0_0.instance:__onInit()

return var_0_0
