module("modules.logic.room.view.RoomSceneTaskDetailViewContainer", package.seeall)

slot0 = class("RoomSceneTaskDetailViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomSceneTaskDetailView.New())
	table.insert(slot1, RoomViewTopRight.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			slot0._navigateButtonView
		}
	end
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
