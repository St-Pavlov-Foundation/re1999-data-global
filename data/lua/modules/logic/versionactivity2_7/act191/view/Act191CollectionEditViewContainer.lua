module("modules.logic.versionactivity2_7.act191.view.Act191CollectionEditViewContainer", package.seeall)

local var_0_0 = class("Act191CollectionEditViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Act191CollectionEditView.New())

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "right_container/CollectionList/scroll_collection"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = Act191CollectionEditItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 5
	var_1_1.cellWidth = 200
	var_1_1.cellHeight = 200
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 10

	table.insert(var_1_0, LuaListScrollView.New(Act191CollectionEditListModel.instance, var_1_1))
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

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
