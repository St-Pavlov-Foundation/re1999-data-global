module("modules.logic.gamepad.GamepadPointer", package.seeall)

slot0 = class("GamepadPointer", LuaCompBase)

function slot0.ctor(slot0)
	slot0:__onInit()

	slot0._go = gohelper.create2d(ViewMgr.instance:getUILayer("Adaption"), "GamepadPointer")
	slot0._resLoader = PrefabInstantiate.Create(slot0._go)

	slot0._resLoader:startLoad("ui/viewres/gamepad/gamepadpointer.prefab", slot0._onResLoaded, slot0)

	slot0._x = 0
	slot0._y = 0
	slot0._trans = slot0._go.transform
	slot0._moveScale = 25

	recthelper.setAnchor(slot0._trans, 0, 0)
	slot0:_onScreenResize()
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
end

function slot0.getPos(slot0)
	return slot0._x, slot0._y
end

function slot0.getScreenPos(slot0)
	if CameraMgr.instance:getUICamera() then
		slot2 = slot1:WorldToScreenPoint(slot0._trans.position)

		return slot2.x, slot2.y
	end
end

function slot0.setAnchor(slot0, slot1, slot2)
	slot0._x = slot1
	slot0._y = slot2

	slot0:_updatePos()
end

function slot0.updateX(slot0, slot1)
	slot0._x = slot0._x + slot1 * slot0._moveScale

	slot0:_updatePos()
end

function slot0.updateY(slot0, slot1)
	slot0._y = slot0._y + slot1 * slot0._moveScale

	slot0:_updatePos()
end

function slot0._onScreenResize(slot0)
	slot0._screenWidth = 1920

	if UnityEngine.Screen.width / UnityEngine.Screen.height > 1.7777777777777777 then
		slot0._screenWidth = 1080 * slot1
	end

	slot0._halfScreenWidth = slot0._screenWidth / 2
	slot0._halfScreenWidthMinus = -slot0._halfScreenWidth
	slot0._realHalfScreenHeight = UnityEngine.Screen.height / 2
	slot0._halfScreenHeight = 540
	slot0._halfScreenHeightMinus = -540

	slot0:_updatePos()
end

function slot0._updatePos(slot0)
	slot0._x = math.max(slot0._halfScreenWidthMinus, slot0._x)
	slot0._x = math.min(slot0._halfScreenWidth, slot0._x)
	slot0._y = math.max(slot0._halfScreenHeightMinus, slot0._y)
	slot0._y = math.min(slot0._halfScreenHeight, slot0._y)

	recthelper.setAnchor(slot0._trans, slot0._x, slot0._y)
end

function slot0._onResLoaded(slot0)
end

function slot0.onDestroy(slot0)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)

	if slot0._resLoader then
		slot0._resLoader:dispose()

		slot0._resLoader = nil
	end

	slot0:__onDispose()
end

return slot0
