module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_StoreViewContainer", package.seeall)

local var_0_0 = class("V1a6_BossRush_StoreViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		V1a6_BossRush_StoreView.New(),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_righttop")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end

	if arg_2_1 == 2 then
		arg_2_0._currencyView = CurrencyView.New({
			CurrencyEnum.CurrencyType.BossRushStore
		}, arg_2_0._onCurrencyCallback, arg_2_0)
		arg_2_0._currencyView.foreHideBtn = true

		return {
			arg_2_0._currencyView
		}
	end
end

function var_0_0._onCurrencyCallback(arg_3_0)
	BossRushController.instance:dispatchEvent(BossRushEvent.OnHandleInStoreView)
end

return var_0_0
