module("modules.logic.rouge.view.RougeCollectionChessSlotComp", package.seeall)

slot0 = class("RougeCollectionChessSlotComp", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclosetipArea = gohelper.findChildButtonWithAudio(slot0.viewGO, "bg/#btn_closetipArea")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._gochessContainer = gohelper.findChild(slot0.viewGO, "chessboard/#go_chessContainer")
	slot0._gomeshContainer = gohelper.findChild(slot0.viewGO, "chessboard/#go_meshContainer")
	slot0._gomeshItem = gohelper.findChild(slot0.viewGO, "chessboard/#go_meshContainer/#go_meshItem")
	slot0._godragContainer = gohelper.findChild(slot0.viewGO, "chessboard/#go_dragContainer")
	slot0._gocellModel = gohelper.findChild(slot0.viewGO, "chessboard/#go_cellModel")
	slot0._gochessitem = gohelper.findChild(slot0.viewGO, "chessboard/#go_dragContainer/#go_chessitem")
	slot0._goraychessitem = gohelper.findChild(slot0.viewGO, "chessboard/#go_raychessitem")
	slot0._goblock = gohelper.findChild(slot0.viewGO, "#go_block")
	slot0._scrollbag = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_bag")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "#scroll_bag/Viewport/#go_Content")
	slot0._gocollectionItem = gohelper.findChild(slot0.viewGO, "#scroll_bag/Viewport/#go_Content/#go_collectionItem")
	slot0._gotip = gohelper.findChild(slot0.viewGO, "#go_tip")
	slot0._gosingleTipsContent = gohelper.findChild(slot0.viewGO, "#go_tip/attributetip/#go_singleTipsContent")
	slot0._gosingleAttributeItem = gohelper.findChild(slot0.viewGO, "#go_tip/attributetip/#go_singleTipsContent/#go_singleAttributeItem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.UpdateSlotCellState, slot0.updateSlotCellState, slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.PlaceCollection2SlotArea, slot0.placeCollection2SlotAreaSucc, slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.NullSpace2PlaceCollection, slot0.onNullSpace2PlaceCollection, slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.Failed2PlaceSlotCollection, slot0.placeCollection2SlotAreaFailed, slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.DeleteSlotCollection, slot0.deleteSlotCollection, slot0)
	slot0:addEventCb(RougeCollectionEnchantController.instance, RougeEvent.UpdateCollectionEnchant, slot0.updateCollectionEnchant, slot0)

	slot0._coverCells = slot0:getUserDataTb_()
	slot0._conflictIds = slot0:getUserDataTb_()
	slot0._placeCollectionMap = {}
end

function slot0.onOpen(slot0)
	slot1 = RougeCollectionModel.instance:getCurSlotAreaSize()

	slot0:initCollectionSlot(slot1.col, slot1.row)
	slot0:updateAllFilledCellState()
end

function slot0.initCollectionSlot(slot0, slot1, slot2)
	slot3 = RougeCollectionHelper.CollectionSlotCellSize.x
	slot4 = RougeCollectionHelper.CollectionSlotCellSize.y
	slot5 = gohelper.findChild(slot0.viewGO, "chessboard")

	recthelper.setWidth(slot5.transform, (slot1 or 0) * slot3)
	recthelper.setHeight(slot5.transform, (slot2 or 0) * slot4)
	recthelper.setAnchor(slot0._gomeshContainer.transform, slot3 / 2, -slot4 / 2)
	recthelper.setAnchor(slot0._godragContainer.transform, slot3 / 2, -slot4 / 2)
	recthelper.setAnchor(slot0._gocellModel.transform, slot3 / 2, -slot4 / 2)

	for slot9 = 0, slot2 - 1 do
		for slot13 = 0, slot1 - 1 do
			slot0:createCollectionSlotCell(slot13, slot9)
		end
	end
end

function slot0.updateAllFilledCellState(slot0)
	if RougeCollectionModel.instance:getSlotAreaCollection() then
		for slot5, slot6 in ipairs(slot1) do
			slot0:placeCollection2SlotAreaSucc(slot6)
		end
	end
end

function slot0.getCollectionSlotCell(slot0, slot1, slot2)
	return slot0._slotCellTab and slot0._slotCellTab[slot1] and slot0._slotCellTab[slot1][slot2]
end

function slot0.createCollectionSlotCell(slot0, slot1, slot2)
	slot3 = gohelper.cloneInPlace(slot0._gomeshItem, string.format("%s_%s", slot1, slot2))
	slot4, slot5 = RougeCollectionHelper.slotPos2AnchorPos(Vector2(slot1, slot2))

	recthelper.setAnchor(slot3.transform, slot4, slot5)
	gohelper.setActive(slot3, true)
	RougeCollectionSlotCellItem.New():onInit(slot3, slot1, slot2, RougeCollectionHelper.ResultReViewCollectionSlotParam)

	slot0._slotCellTab = slot0._slotCellTab or slot0:getUserDataTb_()
	slot0._slotCellTab[slot1] = slot0._slotCellTab[slot1] or slot0:getUserDataTb_()
	slot0._slotCellTab[slot1][slot2] = slot6
end

function slot0.updateSlotCellState(slot0, slot1)
	if not slot1 then
		return
	end

	slot0:revertCoverCells(slot1.id)
	slot0:revertConflictCells()
	slot0:updateSlotCells(slot1)
end

function slot0.updateSlotCells(slot0, slot1)
	slot2 = slot1.id
	slot3 = slot1.cfgId
	slot4 = slot1:getRotation()
	slot5 = slot1:getCenterSlotPos()
	slot7 = RougeCollectionConfig.instance:getRotateEditorParam(slot3, slot4, RougeEnum.CollectionEditorParamType.Effect)
	slot8 = RougeCollectionConfig.instance:getOrBuildCollectionShapeMap(slot3, slot4)

	if not RougeCollectionConfig.instance:getRotateEditorParam(slot3, slot4, RougeEnum.CollectionEditorParamType.Shape) then
		return
	end

	slot9 = false

	for slot13, slot14 in ipairs(slot6) do
		slot15 = RougeCollectionHelper.getCollectionCellSlotPos(slot5, slot14)
		slot17 = RougeCollectionModel.instance:getSlotFilledCollectionId(slot15.x, slot15.y)

		if slot0:getCollectionSlotCell(slot15.x, slot15.y) and slot17 > 0 and slot17 ~= slot2 then
			slot0._conflictIds[slot17] = true
			slot9 = true
		end
	end

	if slot9 then
		slot0:refreshConflictCells(slot3)

		return
	end

	slot15 = true

	for slot15, slot16 in ipairs(slot6) do
		slot17 = RougeCollectionHelper.getCollectionCellSlotPos(slot5, slot16)

		if slot0:getCollectionSlotCell(slot17.x, slot17.y) then
			if RougeCollectionHelper.checkIsCollectionSlotArea(slot3, slot1:getLeftTopPos(), slot4, slot15) then
				slot18:updateCellState(RougeEnum.LineState.Red)
				slot18:hideInsideLines(RougeCollectionHelper.getSlotCellInsideLine(slot8, slot16))
			else
				slot18:onCoverCollection(slot2, slot19)
			end

			slot0._coverCells[slot2] = slot0._coverCells[slot2] or {}

			table.insert(slot0._coverCells[slot2], slot18)
		end
	end

	for slot15, slot16 in ipairs(slot7) do
		slot17 = RougeCollectionHelper.getCollectionCellSlotPos(slot5, slot16)

		if slot0:getCollectionSlotCell(slot17.x, slot17.y) then
			slot18:updateCellState(RougeEnum.LineState.Blue)

			slot0._coverCells[slot2] = slot0._coverCells[slot2] or {}

			table.insert(slot0._coverCells[slot2], slot18)
		end
	end
end

function slot0.foreachCollectionCells(slot0, slot1, slot2, slot3)
	if not slot1 or not slot2 or not slot3 then
		return
	end

	if RougeCollectionConfig.instance:getShapeMatrix(slot1.cfgId, slot1:getRotation()) then
		for slot10, slot11 in ipairs(slot6) do
			for slot15, slot16 in ipairs(slot11) do
				if slot16 and slot16 > 0 then
					slot2(slot3, slot1, slot6, slot10, slot15)
				end
			end
		end
	end
end

function slot0.onCoverCellCallBack(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot1:getLeftTopPos()

	if slot0:getCollectionSlotCell(slot5.y + slot4 - 1, slot5.x + slot3 - 1) then
		slot10 = slot1.id

		slot8:onCoverCollection(slot10, slot0:getSlotCellInsideLine(slot2, slot4, slot3))

		slot0._coverCells[slot10] = slot0._coverCells[slot10] or {}

		table.insert(slot0._coverCells[slot10], slot8)
	end
end

function slot0.getSlotCellInsideLine(slot0, slot1, slot2, slot3)
	if slot0:isCellExist(slot1, slot2, slot3 - 1) then
		table.insert({}, RougeEnum.SlotCellDirection.Top)
	end

	if slot0:isCellExist(slot1, slot2, slot3 + 1) then
		table.insert(slot4, RougeEnum.SlotCellDirection.Bottom)
	end

	if slot0:isCellExist(slot1, slot2 - 1, slot3) then
		table.insert(slot4, RougeEnum.SlotCellDirection.Left)
	end

	if slot0:isCellExist(slot1, slot2 + 1, slot3) then
		table.insert(slot4, RougeEnum.SlotCellDirection.Right)
	end

	return slot4
end

function slot0.isCellExist(slot0, slot1, slot2, slot3)
	return slot1[slot2] and slot1[slot2][slot3] and slot1[slot2][slot3] > 0
end

function slot0.refreshConflictCells(slot0, slot1)
	slot4 = RougeCollectionConfig.instance:getCollectionCfg(slot1) and slot2.type == RougeEnum.CollectionType.Enchant and RougeEnum.LineState.Green or RougeEnum.LineState.Red

	for slot8, slot9 in pairs(slot0._conflictIds) do
		if slot0._coverCells and slot0._coverCells[slot8] then
			slot10 = false

			for slot14, slot15 in ipairs(slot0._coverCells[slot8]) do
				slot16, slot17 = slot15:getSlotCellPosition()

				slot15:updateCellState(slot3 and ((RougeCollectionConfig.instance:getCollectionCfg(RougeCollectionModel.instance:getCollectionByUid(slot8) and slot11.cfgId) and slot13.holeNum or 0) > 0 and RougeEnum.LineState.Green or RougeEnum.LineState.Red) or RougeEnum.LineState.Red)
				slot15:hideInsideLines(slot0:getInsideLines(slot16, slot17, slot8))
			end

			if slot10 then
				break
			end
		end
	end
end

function slot0.getInsideLines(slot0, slot1, slot2, slot3)
	slot4 = Vector2(slot1, slot2)
	slot5 = slot4 - Vector2(0, 1)
	slot6 = slot4 + Vector2(0, 1)
	slot7 = slot4 - Vector2(1, 0)
	slot8 = slot4 + Vector2(1, 0)

	if RougeCollectionModel.instance:getSlotFilledCollectionId(slot5.x, slot5.y) == slot3 then
		table.insert({}, RougeEnum.SlotCellDirection.Top)
	end

	if RougeCollectionModel.instance:getSlotFilledCollectionId(slot6.x, slot6.y) == slot3 then
		table.insert(slot9, RougeEnum.SlotCellDirection.Bottom)
	end

	if RougeCollectionModel.instance:getSlotFilledCollectionId(slot7.x, slot7.y) == slot3 then
		table.insert(slot9, RougeEnum.SlotCellDirection.Left)
	end

	if RougeCollectionModel.instance:getSlotFilledCollectionId(slot8.x, slot8.y) == slot3 then
		table.insert(slot9, RougeEnum.SlotCellDirection.Right)
	end

	return slot9
end

function slot0.placeCollection2SlotAreaSucc(slot0, slot1)
	if not slot1 then
		return
	end

	if slot0._placeCollectionMap[slot1 and slot1.id] then
		slot0._placeCollectionMap[slot2] = nil
	end

	slot3 = slot1:getRotation()
	slot10 = RougeEnum.CollectionEditorParamType.Shape

	slot0:revertCoverCells(slot1.id)

	for slot10, slot11 in ipairs(RougeCollectionConfig.instance:getRotateEditorParam(slot1.cfgId, slot3, slot10)) do
		slot12 = RougeCollectionHelper.getCollectionCellSlotPos(slot1:getCenterSlotPos(), slot11)

		if slot0:getCollectionSlotCell(slot12.x, slot12.y) then
			slot13:onPlaceCollection(RougeCollectionHelper.getSlotCellInsideLine(RougeCollectionConfig.instance:getOrBuildCollectionShapeMap(slot1.cfgId, slot3), slot11))

			slot0._placeCollectionMap[slot2] = slot0._placeCollectionMap[slot2] or {}
			slot0._coverCells[slot2] = slot0._coverCells[slot2] or {}

			table.insert(slot0._placeCollectionMap[slot2], slot12)
			table.insert(slot0._coverCells[slot2], slot13)
		end
	end
end

function slot0.placeCollection2SlotAreaFailed(slot0, slot1, slot2)
	slot0:revertCoverCells(slot1)
	slot0:revertConflictCells()

	if RougeCollectionModel.instance:isCollectionPlaceInSlotArea(slot1) and not slot2 then
		slot0:placeCollection2SlotAreaSucc(RougeCollectionModel.instance:getCollectionByUid(slot1))
	end
end

function slot0.revertCoverCells(slot0, slot1)
	if slot0._coverCells and slot0._coverCells[slot1] then
		for slot6, slot7 in pairs(slot2) do
			slot7:revertCellState(slot1)
		end

		slot0._coverCells[slot1] = {}
	end
end

function slot0.revertConflictCells(slot0)
	if slot0._conflictIds then
		for slot4, slot5 in pairs(slot0._conflictIds) do
			if slot0._coverCells and slot0._coverCells[slot4] then
				for slot10, slot11 in pairs(slot6) do
					slot11:revertCellState()
				end
			end
		end

		slot0._conflictIds = {}
	end
end

function slot0.deleteSlotCollection(slot0, slot1)
	if slot0._coverCells and slot0._coverCells[slot1] then
		for slot6, slot7 in ipairs(slot2) do
			slot7:revertCellState()
		end

		slot2[slot1] = nil
	end

	slot0:revertConflictCells()
end

function slot0.updateCollectionEnchant(slot0, slot1)
	if not RougeCollectionModel.instance:getCollectionByUid(slot1) then
		return
	end

	if not slot2:getAllEnchantId() then
		return
	end

	for slot7, slot8 in pairs(slot3) do
		if slot0._coverCells and slot0._coverCells[slot8] then
			for slot13, slot14 in pairs(slot9) do
				slot14:updateCellState(RougeEnum.LineState.Grey)
			end

			slot0._coverCells[slot8] = nil
		end
	end
end

function slot0.onNullSpace2PlaceCollection(slot0, slot1)
	slot0:updateSlotCellState(slot1)
end

function slot0.disposeAllSlotCells(slot0)
	if slot0._slotCellTab then
		for slot4, slot5 in pairs(slot0._slotCellTab) do
			for slot9, slot10 in pairs(slot5) do
				slot10:destroy()
			end
		end

		slot0._slotCellTab = nil
	end

	slot0._coverCells = nil
end

function slot0.onClose(slot0)
	slot0:disposeAllSlotCells()
end

function slot0.onDestroyView(slot0)
end

return slot0
