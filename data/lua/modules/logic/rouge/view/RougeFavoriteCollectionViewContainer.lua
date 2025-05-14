module("modules.logic.rouge.view.RougeFavoriteCollectionViewContainer", package.seeall)

local var_0_0 = class("RougeFavoriteCollectionViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RougeFavoriteCollectionView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttop"))
	table.insert(var_1_0, TabViewGroup.New(2, "#go_content"))
	table.insert(var_1_0, TabViewGroup.New(3, "#go_rougemapdetailcontainer"))

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

	if arg_2_1 == 2 then
		local var_2_0 = MixScrollParam.New()

		var_2_0.scrollGOPath = "Left/#scroll_collection"
		var_2_0.prefabType = ScrollEnum.ScrollPrefabFromRes
		var_2_0.prefabUrl = arg_2_0._viewSetting.otherRes[1]
		var_2_0.cellClass = RougeCollectionListRow
		var_2_0.scrollDir = ScrollEnum.ScrollDirV
		var_2_0.startSpace = 0
		var_2_0.endSpace = 0

		local var_2_1 = ListScrollParam.New()

		var_2_1.scrollGOPath = "Left/#scroll_collection"
		var_2_1.prefabType = ScrollEnum.ScrollPrefabFromView
		var_2_1.prefabUrl = "Left/#scroll_collection/Viewport/Content/#go_collectionitem"
		var_2_1.cellClass = RougeCollectionHandBookItem
		var_2_1.scrollDir = ScrollEnum.ScrollDirV
		var_2_1.lineCount = 4
		var_2_1.cellWidth = 224
		var_2_1.cellHeight = 224
		var_2_1.cellSpaceH = 10
		var_2_1.cellSpaceV = 0
		var_2_1.startSpace = 61
		var_2_1.endSpace = 0

		local var_2_2 = ListScrollParam.New()

		var_2_2.scrollGOPath = "Right/#go_normal/bottom/scrollview"
		var_2_2.prefabType = ScrollEnum.ScrollPrefabFromView
		var_2_2.prefabUrl = "Right/#go_normal/bottom/scrollview/Viewport/Content/Item"
		var_2_2.cellClass = RougeCollectionListDropdownItem
		var_2_2.scrollDir = ScrollEnum.ScrollDirV
		var_2_2.lineCount = 1
		var_2_2.cellWidth = 200
		var_2_2.cellHeight = 120
		var_2_2.cellSpaceH = 0
		var_2_2.cellSpaceV = 0
		var_2_2.startSpace = 20
		var_2_2.endSpace = 0
		arg_2_0._dropDownView = RougeCollectionListDropdownView.New()
		arg_2_0._collectinListView = RougeCollectionListView.New()

		return {
			MultiView.New({
				LuaListScrollView.New(RougeFavoriteCollectionEnchantListModel.instance, var_2_2),
				arg_2_0._dropDownView,
				arg_2_0._collectinListView,
				LuaMixScrollView.New(RougeCollectionListModel.instance, var_2_0)
			}),
			MultiView.New({
				RougeCollectionHandBookView.New(),
				LuaListScrollView.New(RougeCollectionHandBookListModel.instance, var_2_1)
			})
		}
	end

	if arg_2_1 == 3 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

function var_0_0.getDropDownView(arg_3_0)
	return arg_3_0._dropDownView
end

function var_0_0.getCollectionListView(arg_4_0)
	return arg_4_0._collectinListView
end

function var_0_0.selectTabView(arg_5_0, arg_5_1)
	arg_5_0:dispatchEvent(ViewEvent.ToSwitchTab, 2, arg_5_1)
end

return var_0_0
