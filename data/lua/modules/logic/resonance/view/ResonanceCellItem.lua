module("modules.logic.resonance.view.ResonanceCellItem", package.seeall)

local var_0_0 = class("ResonanceCellItem", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0:__onInit()

	arg_1_0.gameObject = arg_1_1
	arg_1_0.transform = arg_1_0.gameObject.transform
	arg_1_0.is_filled = false
	arg_1_0.filled_count = 0
	arg_1_0.pos_x = arg_1_2
	arg_1_0.pos_y = arg_1_3
	arg_1_0.parent_view = arg_1_4
	arg_1_0.top_line = arg_1_0.transform:Find("top")
	arg_1_0.bottom_line = arg_1_0.transform:Find("bottom")
	arg_1_0.left_line = arg_1_0.transform:Find("left")
	arg_1_0.right_line = arg_1_0.transform:Find("right")

	arg_1_0:addClickCb(SLFramework.UGUI.UIClickListener.Get(arg_1_0.gameObject), arg_1_0._onCubeClick, arg_1_0)

	arg_1_0._dragListener = SLFramework.UGUI.UIDragListener.Get(arg_1_0.gameObject)

	arg_1_0._dragListener:AddDragBeginListener(arg_1_0._onDragBegin, arg_1_0)
	arg_1_0._dragListener:AddDragListener(arg_1_0._onDrag, arg_1_0)
	arg_1_0._dragListener:AddDragEndListener(arg_1_0._onDragEnd, arg_1_0)

	arg_1_0.position_x = recthelper.getAnchorX(arg_1_0.transform)
	arg_1_0.position_y = recthelper.getAnchorY(arg_1_0.transform)
	arg_1_0.left_x = arg_1_0.position_x - arg_1_0.parent_view.cell_length / 2
	arg_1_0.right_x = arg_1_0.left_x + arg_1_0.parent_view.cell_length
	arg_1_0.top_y = arg_1_0.position_y + arg_1_0.parent_view.cell_length / 2
	arg_1_0.bottom_y = arg_1_0.top_y - arg_1_0.parent_view.cell_length

	local var_1_0 = arg_1_0.transform:Find("lattice")

	arg_1_0.empty_bg = var_1_0 and var_1_0.gameObject
end

function var_0_0.detectPosCover(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 > arg_2_0.left_x and arg_2_1 < arg_2_0.right_x and arg_2_2 > arg_2_0.bottom_y and arg_2_2 < arg_2_0.top_y then
		return true
	end
end

var_0_0.color = {
	green = "green",
	red = "red",
	white = "white",
	grey = "grey"
}

function var_0_0._setLineColor(arg_3_0, arg_3_1, arg_3_2)
	for iter_3_0, iter_3_1 in pairs(var_0_0.color) do
		local var_3_0 = arg_3_1:Find(iter_3_1)

		if var_3_0 then
			gohelper.setActive(var_3_0.gameObject, arg_3_2 == iter_3_1)
		end
	end
end

function var_0_0.SetRed(arg_4_0)
	arg_4_0:_setLineColor(arg_4_0.top_line, var_0_0.color.red)
	arg_4_0:_setLineColor(arg_4_0.right_line, var_0_0.color.red)
	arg_4_0:_setLineColor(arg_4_0.bottom_line, var_0_0.color.red)
	arg_4_0:_setLineColor(arg_4_0.left_line, var_0_0.color.red)
	gohelper.setAsLastSibling(arg_4_0.gameObject)
end

function var_0_0.SetGreen(arg_5_0)
	gohelper.setAsLastSibling(arg_5_0.gameObject)
end

function var_0_0.hideEmptyBg(arg_6_0)
	gohelper.setActive(arg_6_0.empty_bg, false)
end

function var_0_0.SetNormal(arg_7_0, arg_7_1)
	if arg_7_0.empty_bg then
		gohelper.setActive(arg_7_0.empty_bg, arg_7_0.parent_view.drag_data and not arg_7_0.is_filled or false)
	end

	local var_7_0 = arg_7_0.parent_view:getRabbetCell()
	local var_7_1 = var_7_0[arg_7_0.pos_y][arg_7_0.pos_x - 1]
	local var_7_2 = var_7_0[arg_7_0.pos_y - 1] and var_7_0[arg_7_0.pos_y - 1][arg_7_0.pos_x]
	local var_7_3 = var_7_0[arg_7_0.pos_y][arg_7_0.pos_x + 1]
	local var_7_4 = var_7_0[arg_7_0.pos_y + 1] and var_7_0[arg_7_0.pos_y + 1][arg_7_0.pos_x]
	local var_7_5 = arg_7_0.parent_view.put_cube_ani
	local var_7_6 = false

	if arg_7_1 and arg_7_0.cell_data and var_7_5 and var_7_5.drag_id == arg_7_0.cell_data.cubeId and var_7_5.direction == arg_7_0.cell_data.direction and var_7_5.posX == arg_7_0.cell_data.posX and var_7_5.posY == arg_7_0.cell_data.posY then
		var_7_6 = true
		arg_7_0.parent_view.effect_showed = true
	end

	if arg_7_0.cell_data and var_7_1 and var_7_1.cell_data == arg_7_0.cell_data and arg_7_0.is_filled then
		arg_7_0:hideLeft()
	else
		arg_7_0:_setLineColor(arg_7_0.left_line, var_0_0.color.grey)

		if var_7_6 then
			if not arg_7_0.left_yanwu then
				arg_7_0.left_yanwu = gohelper.clone(arg_7_0.parent_view.go_yanwu, arg_7_0.gameObject)

				recthelper.setAnchor(arg_7_0.left_yanwu.transform, -38.4, 0)
				transformhelper.setLocalRotation(arg_7_0.left_yanwu.transform, 0, 0, 90)
			end

			gohelper.setActive(arg_7_0.left_yanwu, false)
			gohelper.setActive(arg_7_0.left_yanwu, true)
		end
	end

	if arg_7_0.cell_data and var_7_2 and var_7_2.cell_data == arg_7_0.cell_data and arg_7_0.is_filled then
		arg_7_0:hideTop()
	else
		arg_7_0:_setLineColor(arg_7_0.top_line, var_0_0.color.grey)

		if var_7_6 then
			if not arg_7_0.top_yanwu then
				arg_7_0.top_yanwu = gohelper.clone(arg_7_0.parent_view.go_yanwu, arg_7_0.gameObject)

				recthelper.setAnchor(arg_7_0.top_yanwu.transform, 0, 38.4)
			end

			gohelper.setActive(arg_7_0.top_yanwu, false)
			gohelper.setActive(arg_7_0.top_yanwu, true)
		end
	end

	if arg_7_0.cell_data and var_7_3 and var_7_3.cell_data == arg_7_0.cell_data and arg_7_0.is_filled then
		arg_7_0:hideRight()
	else
		arg_7_0:_setLineColor(arg_7_0.right_line, var_0_0.color.grey)

		if var_7_6 then
			if not arg_7_0.right_yanwu then
				arg_7_0.right_yanwu = gohelper.clone(arg_7_0.parent_view.go_yanwu, arg_7_0.gameObject)

				recthelper.setAnchor(arg_7_0.right_yanwu.transform, 38.2, 0)
				transformhelper.setLocalRotation(arg_7_0.right_yanwu.transform, 0, 0, -90)
			end

			gohelper.setActive(arg_7_0.right_yanwu, false)
			gohelper.setActive(arg_7_0.right_yanwu, true)
		end
	end

	if arg_7_0.cell_data and var_7_4 and var_7_4.cell_data == arg_7_0.cell_data and arg_7_0.is_filled then
		arg_7_0:hideBottom()
	else
		arg_7_0:_setLineColor(arg_7_0.bottom_line, var_0_0.color.grey)

		if var_7_6 then
			if not arg_7_0.bottom_yanwu then
				arg_7_0.bottom_yanwu = gohelper.clone(arg_7_0.parent_view.go_yanwu, arg_7_0.gameObject)

				recthelper.setAnchor(arg_7_0.bottom_yanwu.transform, 0, -37.9)
				transformhelper.setLocalRotation(arg_7_0.bottom_yanwu.transform, 0, 0, -180)
			end

			gohelper.setActive(arg_7_0.bottom_yanwu.gameObject, false)
			gohelper.setActive(arg_7_0.bottom_yanwu.gameObject, true)
		end
	end

	arg_7_0:_activeStyleBg()
end

function var_0_0.hideTop(arg_8_0)
	arg_8_0:_setLineColor(arg_8_0.top_line, var_0_0.color.white)
end

function var_0_0.hideRight(arg_9_0)
	arg_9_0:_setLineColor(arg_9_0.right_line, var_0_0.color.white)
end

function var_0_0.hideBottom(arg_10_0)
	arg_10_0:_setLineColor(arg_10_0.bottom_line, var_0_0.color.white)
end

function var_0_0.hideLeft(arg_11_0)
	arg_11_0:_setLineColor(arg_11_0.left_line, var_0_0.color.white)
end

function var_0_0.lightTop(arg_12_0)
	arg_12_0:_setLineColor(arg_12_0.top_line, var_0_0.color.green)
	arg_12_0:SetGreen()
end

function var_0_0.lightRight(arg_13_0)
	arg_13_0:_setLineColor(arg_13_0.right_line, var_0_0.color.green)
	arg_13_0:SetGreen()
end

function var_0_0.lightBottom(arg_14_0)
	arg_14_0:_setLineColor(arg_14_0.bottom_line, var_0_0.color.green)
	arg_14_0:SetGreen()
end

function var_0_0.lightLeft(arg_15_0)
	arg_15_0:_setLineColor(arg_15_0.left_line, var_0_0.color.green)
	arg_15_0:SetGreen()
end

function var_0_0._activeStyleBg(arg_16_0)
	local var_16_0 = arg_16_0.is_filled

	if arg_16_0.parent_view and arg_16_0.parent_view.hero_mo_data then
		arg_16_0.mainCubeId = arg_16_0.parent_view.hero_mo_data.talentCubeInfos.own_main_cube_id
	end

	if arg_16_0.is_filled and arg_16_0.cell_data then
		local var_16_1

		var_16_1 = arg_16_0.cell_data.cubeId == arg_16_0.mainCubeId
	end
end

function var_0_0.setCellData(arg_17_0, arg_17_1)
	arg_17_0.cell_data = arg_17_1
end

function var_0_0._refreshCell(arg_18_0)
	arg_18_0:_activeStyleBg()
end

function var_0_0.clickCube(arg_19_0)
	arg_19_0:_onCubeClick()
end

function var_0_0._onCubeClick(arg_20_0)
	if arg_20_0.is_filled then
		local var_20_0 = arg_20_0.parent_view.cur_select_cell_data

		if var_20_0 and arg_20_0.cell_data and var_20_0.cubeId == arg_20_0.cell_data.cubeId and var_20_0.direction == arg_20_0.cell_data.direction and var_20_0.posX == arg_20_0.cell_data.posX and var_20_0.posY == arg_20_0.cell_data.posY then
			arg_20_0.parent_view:onCubeClick(arg_20_0.cell_data)
		else
			arg_20_0.parent_view:_btnCloseTipOnClick()

			arg_20_0.parent_view.cur_select_cell_data = tabletool.copy(arg_20_0.cell_data)

			arg_20_0.parent_view:showCurSelectCubeAttr(arg_20_0.cell_data)
		end
	end
end

function var_0_0._onDragBegin(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0.is_filled then
		arg_21_0.parent_view:_onGetCube(arg_21_0.cell_data)
		arg_21_0.parent_view:_onContainerDragBegin(arg_21_1, arg_21_2)
	end
end

function var_0_0._onDrag(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0.parent_view:_onContainerDrag(arg_22_1, arg_22_2)
end

function var_0_0._onDragEnd(arg_23_0)
	arg_23_0.parent_view:_onDragEnd()
end

function var_0_0.releaseSelf(arg_24_0)
	if arg_24_0._dragListener then
		arg_24_0._dragListener:RemoveDragBeginListener()
		arg_24_0._dragListener:RemoveDragListener()
		arg_24_0._dragListener:RemoveDragEndListener()
	end

	arg_24_0:__onDispose()

	arg_24_0.cell_data = nil
	arg_24_0.parent_view = nil
end

return var_0_0
