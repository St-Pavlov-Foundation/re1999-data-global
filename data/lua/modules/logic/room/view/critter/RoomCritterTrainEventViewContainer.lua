module("modules.logic.room.view.critter.RoomCritterTrainEventViewContainer", package.seeall)

slot0 = class("RoomCritterTrainEventViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomCritterTrainEventView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_BackBtns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			slot0.navigateView
		}
	end
end

function slot0._onCurrencyOpen(slot0)
	logError("_onCurrencyOpen")
end

return slot0
