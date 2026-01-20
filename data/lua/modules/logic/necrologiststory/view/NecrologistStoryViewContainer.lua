-- chunkname: @modules/logic/necrologiststory/view/NecrologistStoryViewContainer.lua

module("modules.logic.necrologiststory.view.NecrologistStoryViewContainer", package.seeall)

local NecrologistStoryViewContainer = class("NecrologistStoryViewContainer", BaseViewContainer)

function NecrologistStoryViewContainer:buildViews()
	local views = {}

	table.insert(views, NecrologistStoryButtonView.New())

	self._storyView = NecrologistStoryView.New()

	table.insert(views, self._storyView)
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function NecrologistStoryViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			navView
		}
	end
end

function NecrologistStoryViewContainer:getLastItem()
	return self._storyView:getLastItem()
end

return NecrologistStoryViewContainer
