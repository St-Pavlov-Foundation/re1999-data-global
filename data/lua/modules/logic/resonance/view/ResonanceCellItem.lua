module("modules.logic.resonance.view.ResonanceCellItem", package.seeall)

slot0 = class("ResonanceCellItem", UserDataDispose)

function slot0.ctor(slot0, slot1, slot2, slot3, slot4)
	slot0:__onInit()

	slot0.gameObject = slot1
	slot0.transform = slot0.gameObject.transform
	slot0.is_filled = false
	slot0.filled_count = 0
	slot0.pos_x = slot2
	slot0.pos_y = slot3
	slot0.parent_view = slot4
	slot0.top_line = slot0.transform:Find("top")
	slot0.bottom_line = slot0.transform:Find("bottom")
	slot0.left_line = slot0.transform:Find("left")
	slot0.right_line = slot0.transform:Find("right")

	slot0:addClickCb(SLFramework.UGUI.UIClickListener.Get(slot0.gameObject), slot0._onCubeClick, slot0)

	slot0._dragListener = SLFramework.UGUI.UIDragListener.Get(slot0.gameObject)

	slot0._dragListener:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._dragListener:AddDragListener(slot0._onDrag, slot0)
	slot0._dragListener:AddDragEndListener(slot0._onDragEnd, slot0)

	slot0.position_x = recthelper.getAnchorX(slot0.transform)
	slot0.position_y = recthelper.getAnchorY(slot0.transform)
	slot0.left_x = slot0.position_x - slot0.parent_view.cell_length / 2
	slot0.right_x = slot0.left_x + slot0.parent_view.cell_length
	slot0.top_y = slot0.position_y + slot0.parent_view.cell_length / 2
	slot0.bottom_y = slot0.top_y - slot0.parent_view.cell_length
	slot0.empty_bg = slot0.transform:Find("lattice") and slot5.gameObject
end

function slot0.detectPosCover(slot0, slot1, slot2)
	if slot0.left_x < slot1 and slot1 < slot0.right_x and slot0.bottom_y < slot2 and slot2 < slot0.top_y then
		return true
	end
end

slot0.color = {
	green = "green",
	red = "red",
	white = "white",
	grey = "grey"
}

function slot0._setLineColor(slot0, slot1, slot2)
	for slot6, slot7 in pairs(uv0.color) do
		if slot1:Find(slot7) then
			gohelper.setActive(slot8.gameObject, slot2 == slot7)
		end
	end
end

function slot0.SetRed(slot0)
	slot0:_setLineColor(slot0.top_line, uv0.color.red)
	slot0:_setLineColor(slot0.right_line, uv0.color.red)
	slot0:_setLineColor(slot0.bottom_line, uv0.color.red)
	slot0:_setLineColor(slot0.left_line, uv0.color.red)
	gohelper.setAsLastSibling(slot0.gameObject)
end

function slot0.SetGreen(slot0)
	gohelper.setAsLastSibling(slot0.gameObject)
end

function slot0.hideEmptyBg(slot0)
	gohelper.setActive(slot0.empty_bg, false)
end

function slot0.SetNormal(slot0, slot1)
	if slot0.empty_bg then
		gohelper.setActive(slot0.empty_bg, slot0.parent_view.drag_data and not slot0.is_filled or false)
	end

	slot2 = slot0.parent_view:getRabbetCell()
	slot3 = slot2[slot0.pos_y][slot0.pos_x - 1]
	slot4 = slot2[slot0.pos_y - 1] and slot2[slot0.pos_y - 1][slot0.pos_x]
	slot5 = slot2[slot0.pos_y][slot0.pos_x + 1]
	slot6 = slot2[slot0.pos_y + 1] and slot2[slot0.pos_y + 1][slot0.pos_x]
	slot7 = slot0.parent_view.put_cube_ani
	slot8 = false

	if slot1 and slot0.cell_data and slot7 and slot7.drag_id == slot0.cell_data.cubeId and slot7.direction == slot0.cell_data.direction and slot7.posX == slot0.cell_data.posX and slot7.posY == slot0.cell_data.posY then
		slot8 = true
		slot0.parent_view.effect_showed = true
	end

	if slot0.cell_data and slot3 and slot3.cell_data == slot0.cell_data and slot0.is_filled then
		slot0:hideLeft()
	else
		slot0:_setLineColor(slot0.left_line, uv0.color.grey)

		if slot8 then
			if not slot0.left_yanwu then
				slot0.left_yanwu = gohelper.clone(slot0.parent_view.go_yanwu, slot0.gameObject)

				recthelper.setAnchor(slot0.left_yanwu.transform, -38.4, 0)
				transformhelper.setLocalRotation(slot0.left_yanwu.transform, 0, 0, 90)
			end

			gohelper.setActive(slot0.left_yanwu, false)
			gohelper.setActive(slot0.left_yanwu, true)
		end
	end

	if slot0.cell_data and slot4 and slot4.cell_data == slot0.cell_data and slot0.is_filled then
		slot0:hideTop()
	else
		slot0:_setLineColor(slot0.top_line, uv0.color.grey)

		if slot8 then
			if not slot0.top_yanwu then
				slot0.top_yanwu = gohelper.clone(slot0.parent_view.go_yanwu, slot0.gameObject)

				recthelper.setAnchor(slot0.top_yanwu.transform, 0, 38.4)
			end

			gohelper.setActive(slot0.top_yanwu, false)
			gohelper.setActive(slot0.top_yanwu, true)
		end
	end

	if slot0.cell_data and slot5 and slot5.cell_data == slot0.cell_data and slot0.is_filled then
		slot0:hideRight()
	else
		slot0:_setLineColor(slot0.right_line, uv0.color.grey)

		if slot8 then
			if not slot0.right_yanwu then
				slot0.right_yanwu = gohelper.clone(slot0.parent_view.go_yanwu, slot0.gameObject)

				recthelper.setAnchor(slot0.right_yanwu.transform, 38.2, 0)
				transformhelper.setLocalRotation(slot0.right_yanwu.transform, 0, 0, -90)
			end

			gohelper.setActive(slot0.right_yanwu, false)
			gohelper.setActive(slot0.right_yanwu, true)
		end
	end

	if slot0.cell_data and slot6 and slot6.cell_data == slot0.cell_data and slot0.is_filled then
		slot0:hideBottom()
	else
		slot0:_setLineColor(slot0.bottom_line, uv0.color.grey)

		if slot8 then
			if not slot0.bottom_yanwu then
				slot0.bottom_yanwu = gohelper.clone(slot0.parent_view.go_yanwu, slot0.gameObject)

				recthelper.setAnchor(slot0.bottom_yanwu.transform, 0, -37.9)
				transformhelper.setLocalRotation(slot0.bottom_yanwu.transform, 0, 0, -180)
			end

			gohelper.setActive(slot0.bottom_yanwu.gameObject, false)
			gohelper.setActive(slot0.bottom_yanwu.gameObject, true)
		end
	end

	slot0:_activeStyleBg()
