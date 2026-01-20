-- chunkname: @modules/logic/player/view/PlayerIdView.lua

module("modules.logic.player.view.PlayerIdView", package.seeall)

local PlayerIdView = class("PlayerIdView", BaseView)

function PlayerIdView:onInitView()
	self._txtDesc = gohelper.findChildText(self.viewGO, "node/#txt_desc")
end

function PlayerIdView:onOpen()
	self:addEventCb(PlayerController.instance, PlayerEvent.ShowPlayerId, self._showId, self)
	self:addEventCb(SettingsController.instance, SettingsEvent.OnChangeLangTxt, self._updateText, self)
	self:_updateText()
end

function PlayerIdView:onUpdateParam()
	self:_updateText()
end

function PlayerIdView:_updateText()
	self._txtDesc.text = luaLang("ID_desc") .. " ID: " .. self.viewParam.userId
end

function PlayerIdView:onClose()
	self:removeEventCb(PlayerController.instance, PlayerEvent.ShowPlayerId, self._showId, self)
	self:removeEventCb(SettingsController.instance, SettingsEvent.OnChangeLangTxt, self._updateText, self)
end

function PlayerIdView:_showId(v)
	gohelper.setActive(self.viewGO, v)
end

return PlayerIdView
