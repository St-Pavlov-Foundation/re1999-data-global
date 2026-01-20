-- chunkname: @modules/logic/room/view/critter/train/RoomCritterTrainStoryViewContainer.lua

module("modules.logic.room.view.critter.train.RoomCritterTrainStoryViewContainer", package.seeall)

local RoomCritterTrainStoryViewContainer = class("RoomCritterTrainStoryViewContainer", BaseViewContainer)

function RoomCritterTrainStoryViewContainer:buildViews()
	local views = {
		RoomCritterTrainStoryView.New(),
		TabViewGroup.New(1, "#go_lefttopbtns")
	}

	return views
end

function RoomCritterTrainStoryViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self._navigateButtonView:setOverrideClose(self.overrideOnCloseClick, self)

		return {
			self._navigateButtonView
		}
	end
end

function RoomCritterTrainStoryViewContainer:overrideOnCloseClick()
	StoryController.instance:closeStoryView()
	self:closeThis()
end

return RoomCritterTrainStoryViewContainer
