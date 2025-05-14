module("modules.logic.seasonver.act123.view2_0.Season123_2_0StoreViewContainer", package.seeall)

local var_0_0 = class("Season123_2_0StoreViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0:buildScrollViews()

	local var_1_0 = {}

	table.insert(var_1_0, arg_1_0.scrollView)
	table.insert(var_1_0, Season123_2_0StoreView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))
	table.insert(var_1_0, TabViewGroup.New(2, "#go_righttop"))

	return var_1_0
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
		local var_2_0 = Season123Model.instance:getCurSeasonId() or VersionActivity2_0Enum.ActivityId.Season
		local var_2_1 = Season123Config.instance:getSeasonConstNum(var_2_0, Activity123Enum.Const.StoreCoinId)
		local var_2_2 = CurrencyView.New({
			var_2_1
		})

		var_2_2.foreHideBtn = true

		return {
			var_2_2
		}
	end
end

function var_0_0.buildScrollViews(arg_3_0)
	local var_3_0 = ListScrollParam.New()

	var_3_0.scrollGOPath = "mask/#scroll_store"
	var_3_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_3_0.prefabUrl = arg_3_0._viewSetting.otherRes[1]
	var_3_0.cellClass = Season123_2_0StoreItem
	var_3_0.scrollDir = ScrollEnum.ScrollDirV
	var_3_0.lineCount = 5
	var_3_0.cellWidth = 356
	var_3_0.cellHeight = 376
	var_3_0.cellSpaceH = 4.26
	var_3_0.cellSpaceV = 15.73
	var_3_0.startSpace = 39
	var_3_0.frameUpdateMs = 100
	arg_3_0.scrollView = LuaListScrollView.New(Season123StoreModel.instance, var_3_0)
end

return var_0_0
