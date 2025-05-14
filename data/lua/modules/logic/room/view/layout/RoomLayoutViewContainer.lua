module("modules.logic.room.view.layout.RoomLayoutViewContainer", package.seeall)

local var_0_0 = class("RoomLayoutViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "go_normalroot/#scroll_ItemList"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = RoomLayoutItem.prefabUrl
	var_1_1.cellClass = RoomLayoutItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirH
	var_1_1.lineCount = 2
	var_1_1.cellWidth = 690
	var_1_1.cellHeight = 400
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 0
	arg_1_0._scrollParam = var_1_1
	arg_1_0._luaScrollView = LuaListScrollView.New(RoomLayoutListModel.instance, var_1_1)

	table.insert(var_1_0, arg_1_0._luaScrollView)
	table.insert(var_1_0, RoomLayoutView.New())

	if not RoomController.instance:isVisitMode() then
		table.insert(var_1_0, TabViewGroup.New(1, "go_navigatebtn"))
	end

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
end

function var_0_0.getCsListScroll(arg_3_0)
	return arg_3_0._luaScrollView:getCsListScroll()
end

function var_0_0.getListScrollParam(arg_4_0)
	return arg_4_0._scrollParam
end

function var_0_0.movetoSelect(arg_5_0)
	local var_5_0 = RoomLayoutListModel.instance
	local var_5_1 = var_5_0:getSelectMO()

	if var_5_1 == nil then
		return
	end

	local var_5_2 = var_5_0:getIndex(var_5_1)

	if var_5_2 == nil then
		return
	end

	local var_5_3 = arg_5_0._luaScrollView:getCsListScroll()

	if not var_5_3 then
		return
	end

	local var_5_4 = arg_5_0._scrollParam.cellWidth + arg_5_0._scrollParam.cellSpaceH
	local var_5_5 = arg_5_0._scrollParam.lineCount
	local var_5_6 = Mathf.Ceil(var_5_2 / var_5_5)
	local var_5_7 = recthelper.getWidth(var_5_3.transform)
	local var_5_8 = Mathf.Max(0, var_5_6 - 1) * var_5_4

	var_5_3.HorizontalScrollPixel = Mathf.Max(0, var_5_8)

	var_5_3:UpdateCells(false)
end

return var_0_0
