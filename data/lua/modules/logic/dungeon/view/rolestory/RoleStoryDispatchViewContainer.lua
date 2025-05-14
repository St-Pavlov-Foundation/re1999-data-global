module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchViewContainer", package.seeall)

local var_0_0 = class("RoleStoryDispatchViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoleStoryDispatchNormalView.New())
	table.insert(var_1_0, RoleStoryDispatchStoryView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))
	table.insert(var_1_0, TabViewGroup.New(2, "#go_topright"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = NavigateButtonsView.New({
			true,
			true,
			true
		}, 1820001)

		return {
			var_2_0
		}
	end

	local var_2_1 = {
		{
			isIcon = true,
			type = MaterialEnum.MaterialType.Item,
			id = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryActivityItemId)
		}
	}

	arg_2_0.currencyView = CurrencyView.New(var_2_1)
	arg_2_0.currencyView.foreHideBtn = true

	return {
		arg_2_0.currencyView
	}
end

return var_0_0
