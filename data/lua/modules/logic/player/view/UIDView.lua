module("modules.logic.player.view.UIDView", package.seeall)

slot0 = class("UIDView", UserDataDispose)
slot3 = 2.25 - 1.7777777777777777
slot4 = 56
slot5 = 135

function slot0.getInstance()
	if not uv0.instance then
		uv0.instance = uv0.New()

		uv0.instance:__onInit()
	end

	return uv0.instance
end

function slot0.hidePlayerId(slot0)
	if slot0._txtId then
		slot0._txtId.text = ""
	end
end

function slot0.showPlayerId(slot0)
	if not slot0._txtId then
		slot0:loadPrefab()

		return
	end

	slot0._txtId.text = "ID : " .. PlayerModel.instance:getMyUserId()
end

function slot0.loadPrefab(slot0)
	if slot0.loader then
		return
	end

	slot0.loader = PrefabInstantiate.Create(gohelper.find("IDCanvas/POPUP"))

	slot0.loader:startLoad("ui/viewres/common/uid.prefab", slot0.loadedCallback, slot0)
end

function slot0.loadedCallback(slot0)
	slot0.tr = slot0.loader:getInstGO().transform
	slot0._txtId = gohelper.findChildText(slot0.loader:getInstGO(), "#txt_id")

	slot0:showPlayerId()
	slot0:setAnchorPos()
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0.setAnchorPos, slot0)
end

function slot0.setAnchorPos(slot0)
	slot1, slot2 = GameGlobalMgr.instance:getScreenState():getScreenSize()

	recthelper.setAnchorX(slot0.tr, Mathf.Lerp(uv2, uv3, (slot1 / slot2 - uv0) / uv1))
end

return slot0
