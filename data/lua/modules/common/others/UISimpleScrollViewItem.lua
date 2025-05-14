module("modules.common.others.UISimpleScrollViewItem", package.seeall)

local var_0_0 = class("UISimpleScrollViewItem", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._parentClass = arg_1_1
end

function var_0_0.startLogic(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._obj_root = arg_2_1
	arg_2_0._csListScroll = SLFramework.UGUI.ListScrollView.Get(arg_2_1)
	arg_2_0._scroll_param = arg_2_2 or ListScrollParam.New()
end

function var_0_0.useDefaultParam(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0._scroll_param.scrollDir = arg_3_1
	arg_3_0._scroll_param.lineCount = arg_3_2
	arg_3_3 = arg_3_3 or arg_3_0._obj_root:GetComponentInChildren(gohelper.Type_GridLayoutGroup)
	arg_3_0._scroll_param.cellWidth = arg_3_3.cellSize.x
	arg_3_0._scroll_param.cellHeight = arg_3_3.cellSize.y
	arg_3_0._scroll_param.cellSpaceH = arg_3_3.spacing.x
	arg_3_0._scroll_param.cellSpaceV = arg_3_3.spacing.y

	arg_3_0:setSpace(0, 0)
end

function var_0_0.setCreateParam(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._scroll_param.frameUpdateMs = arg_4_1
	arg_4_0._scroll_param.minUpdateCountInFrame = arg_4_2
end

function var_0_0.setSpace(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._scroll_param.startSpace = arg_5_1
	arg_5_0._scroll_param.endSpace = arg_5_2
end

function var_0_0.setClass(arg_6_0, arg_6_1)
	arg_6_0._tar_class = arg_6_1
end

function var_0_0.setData(arg_7_0, arg_7_1)
	arg_7_0._data = arg_7_1

	if not arg_7_0._init_finish then
		arg_7_0._init_finish = true

		arg_7_0:useScrollParam()
	end

	arg_7_0._csListScroll:UpdateTotalCount(#arg_7_0._data)
end

function var_0_0.useScrollParam(arg_8_0)
	arg_8_0._csListScroll:Init(arg_8_0._scroll_param.scrollDir, arg_8_0._scroll_param.lineCount, arg_8_0._scroll_param.cellWidth, arg_8_0._scroll_param.cellHeight, arg_8_0._scroll_param.cellSpaceH, arg_8_0._scroll_param.cellSpaceV, arg_8_0._scroll_param.startSpace, arg_8_0._scroll_param.endSpace, arg_8_0._scroll_param.sortMode, arg_8_0._scroll_param.frameUpdateMs, arg_8_0._scroll_param.minUpdateCountInFrame, arg_8_0._onUpdateCell, arg_8_0.onUpdateFinish, nil, arg_8_0)
end

function var_0_0.setObjItem(arg_9_0, arg_9_1)
	arg_9_0._obj_item = arg_9_1
end

function var_0_0.setItemViewGOPath(arg_10_0, arg_10_1)
	arg_10_0._viewGO_path = arg_10_1
end

function var_0_0.setUpdateFinishCallback(arg_11_0, arg_11_1)
	arg_11_0._finish_callback = arg_11_1
end

function var_0_0._onUpdateCell(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._item_list = arg_12_0._item_list or {}

	local var_12_0 = arg_12_2 + 1
	local var_12_1 = arg_12_0._item_list[var_12_0]

	if not var_12_1 then
		if arg_12_0._obj_item then
			local var_12_2 = gohelper.clone(arg_12_0._obj_item, arg_12_1, LuaListScrollView.PrefabInstName)

			if arg_12_0._viewGO_path then
				var_12_2 = gohelper.findChild(var_12_2, arg_12_0._viewGO_path)
			end

			var_12_1 = arg_12_0._parentClass:openSubView(arg_12_0._tar_class, var_12_2)
		else
			var_12_1 = arg_12_0._parentClass:openSubView(arg_12_0._tar_class, arg_12_1)
		end

		arg_12_0._item_list[var_12_0] = var_12_1
	end

	var_12_1._index = var_12_0

	var_12_1:onScrollItemRefreshData(arg_12_0._data[var_12_0])
end

function var_0_0.onUpdateFinish(arg_13_0)
	if arg_13_0._finish_callback then
		arg_13_0._finish_callback(arg_13_0._parentClass)
	end
end

function var_0_0.releaseSelf(arg_14_0)
	arg_14_0._item_list = nil
	arg_14_0.tar_class = nil
	arg_14_0._parentClass = nil
	arg_14_0._finish_callback = nil
	arg_14_0._data = nil
	arg_14_0._tar_class = nil
	arg_14_0._scroll_param = nil

	arg_14_0._csListScroll:Clear()
end

return var_0_0