end

function slot0.hideTop(slot0)
	slot0:_setLineColor(slot0.top_line, uv0.color.white)
end

function slot0.hideRight(slot0)
	slot0:_setLineColor(slot0.right_line, uv0.color.white)
end

function slot0.hideBottom(slot0)
	slot0:_setLineColor(slot0.bottom_line, uv0.color.white)
end

function slot0.hideLeft(slot0)
	slot0:_setLineColor(slot0.left_line, uv0.color.white)
end

function slot0.lightTop(slot0)
	slot0:_setLineColor(slot0.top_line, uv0.color.green)
	slot0:SetGreen()
end

function slot0.lightRight(slot0)
	slot0:_setLineColor(slot0.right_line, uv0.color.green)
	slot0:SetGreen()
end

function slot0.lightBottom(slot0)
	slot0:_setLineColor(slot0.bottom_line, uv0.color.green)
	slot0:SetGreen()
end

function slot0.lightLeft(slot0)
	slot0:_setLineColor(slot0.left_line, uv0.color.green)
	slot0:SetGreen()
end

function slot0._activeStyleBg(slot0)
	slot1 = slot0.is_filled

	if slot0.parent_view and slot0.parent_view.hero_mo_data then
		slot0.mainCubeId = slot0.parent_view.hero_mo_data.talentCubeInfos.own_main_cube_id
	end

	if slot0.is_filled and slot0.cell_data then
		slot1 = slot0.cell_data.cubeId == slot0.mainCubeId
	end
end

function slot0.setCellData(slot0, slot1)
	slot0.cell_data = slot1
end

function slot0._refreshCell(slot0)
	slot0:_activeStyleBg()
end

function slot0.clickCube(slot0)
	slot0:_onCubeClick()
end

function slot0._onCubeClick(slot0)
	if slot0.is_filled then
		if slot0.parent_view.cur_select_cell_data and slot0.cell_data and slot1.cubeId == slot0.cell_data.cubeId and slot1.direction == slot0.cell_data.direction and slot1.posX == slot0.cell_data.posX and slot1.posY == slot0.cell_data.posY then
			slot0.parent_view:onCubeClick(slot0.cell_data)
		else
			slot0.parent_view:_btnCloseTipOnClick()

			slot0.parent_view.cur_select_cell_data = tabletool.copy(slot0.cell_data)

			slot0.parent_view:showCurSelectCubeAttr(slot0.cell_data)
		end
	end
end

function slot0._onDragBegin(slot0, slot1, slot2)
	if slot0.is_filled then
		slot0.parent_view:_onGetCube(slot0.cell_data)
		slot0.parent_view:_onContainerDragBegin(slot1, slot2)
	end
end

function slot0._onDrag(slot0, slot1, slot2)
	slot0.parent_view:_onContainerDrag(slot1, slot2)
end

function slot0._onDragEnd(slot0)
	slot0.parent_view:_onDragEnd()
end

function slot0.releaseSelf(slot0)
	if slot0._dragListener then
		slot0._dragListener:RemoveDragBeginListener()
		slot0._dragListener:RemoveDragListener()
		slot0._dragListener:RemoveDragEndListener()
	end

	slot0:__onDispose()

	slot0.cell_data = nil
	slot0.parent_view = nil
end

return slot0
