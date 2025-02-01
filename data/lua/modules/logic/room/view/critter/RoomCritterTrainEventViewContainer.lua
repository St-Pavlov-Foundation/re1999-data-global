module("modules.logic.room.view.critter.RoomCritterTrainEventViewContainer", package.seeall)

slot0 = class("RoomCritterTrainEventViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomCritterTrainEventView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_BackBtns"))
	table.insert(slot1, TabViewGroup.New(2, "#go_rightTop"))

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
	elseif slot1 == 2 then
		slot0._currencyView = CurrencyView.New({
			CurrencyEnum.CurrencyType.RoomCritterTrain
		})

		return {
			slot0._currencyView
		}
	end
end

return slot0
