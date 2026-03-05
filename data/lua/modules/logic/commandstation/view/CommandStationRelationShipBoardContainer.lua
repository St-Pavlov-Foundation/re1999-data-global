-- chunkname: @modules/logic/commandstation/view/CommandStationRelationShipBoardContainer.lua

module("modules.logic.commandstation.view.CommandStationRelationShipBoardContainer", package.seeall)

local CommandStationRelationShipBoardContainer = class("CommandStationRelationShipBoardContainer", BaseViewContainer)

function CommandStationRelationShipBoardContainer:buildViews()
	local views = {}

	table.insert(views, CommandStationRelationShipBoard.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function CommandStationRelationShipBoardContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	end
end

return CommandStationRelationShipBoardContainer
