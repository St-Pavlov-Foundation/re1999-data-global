module("modules.logic.room.view.RoomInventorySelectViewContainer", package.seeall)

local var_0_0 = class("RoomInventorySelectViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0.selectView = RoomInventorySelectView.New()
	arg_1_0._listScrollView = arg_1_0:getScrollView()

	local var_1_0 = {
		arg_1_0.selectView,
		arg_1_0._listScrollView
	}

	table.insert(var_1_0, TabViewGroup.New(1, "blockop_tab"))
	table.insert(var_1_0, TabViewGroup.New(2, "go_content/go_righttop/go_tabtransprotfail"))
	table.insert(var_1_0, RoomInventorySelectEffect.New())

	return var_1_0
end

function var_0_0.getScrollView(arg_2_0)
	local var_2_0 = ListScrollParam.New()

	var_2_0.scrollGOPath = "go_content/scroll_block"
	var_2_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_2_0.prefabUrl = "go_content/#go_item"
	var_2_0.cellClass = RoomInventorySelectItem
	var_2_0.scrollDir = ScrollEnum.ScrollDirH
	var_2_0.lineCount = 1
	var_2_0.cellWidth = 170
	var_2_0.cellHeight = 231
	var_2_0.cellSpaceH = 0.5
	var_2_0.cellSpaceV = 0
	var_2_0.startSpace = 5

	local var_2_1 = {}

	for iter_2_0 = 1, 12 do
		var_2_1[iter_2_0] = (iter_2_0 - 1) * 0.03
	end

	return LuaListScrollViewWithAnimator.New(RoomShowBlockListModel.instance, var_2_0, var_2_1)
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		local var_3_0 = RoomViewBuilding.New()
		local var_3_1 = {
			var_3_0,
			var_3_0:getBuildingListView()
		}

		return {
			MultiView.New(var_3_1)
		}
	elseif arg_3_1 == 2 then
		return {
			RoomTransportPathFailTips.New()
		}
	end
end

function var_0_0.switch2BuildingView(arg_4_0, arg_4_1)
	if arg_4_0.selectView then
		arg_4_0.selectView:_btnbuildingOnClick(arg_4_1)
	end
end

return var_0_0
