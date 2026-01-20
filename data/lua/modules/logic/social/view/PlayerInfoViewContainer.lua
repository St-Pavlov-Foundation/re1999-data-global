-- chunkname: @modules/logic/social/view/PlayerInfoViewContainer.lua

module("modules.logic.social.view.PlayerInfoViewContainer", package.seeall)

local PlayerInfoViewContainer = class("PlayerInfoViewContainer", BaseViewContainer)

function PlayerInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, PlayerInfoView.New())

	return views
end

function PlayerInfoViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return PlayerInfoViewContainer
