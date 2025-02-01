module("modules.logic.dungeon.view.puzzle.PutCubeGameView", package.seeall)

slot0 = class("PutCubeGameView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._gochessContainer = gohelper.findChild(slot0.viewGO, "chessboard/#go_chessContainer")
	slot0._gomeshContainer = gohelper.findChild(slot0.viewGO, "chessboard/#go_meshContainer")
	slot0._gomeshItem = gohelper.findChild(slot0.viewGO, "chessboard/#go_meshContainer/#go_meshItem")
	slot0._godragAnchor = gohelper.findChild(slot0.viewGO, "chessboard/#go_dragAnchor")
	slot0._godragContainer = gohelper.findChild(slot0.viewGO, "chessboard/#go_dragAnchor/#go_dragContainer")
	slot0._gocellModel = gohelper.findChild(slot0.viewGO, "chessboard/#go_dragAnchor/#go_cellModel")
	slot0._gochessitem = gohelper.findChild(slot0.viewGO, "chessboard/#go_chessitem")
	slot0._goraychessitem = gohelper.findChild(slot0.viewGO, "chessboard/#go_raychessitem")
	slot0._scrollinspiration = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_inspiration")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "#scroll_inspiration/Viewport/#go_Content")
	slot0._goinspirationItem = gohelper.findChild(slot0.viewGO, "#scroll_inspiration/Viewport/#go_Content/#go_inspirationItem")
	slot0._btnrevertlastoperation = gohelper.findChildButton(slot0.viewGO, "#btn_revert_last_operation")
	slot0._btnreset = gohelper.findChildButton(slot0.viewGO, "#btn_reset")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0._btnrevertlastoperation, slot0._onBtnRevertLastOperation, slot0)
	slot0:addClickCb(slot0._btnreset, slot0.onOpen, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:_setChessData()
	slot0:_setDebrisData()
end

function slot0._setChessData(slot0)
	slot0.chess_data = GameUtil.splitString2(slot0.viewParam.param, true, "#", ",")
	slot3 = #slot0.chess_data[1]
	slot0.cell_length = 70
	slot0._rabbet_cell = {}
	slot0._rabbet_cell_list = {}
	slot4 = 0

	for slot8 = 1, #slot0.chess_data do
		slot0._rabbet_cell[slot8] = {}

		for slot12 = 1, slot3 do
			slot13 = nil
			slot13 = (slot4 >= slot0._gomeshContainer.transform.childCount or slot0._gomeshContainer.transform:GetChild(slot4).gameObject) and gohelper.clone(slot0._gomeshItem, slot0._gomeshContainer)

			recthelper.setAnchor(slot13.transform, (slot12 - (slot3 + 1) / 2) * slot0.cell_length, ((slot2 + 1) / 2 - slot8) * slot0.cell_length)

			slot0._rabbet_cell[slot8][slot12] = slot0:openSubView(PutCubeGameItemView, slot13, nil, slot0.chess_data[slot8][slot12], slot0)

			table.insert(slot0._rabbet_cell_list, slot0._rabbet_cell[slot8][slot12])

			slot4 = slot4 + 1
		end
	end
end

function slot0._setDebrisData(slot0)
	slot0.debris_list = {}
	slot0.debris_count_dic = {}
	slot4 = slot0.viewParam.id

	for slot4, slot5 in ipairs(DungeonConfig.instance:getPuzzleSquareDebrisGroupList(slot4)) do
		slot0.debris_count_dic[slot5.id] = slot5.count

		table.insert(slot0.debris_list, slot5)
	end

	slot0:_refreshDebrisList()
end

function slot0._refreshDebrisList(slot0)
	gohelper.CreateObjList(slot0, slot0._onDebrisItemShow, slot0.debris_list, slot0._goContent, slot0._goinspirationItem)
end

function slot0._onDebrisItemShow(slot0, slot1, slot2, slot3)
	slot4 = slot1.transform
	slot1.name = slot3
	slot5 = slot4:Find("item/slot"):GetComponent(gohelper.Type_Image)
	slot6 = slot4:Find("item/slot/icon"):GetComponent(gohelper.Type_Image)
	slot7 = slot4:Find("item/slot/countbg")
	slot9 = slot4:Find("item/slot/glow"):GetComponent(gohelper.Type_Image)
	slot4:Find("item/slot/countbg/count"):GetComponent(gohelper.Type_TextMesh).text = slot0.debris_count_dic[slot2.id]

	gohelper.setActive(slot1, slot0.debris_count_dic[slot2.id] > 0)
	SLFramework.UGUI.UIDragListener.Get(slot5.gameObject):AddDragBeginListener(slot0._onDragBegin, slot0, slot2)
	SLFramework.UGUI.UIDragListener.Get(slot5.gameObject):AddDragListener(slot0._onDrag, slot0)
	SLFramework.UGUI.UIDragListener.Get(slot5.gameObject):AddDragEndListener(slot0._onDragEnd, slot0)
end

function slot0._onDragBegin(slot0, slot1)
	slot0:_createDragItem(slot1)
end

function slot0._createDragItem(slot0, slot1)
	if not slot0.drag_container then
		slot0.drag_container = slot0._godragContainer
		slot0.drag_container_transform = slot0.drag_container.transform
	end

	transformhelper.setLocalRotation(slot0.drag_container_transform, 0, 0, 0)

	if not slot0.drag_container_transform:Find(slot1.id) then
		recthelper.setAnchor(gohelper.clone(slot0._gocellModel, slot0.drag_container, slot2).transform, 0, 0)
	end

	gohelper.setActive(slot0.drag_container, true)

	if slot0.drag_data then
		gohelper.setActive(slot0.drag_container_transform:Find(slot0.drag_data.drag_id).gameObject, false)
	else
		slot0.drag_data = {}
	end

	slot0.drag_data.drag_id = slot2
	slot0.drag_data.config = slot1
	slot4 = slot3.gameObject

	if not slot0.drag_cube_child_list then
		slot0.drag_cube_child_list = {}
		slot0.cube_rightful_count = {}
	end

	if not slot0.drag_cube_child_list[slot2] then
		slot0.drag_cube_child_list[slot2] = {}
		slot0.cube_rightful_count[slot2] = {}

		slot0:_createDragCubeChild(slot0.drag_cube_child_list[slot2], slot1, slot4)
	end

	gohelper.setActive(slot4, true)
end

function slot0._createDragCubeChild(slot0, slot1, slot2, slot3)
	slot4 = GameUtil.splitString2(slot2.shape, true, "#", ",")
	slot6 = GameUtil.getTabLen(slot4[1])
	slot7 = 0

	for slot11 = 1, GameUtil.getTabLen(slot4) do
		for slot15 = 1, slot6 do
			slot16 = slot0:getUserDataTb_()
			slot16.gameObject = gohelper.clone(slot0._gocellModel, slot3)
			slot16.transform = slot16.gameObject.transform
			slot16.rightful = slot4[slot11][slot15] == 1

			if slot16.rightful then
				slot7 = slot7 + 1
			end

			recthelper.setAnchor(slot16.transform, (slot15 - (slot6 + 1) / 2) * slot0.cell_length, ((slot5 + 1) / 2 - slot11) * slot0.cell_length)
			table.insert(slot1, slot16)

			if slot11 == 1 and slot15 == 1 then
				-- Nothing
			end
		end
	end

	slot0.cube_rightful_count[slot2.id] = slot7
end

function slot0._onDrag(slot0)
	if not slot0.drag_data then
		return
	end

	slot1 = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), slot0._gomeshContainer.transform)

	recthelper.setAnchor(slot0.drag_container_transform, slot1.x, slot1.y)
