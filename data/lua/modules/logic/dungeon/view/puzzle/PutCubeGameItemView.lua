module("modules.logic.dungeon.view.puzzle.PutCubeGameItemView", package.seeall)

local var_0_0 = class("PutCubeGameItemView", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.ctor(arg_6_0, arg_6_1, arg_6_2)
	var_0_0.super.ctor(arg_6_0)

	arg_6_0.ori_level = arg_6_1
	arg_6_0.level = arg_6_1
	arg_6_0.parent_view = arg_6_2
end

function var_0_0.onOpen(arg_7_0)
	gohelper.findChild(arg_7_0.viewGO, "Text"):GetComponent(gohelper.Type_Text).text = arg_7_0.level
	arg_7_0.left_x = recthelper.getAnchorX(arg_7_0.viewGO.transform) - arg_7_0.parent_view.cell_length / 2
	arg_7_0.right_x = recthelper.getAnchorX(arg_7_0.viewGO.transform) + arg_7_0.parent_view.cell_length / 2
	arg_7_0.bottom_y = recthelper.getAnchorY(arg_7_0.viewGO.transform) - arg_7_0.parent_view.cell_length / 2
	arg_7_0.top_y = recthelper.getAnchorY(arg_7_0.viewGO.transform) + arg_7_0.parent_view.cell_length / 2
end

function var_0_0.detectPosCover(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 > arg_8_0.left_x and arg_8_1 < arg_8_0.right_x and arg_8_2 > arg_8_0.bottom_y and arg_8_2 < arg_8_0.top_y then
		return true
	end
end

function var_0_0._onGameClear(arg_9_0)
	return
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
