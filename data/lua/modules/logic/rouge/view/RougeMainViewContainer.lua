-- chunkname: @modules/logic/rouge/view/RougeMainViewContainer.lua

module("modules.logic.rouge.view.RougeMainViewContainer", package.seeall)

local RougeMainViewContainer = class("RougeMainViewContainer", BaseViewContainer)
local kTabContainerId_NavigateButtonsView = 1

function RougeMainViewContainer:buildViews()
	return {
		RougeMainView.New(),
		RougeBaseDLCViewComp.New(),
		TabViewGroup.New(kTabContainerId_NavigateButtonsView, "#go_lefttop")
	}
end

function RougeMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == kTabContainerId_NavigateButtonsView then
		local navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		navigationView:setHelpId(HelpEnum.HelpId.RougeMainViewHelp)

		return {
			navigationView
		}
	end
end

function RougeMainViewContainer:onContainerClose()
	local c = ViewMgr.instance:getContainer(ViewName.DungeonView)

	if not c then
		return
	end
end

return RougeMainViewContainer
