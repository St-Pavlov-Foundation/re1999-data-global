module("modules.logic.turnback.view.new.view.TurnbackDoubleRewardChargeViewContainer", package.seeall)

slot0 = class("TurnbackDoubleRewardChargeViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TurnbackDoubleRewardChargeView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topright"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._currencyView = CurrencyView.New({})

		return {
			slot0._currencyView
		}
	end
end

return slot0