end

function slot0._detectDragResult(slot0, slot1)
	slot0.cur_fill_count = 0

	for slot5, slot6 in ipairs(slot0._rabbet_cell_list) do
		slot7 = slot6

		for slot11, slot12 in ipairs(slot0.drag_cube_child_list[slot0.drag_data.drag_id]) do
			slot13 = slot12.transform

			if slot7:detectPosCover(recthelper.getAnchorX(slot0.drag_container_transform) + recthelper.getAnchorX(slot13), recthelper.getAnchorY(slot0.drag_container_transform) + recthelper.getAnchorY(slot13)) and slot12.rightful and slot7.level < 3 then
				slot0.cur_fill_count = slot0.cur_fill_count + 1

				if slot1 then
					table.insert(slot1, slot7)
				end
			end
		end
	end
end

function slot0._onDragEnd(slot0)
	slot0:_detectDragResult({})

	if not slot0.drag_data then
		slot0:_releaseDragItem()

		slot0.cur_fill_count = 0

		return
	end

	if slot0.cur_fill_count == slot0.cube_rightful_count[slot0.drag_data.config.id] then
		for slot5, slot6 in ipairs(slot1) do
			slot6.level = slot6.level + 1

			slot6:onOpen()
		end

		if not slot0.step_data then
			slot0.step_data = {}
		end

		table.insert(slot0.step_data, {
			config = slot0.drag_data.config,
			fill_cell = slot1
		})

		slot0.debris_count_dic[slot0.drag_data.config.id] = slot0.debris_count_dic[slot0.drag_data.config.id] - 1

		slot0:_refreshDebrisList()

		if slot0:_detectGameWin() then
			DungeonRpc.instance:sendMapElementRequest(slot0.viewParam.id)
			slot0:closeThis()
		end
	end

	slot0:_releaseDragItem()

	slot0.cur_fill_count = 0
end

function slot0._detectGameWin(slot0)
	for slot4, slot5 in ipairs(slot0._rabbet_cell_list) do
		if slot5.level < 3 then
			return false
		end
	end

	return true
end

function slot0._releaseDragItem(slot0)
	if slot0.drag_data then
		gohelper.setActive(slot0.drag_container_transform:Find(slot0.drag_data.drag_id).gameObject, false)
	end

	slot0.drag_data = nil

	gohelper.setActive(slot0.drag_container, false)
end

function slot0._onBtnRevertLastOperation(slot0)
	if slot0.step_data and #slot0.step_data > 0 then
		slot1 = table.remove(slot0.step_data)
		slot2 = slot1.config.id
		slot0.debris_count_dic[slot2] = slot0.debris_count_dic[slot2] + 1

		for slot6, slot7 in ipairs(slot1.fill_cell) do
			slot7.level = slot7.level - 1

			slot7:onOpen()
		end

		slot0:_refreshDebrisList()
	end
end

function slot0.onClose(slot0)
	for slot6 = 0, slot0._goContent.transform.childCount - 1 do
		slot7 = slot1:GetChild(slot6):Find("item/slot").gameObject

		SLFramework.UGUI.UIDragListener.Get(slot7):RemoveDragBeginListener()
		SLFramework.UGUI.UIDragListener.Get(slot7):RemoveDragListener()
		SLFramework.UGUI.UIDragListener.Get(slot7):RemoveDragEndListener()
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
