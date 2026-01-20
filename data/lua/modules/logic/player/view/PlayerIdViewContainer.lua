-- chunkname: @modules/logic/player/view/PlayerIdViewContainer.lua

module("modules.logic.player.view.PlayerIdViewContainer", package.seeall)

local PlayerIdViewContainer = class("PlayerIdViewContainer", BaseViewContainer)

function PlayerIdViewContainer:buildViews()
	local views = {}

	self.PlayerIdView = PlayerIdView.New()

	table.insert(views, self.PlayerIdView)

	return views
end

return PlayerIdViewContainer
