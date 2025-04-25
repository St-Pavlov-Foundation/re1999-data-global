module("modules.logic.room.view.critter.train.RoomCritterExchangeViewContainer", package.seeall)

slot0 = class("RoomCritterExchangeViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomCritterExchangeView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_righttop"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._currencyView = CurrencyView.New({})
		slot0._currencyView.foreHideBtn = true

		return {
			slot0._currencyView
		}
	end
end

function slot0.setCurrencyType(slot0, slot1)
	if slot0._currencyView then
		slot0._currencyView:setCurrencyType(slot1)
	end
end

return slot0
