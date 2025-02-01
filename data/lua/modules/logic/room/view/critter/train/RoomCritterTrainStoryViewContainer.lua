module("modules.logic.room.view.critter.train.RoomCritterTrainStoryViewContainer", package.seeall)

slot0 = class("RoomCritterTrainStoryViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		RoomCritterTrainStoryView.New(),
		TabViewGroup.New(1, "#go_lefttopbtns")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		slot0._navigateButtonView:setOverrideClose(slot0.overrideOnCloseClick, slot0)

		return {
			slot0._navigateButtonView
		}
	end
end

function slot0.overrideOnCloseClick(slot0)
	StoryController.instance:closeStoryView()
	slot0:closeThis()
end

return slot0
