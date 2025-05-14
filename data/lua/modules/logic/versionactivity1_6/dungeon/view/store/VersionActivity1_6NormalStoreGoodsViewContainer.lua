module("modules.logic.versionactivity1_6.dungeon.view.store.VersionActivity1_6NormalStoreGoodsViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_6NormalStoreGoodsViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		TabViewGroup.New(1, "#go_topright"),
		VersionActivity1_6NormalStoreGoodsView.New()
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	local var_2_0 = CurrencyEnum.CurrencyType.LeiMiTeBei

	if arg_2_0.viewParam then
		var_2_0 = string.splitToNumber(arg_2_0.viewParam.cost, "#")[2]
	end

	arg_2_0._currencyView = CurrencyView.New({
		var_2_0
	})

	arg_2_0._currencyView:setOpenCallback(arg_2_0._onCurrencyOpen, arg_2_0)

	return {
		arg_2_0._currencyView
	}
end

function var_0_0._onCurrencyOpen(arg_3_0)
	local var_3_0 = arg_3_0._currencyView:getCurrencyItem(1)

	gohelper.setActive(var_3_0.btn, false)
	gohelper.setActive(var_3_0.click, true)
	recthelper.setAnchorX(var_3_0.txt.transform, 313)
end

function var_0_0.onContainerClickModalMask(arg_4_0)
	arg_4_0:closeThis()
end

return var_0_0
