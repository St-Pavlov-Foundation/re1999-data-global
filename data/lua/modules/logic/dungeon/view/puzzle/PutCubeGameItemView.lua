module("modules.logic.dungeon.view.puzzle.PutCubeGameItemView", package.seeall)

slot0 = class("PutCubeGameItemView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.ctor(slot0, slot1, slot2)
	uv0.super.ctor(slot0)

	slot0.ori_level = slot1
	slot0.level = slot1
	slot0.parent_view = slot2
end

function slot0.onOpen(slot0)
	gohelper.findChild(slot0.viewGO, "Text"):GetComponent(gohelper.Type_Text).text = slot0.level
	slot0.left_x = recthelper.getAnchorX(slot0.viewGO.transform) - slot0.parent_view.cell_length / 2
	slot0.right_x = recthelper.getAnchorX(slot0.viewGO.transform) + slot0.parent_view.cell_length / 2
	slot0.bottom_y = recthelper.getAnchorY(slot0.viewGO.transform) - slot0.parent_view.cell_length / 2
	slot0.top_y = recthelper.getAnchorY(slot0.viewGO.transform) + slot0.parent_view.cell_length / 2
end

function slot0.detectPosCover(slot0, slot1, slot2)
	if slot0.left_x < slot1 and slot1 < slot0.right_x and slot0.bottom_y < slot2 and slot2 < slot0.top_y then
		return true
	end
end

function slot0._onGameClear(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
