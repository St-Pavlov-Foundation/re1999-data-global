-- chunkname: @modules/logic/player/view/PlayerViewContainer.lua

module("modules.logic.player.view.PlayerViewContainer", package.seeall)

local PlayerViewContainer = class("PlayerViewContainer", BaseViewContainer)

function PlayerViewContainer:buildViews()
	local views = {}

	table.insert(views, PlayerView.New())
	table.insert(views, PlayerViewAchievement.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function PlayerViewContainer:buildTabViews(tabContainerId)
	if self.viewParam and self.viewParam.hideHomeBtn then
		self.navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})
	else
		self.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})
	end

	return {
		self.navigationView
	}
end

function PlayerViewContainer:onContainerOpenFinish()
	self.navigationView:resetCloseBtnAudioId(AudioEnum.UI.Play_UI_Player_Interface_Close)
end

return PlayerViewContainer
