-- chunkname: @modules/logic/versionactivity3_0/enter/view/subview/VersionActivity3_0_v2a1_ReactivityEnterviewContainer.lua

module("modules.logic.versionactivity3_0.enter.view.subview.VersionActivity3_0_v2a1_ReactivityEnterviewContainer", package.seeall)

local VersionActivity3_0_v2a1_ReactivityEnterviewContainer = class("VersionActivity3_0_v2a1_ReactivityEnterviewContainer", BaseViewContainer)

function VersionActivity3_0_v2a1_ReactivityEnterviewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity3_0_v2a1_ReactivityEnterview.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function VersionActivity3_0_v2a1_ReactivityEnterviewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

function VersionActivity3_0_v2a1_ReactivityEnterviewContainer:getIsFirstPlaySubViewAnim()
	return self.isFirstPlaySubViewAnim
end

function VersionActivity3_0_v2a1_ReactivityEnterviewContainer:markPlayedSubViewAnim()
	self.isFirstPlaySubViewAnim = false
end

return VersionActivity3_0_v2a1_ReactivityEnterviewContainer
