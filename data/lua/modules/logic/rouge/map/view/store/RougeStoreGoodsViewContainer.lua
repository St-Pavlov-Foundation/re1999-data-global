module("modules.logic.rouge.map.view.store.RougeStoreGoodsViewContainer", package.seeall)

local var_0_0 = class("RougeStoreGoodsViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RougeStoreGoodsView.New())
	table.insert(var_1_0, RougeMapCoinView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_rougemapdetailcontainer"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

return var_0_0
