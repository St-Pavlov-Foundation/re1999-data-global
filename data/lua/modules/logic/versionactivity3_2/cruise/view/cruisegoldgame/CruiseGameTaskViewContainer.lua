-- chunkname: @modules/logic/versionactivity3_2/cruise/view/cruisegoldgame/CruiseGameTaskViewContainer.lua

module("modules.logic.versionactivity3_2.cruise.view.cruisegoldgame.CruiseGameTaskViewContainer", package.seeall)

local CruiseGameTaskViewContainer = class("CruiseGameTaskViewContainer", BaseViewContainer)

function CruiseGameTaskViewContainer:buildViews()
	local views = {
		CruiseGameTaskView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}

	return views
end

function CruiseGameTaskViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		}, nil)

		return {
			self.navigateButtonView
		}
	end
end

return CruiseGameTaskViewContainer
