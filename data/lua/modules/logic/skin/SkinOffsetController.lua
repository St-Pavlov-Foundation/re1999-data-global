module("modules.logic.skin.SkinOffsetController", package.seeall)

slot0 = class("SkinOffsetController", BaseController)
slot0.Event = {
	OnSelectSkinChange = 1
}
slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)
slot0.instance:__onInit()

return slot0
