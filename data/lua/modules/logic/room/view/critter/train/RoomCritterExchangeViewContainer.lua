module("modules.logic.room.view.critter.train.RoomCritterExchangeViewContainer", package.seeall)

local var_0_0 = class("RoomCritterExchangeViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomCritterExchangeView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_righttop"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._currencyView = CurrencyView.New({})
		arg_2_0._currencyView.foreHideBtn = true

		return {
			arg_2_0._currencyView
		}
	end
end

function var_0_0.setCurrencyType(arg_3_0, arg_3_1)
	if arg_3_0._currencyView then
		arg_3_0._currencyView:setCurrencyType(arg_3_1)
	end
end

return var_0_0
