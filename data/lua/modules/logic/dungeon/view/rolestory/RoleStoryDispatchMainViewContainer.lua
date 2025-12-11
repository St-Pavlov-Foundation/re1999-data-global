module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchMainViewContainer", package.seeall)

local var_0_0 = class("RoleStoryDispatchMainViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoleStoryItemRewardView.New())
	table.insert(var_1_0, RoleStoryDispatchMainView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))
	table.insert(var_1_0, TabViewGroup.New(2, "#go_topright"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0._navigateButtonsView
		}
	end

	local var_2_0 = {
		{
			isIcon = true,
			type = MaterialEnum.MaterialType.Item,
			id = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryActivityItemId)
		},
		CurrencyEnum.CurrencyType.RoleStory
	}

	arg_2_0.currencyView = CurrencyView.New(var_2_0)
	arg_2_0.currencyView.foreHideBtn = true

	return {
		arg_2_0.currencyView
	}
end

function var_0_0.refreshCurrency(arg_3_0, arg_3_1)
	arg_3_0.currencyView:setCurrencyType(arg_3_1)
end

function var_0_0.onContainerClose(arg_4_0)
	if arg_4_0:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) then
		MainController.instance:dispatchEvent(MainEvent.ManuallyOpenMainView)
	end
end

return var_0_0
