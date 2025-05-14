module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateSelectChessMenViewContainer", package.seeall)

local var_0_0 = class("EliminateSelectChessMenViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, EliminateSelectChessMenView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttop"))

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "Left/#scroll_ChessList"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = EliminateSelectChessMenItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 5
	var_1_1.cellWidth = 220
	var_1_1.cellHeight = 272
	var_1_1.startSpace = 20

	table.insert(var_1_0, LuaListScrollView.New(EliminateSelectChessMenListModel.instance, var_1_1))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0.navigateView
		}
	end
end

return var_0_0
