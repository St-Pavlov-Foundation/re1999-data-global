-- chunkname: @modules/logic/battlepass/view/BpChargeViewContainer.lua

module("modules.logic.battlepass.view.BpChargeViewContainer", package.seeall)

local BpChargeViewContainer = class("BpChargeViewContainer", BaseViewContainer)

function BpChargeViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_btns"))
	table.insert(views, BpChargeView.New())

	return views
end

function BpChargeViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigationView
		}
	end
end

function BpChargeViewContainer:playOpenTransition()
	local anim = "open"

	BpChargeViewContainer.super.playOpenTransition(self, {
		duration = 3,
		anim = anim
	})
end

return BpChargeViewContainer
