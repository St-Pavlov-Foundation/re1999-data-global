-- chunkname: @modules/logic/towercompose/view/TowerComposeModEquipViewContainer.lua

module("modules.logic.towercompose.view.TowerComposeModEquipViewContainer", package.seeall)

local TowerComposeModEquipViewContainer = class("TowerComposeModEquipViewContainer", BaseViewContainer)

function TowerComposeModEquipViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerComposeModEquipView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function TowerComposeModEquipViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.TowerComposeModEquip)

		return {
			self.navigateView
		}
	end
end

return TowerComposeModEquipViewContainer
