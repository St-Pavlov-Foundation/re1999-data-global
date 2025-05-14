module("modules.logic.currency.view.PowerActChangeViewContainer", package.seeall)

local var_0_0 = class("PowerActChangeViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, PowerActChangeView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_righttop"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	local var_2_0 = {
		CurrencyEnum.CurrencyType.Power,
		{
			isCurrencySprite = true,
			type = MaterialEnum.MaterialType.PowerPotion,
			id = MaterialEnum.PowerId.ActPowerId
		}
	}

	return {
		CurrencyView.New(var_2_0)
	}
end

return var_0_0
