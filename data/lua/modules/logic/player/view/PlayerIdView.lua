module("modules.logic.player.view.PlayerIdView", package.seeall)

slot0 = class("PlayerIdView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtDesc = gohelper.findChildText(slot0.viewGO, "node/#txt_desc")
end

function slot0.onOpen(slot0)
	slot0:addEventCb(PlayerController.instance, PlayerEvent.ShowPlayerId, slot0._showId, slot0)
	slot0:addEventCb(SettingsController.instance, SettingsEvent.OnChangeLangTxt, slot0._updateText, slot0)
	slot0:_updateText()
end

function slot0.onUpdateParam(slot0)
	slot0:_updateText()
end

function slot0._updateText(slot0)
	slot0._txtDesc.text = luaLang("ID_desc") .. " ID: " .. slot0.viewParam.userId
end

function slot0.onClose(slot0)
	slot0:removeEventCb(PlayerController.instance, PlayerEvent.ShowPlayerId, slot0._showId, slot0)
	slot0:removeEventCb(SettingsController.instance, SettingsEvent.OnChangeLangTxt, slot0._updateText, slot0)
end

function slot0._showId(slot0, slot1)
	gohelper.setActive(slot0.viewGO, slot1)
end

return slot0
