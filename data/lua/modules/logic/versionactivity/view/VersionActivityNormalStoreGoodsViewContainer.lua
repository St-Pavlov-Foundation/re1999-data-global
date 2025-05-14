module("modules.logic.versionactivity.view.VersionActivityNormalStoreGoodsViewContainer", package.seeall)

local var_0_0 = class("VersionActivityNormalStoreGoodsViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		TabViewGroup.New(1, "#go_topright"),
		VersionActivityNormalStoreGoodsView.New()
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	local var_2_0 = CurrencyEnum.CurrencyType.LeiMiTeBei

	if arg_2_0.viewParam then
		var_2_0 = string.splitToNumber(arg_2_0.viewParam.cost, "#")[2]
	end

	return {
		CurrencyView.New({
			var_2_0
		})
	}
end

function var_0_0.onContainerClickModalMask(arg_3_0)
	arg_3_0:closeThis()
end

return var_0_0
