module("modules.logic.seasonver.act123.view1_9.Season123_1_9RetailViewContainer", package.seeall)

slot0 = class("Season123_1_9RetailViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123_1_9CheckCloseView.New(),
		Season123_1_9RetailView.New(),
		TabViewGroup.New(1, "#go_lefttop"),
		TabViewGroup.New(2, "#go_righttop")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0._navigateButtonView
		}
	elseif slot1 == 2 then
		return slot0:buildCurrency()
	end
end

function slot0.buildCurrency(slot0)
	slot0._currencyView = CurrencyView.New({}, nil, , , true)
	slot0._currencyView.foreHideBtn = true

	return {
		slot0._currencyView
	}
end

function slot0.refreshCurrencyType(slot0)
	if slot0._currencyView then
		slot0._currencyView:setCurrencyType({
			Season123Config.instance:getEquipItemCoin(Season123RetailModel.instance.activityId, Activity123Enum.Const.UttuTicketsCoin)
		})
	end
end

return slot0
