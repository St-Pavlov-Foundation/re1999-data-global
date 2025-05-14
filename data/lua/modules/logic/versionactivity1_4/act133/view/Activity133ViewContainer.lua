module("modules.logic.versionactivity1_4.act133.view.Activity133ViewContainer", package.seeall)

local var_0_0 = class("Activity133ViewContainer", BaseViewContainer)
local var_0_1 = 1
local var_0_2 = 2

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#scroll_view"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = Activity133ListItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirH
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 268
	var_1_1.cellHeight = 650
	var_1_1.cellSpaceH = 30
	var_1_1.startSpace = 20
	var_1_1.endSpace = 20

	local var_1_2 = {}

	for iter_1_0 = 1, 4 do
		var_1_2[iter_1_0] = (iter_1_0 - 1) * 0.06
	end

	arg_1_0._scrollview = LuaListScrollViewWithAnimator.New(Activity133ListModel.instance, var_1_1, var_1_2)

	table.insert(var_1_0, arg_1_0._scrollview)
	table.insert(var_1_0, Activity133View.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))
	table.insert(var_1_0, TabViewGroup.New(2, "#go_topright"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == var_0_1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0._navigateButtonView
		}
	elseif arg_2_1 == var_0_2 then
		local var_2_0 = CurrencyEnum.CurrencyType.Act133

		arg_2_0._currencyView = CurrencyView.New({
			var_2_0
		})
		arg_2_0._currencyView.foreHideBtn = true

		return {
			arg_2_0._currencyView
		}
	end
end

return var_0_0
