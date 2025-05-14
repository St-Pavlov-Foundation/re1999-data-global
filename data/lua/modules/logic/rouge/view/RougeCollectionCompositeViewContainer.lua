module("modules.logic.rouge.view.RougeCollectionCompositeViewContainer", package.seeall)

local var_0_0 = class("RougeCollectionCompositeViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "left/#go_list/ListView"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "left/#go_list/ListView/Viewport/Content/#go_listitem"
	var_1_0.cellClass = RougeCollectionCompositeListItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 2
	var_1_0.cellWidth = 170
	var_1_0.cellHeight = 170
	var_1_0.cellSpaceH = 20
	var_1_0.cellSpaceV = 0
	var_1_0.startSpace = 20
	var_1_0.endSpace = 0

	local var_1_1 = {}

	table.insert(var_1_1, RougeCollectionCompositeView.New())
	table.insert(var_1_1, TabViewGroup.New(1, "#go_topleft"))
	table.insert(var_1_1, TabViewGroup.New(2, "#go_rougemapdetailcontainer"))
	table.insert(var_1_1, LuaListScrollView.New(RougeCollectionCompositeListModel.instance, var_1_0))

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
	elseif arg_2_1 == 2 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

return var_0_0
