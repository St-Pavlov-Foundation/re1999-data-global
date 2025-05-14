module("modules.logic.battlepass.view.BpBuyViewContainer", package.seeall)

local var_0_0 = class("BpBuyViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "bg/#scroll"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "bg/#scroll/item"
	var_1_1.cellClass = BpBuyBonusItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 5
	var_1_1.cellWidth = 146
	var_1_1.cellHeight = 146
	var_1_1.cellSpaceH = 35
	var_1_1.cellSpaceV = 33
	var_1_1.startSpace = 0
	var_1_1.endSpace = 0

	table.insert(var_1_0, LuaListScrollView.New(BpBuyViewModel.instance, var_1_1))
	table.insert(var_1_0, BpBuyView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topright"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0)
	local var_2_0 = CommonConfig.instance:getConstStr(ConstEnum.BpBuyLevelCost)
	local var_2_1 = string.splitToNumber(var_2_0, "#")[2]

	return {
		CurrencyView.New({
			var_2_1
		})
	}
end

return var_0_0
