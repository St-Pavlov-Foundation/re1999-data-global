module("modules.logic.video.view.FullScreenVideoAdapter", package.seeall)

slot0 = class("FullScreenVideoAdapter", LuaCompBase)
slot1 = 2.4

function slot0.ctor(slot0)
end

function slot0.init(slot0, slot1)
	slot0.tr = slot1.transform

	if slot1:GetComponent(typeof(ZProj.UIBgSelfAdapter)) then
		slot2.enabled = false
		slot2 = nil
	end

	slot0:_onScreenResize(UnityEngine.Screen.width, UnityEngine.Screen.height)
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
end

function slot0._onScreenResize(slot0, slot1, slot2)
	if uv0 < slot1 / slot2 then
		slot4 = slot3 / uv0

		transformhelper.setLocalScale(slot0.tr, slot4, slot4, slot4)
	else
		transformhelper.setLocalScale(slot0.tr, 1, 1, 1)
	end
end

return slot0
