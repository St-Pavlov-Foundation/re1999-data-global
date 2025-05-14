module("modules.logic.rouge.view.RougeCollectionHandBookViewContainer", package.seeall)

local var_0_0 = class("RougeCollectionHandBookViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "Left/#scroll_collection"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "Left/#scroll_collection/Viewport/Content/#go_collectionitem"
	var_1_0.cellClass = RougeCollectionHandBookItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 4
	var_1_0.cellWidth = 224
	var_1_0.cellHeight = 224
	var_1_0.cellSpaceH = 10
	var_1_0.cellSpaceV = 0
	var_1_0.startSpace = 20
	var_1_0.endSpace = 0

	local var_1_1 = {}

	table.insert(var_1_1, RougeCollectionHandBookView.New())
	table.insert(var_1_1, TabViewGroup.New(1, "#go_topleft"))
	table.insert(var_1_1, LuaListScrollView.New(RougeCollectionHandBookListModel.instance, var_1_0))

	return var_1_1
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
