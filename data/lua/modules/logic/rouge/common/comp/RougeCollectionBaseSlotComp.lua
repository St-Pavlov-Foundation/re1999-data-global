module("modules.logic.rouge.common.comp.RougeCollectionBaseSlotComp", package.seeall)

slot0 = class("RougeCollectionBaseSlotComp", UserDataDispose)

function slot0.Get(slot0, slot1)
	slot2 = uv0.New()

	slot2:init(slot0, slot1)

	return slot2
end

function slot0.init(slot0, slot1, slot2)
	slot0:__onInit()
	slot0:initBaseInfo(slot2)

	slot0.viewGO = slot1

	slot0:_onCollectionSlotLoaded()
end

function slot0.initBaseInfo(slot0, slot1)
	slot0._isDirty = false
	slot0._isShowIcon = slot1
end

function slot0._onCollectionSlotLoaded(slot0)
	slot0:_editableInitView()
	slot0:checkIsNeedUpdate()
end

function slot0._editableInitView(slot0)
	slot0._gomeshcontainer = gohelper.findChild(slot0.viewGO, "#go_meshcontainer")
	slot0._gomeshItem = gohelper.findChild(slot0.viewGO, "#go_meshcontainer/#go_meshItem")
	slot0._goplacecontainer = gohelper.findChild(slot0.viewGO, "#go_placecontainer")
	slot0._gochessitem = gohelper.findChild(slot0.viewGO, "#go_placecontainer/#go_chessitem")
	slot0._gridlayout = slot0._gomeshcontainer:GetComponent(gohelper.Type_GridLayoutGroup)
	slot0._coverCells = slot0:getUserDataTb_()
	slot0._collectionItemMap = slot0:getUserDataTb_()
	slot0._placeCollectionMap = {}

	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.PlaceCollection2SlotArea, slot0.placeCollection2SlotArea, slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.DeleteSlotCollection, slot0.deleteSlotCollection, slot0)

	slot0._cellWidth = recthelper.getWidth(slot0._gochessitem.transform)
	slot0._cellHeight = recthelper.getHeight(slot0._gochessitem.transform)
	slot0._slotCellTab = slot0:getUserDataTb_()
end

function slot0.checkIsNeedUpdate(slot0)
	if slot0._isDirty then
		slot0:initCollectionSlot()
		slot0:initPlaceCollections()

		slot0._isDirty = false
	end
end

function slot0.onUpdateMO(slot0, slot1, slot2, slot3)
	if not slot1 or slot1 <= 0 or not slot2 or slot2 <= 0 then
		logError(string.format("初始化肉鸽棋盘失败,失败原因:棋盘宽或高不可小于或等于0, col = %s, row = %s", slot1, slot2))

		return
	end

	slot0._col = slot1
	slot0._row = slot2
	slot0._placeCollectionMOs = slot3

	slot0:start2InitSlot()
end

function slot0.start2InitSlot(slot0)
	if gohelper.isNil(slot0.viewGO) then
		slot0._isDirty = true

		return
	end

	slot0:initCollectionSlot()
	slot0:initPlaceCollections()

	slot0._isDirty = false
end

function slot0.initCollectionSlot(slot0)
	slot0._gridlayout.constraintCount = slot0._col

	for slot4 = 0, slot0._row - 1 do
		for slot8 = 0, slot0._col - 1 do
			slot0:createCollectionSlotCell(slot8, slot4)
		end
	end

	for slot4, slot5 in pairs(slot0._slotCellTab) do
		for slot9, slot10 in pairs(slot5) do
			slot10:setItemVisible(slot4 >= 0 and slot4 < slot0._col and slot9 >= 0 and slot9 < slot0._row)
		end
	end
end

function slot0.initPlaceCollections(slot0)
	if slot0._placeCollectionMOs then
		for slot4, slot5 in ipairs(slot0._placeCollectionMOs) do
			slot0:placeCollection2SlotArea(slot5)
		end
	end
end

function slot0.getCollectionSlotCell(slot0, slot1, slot2)
	return slot0._slotCellTab and slot0._slotCellTab[slot1] and slot0._slotCellTab[slot1][slot2]
end

function slot0.createCollectionSlotCell(slot0, slot1, slot2)
	if not (slot0._slotCellTab[slot1] and slot0._slotCellTab[slot1][slot2]) then
		slot4 = gohelper.cloneInPlace(slot0._gomeshItem, string.format("%s_%s", slot1, slot2))

		gohelper.setActive(slot4, true)

		slot0._slotCellTab = slot0._slotCellTab or slot0:getUserDataTb_()
		slot0._slotCellTab[slot1] = slot0._slotCellTab[slot1] or slot0:getUserDataTb_()
		slot0._slotCellTab[slot1][slot2] = RougeCollectionSlotCellItem.New(slot4, slot1, slot2)
	end
end

function slot0.placeCollection2SlotArea(slot0, slot1)
	if not slot1 then
		return
	end

	if slot0._placeCollectionMap[slot1 and slot1.id] then
		slot0._placeCollectionMap[slot2] = nil
	end

	slot3 = slot1:getRotation()
	slot5 = slot1:getCenterSlotPos()
	slot10 = RougeEnum.CollectionEditorParamType.Shape

	slot0:revertCoverCells(slot1.id)

	for slot10, slot11 in ipairs(RougeCollectionConfig.instance:getRotateEditorParam(slot1.cfgId, slot3, slot10)) do
		slot12 = Vector2(slot11.x + slot5.x, slot5.y - slot11.y)

		if slot0:getCollectionSlotCell(slot12.x, slot12.y) then
			slot13:updateCellState(RougeEnum.LineState.Green)
			slot13:hideInsideLines(RougeCollectionHelper.getSlotCellInsideLine(RougeCollectionConfig.instance:getOrBuildCollectionShapeMap(slot1.cfgId, slot3), slot11))

			slot0._placeCollectionMap[slot2] = slot0._placeCollectionMap[slot2] or {}
			slot0._coverCells[slot2] = slot0._coverCells[slot2] or {}

			table.insert(slot0._placeCollectionMap[slot2], slot12)
			table.insert(slot0._coverCells[slot2], slot13)
		end
	end

	if slot0._isShowIcon then
		slot0:showCollectionIcon(slot1)
	end
end

function slot0.showCollectionIcon(slot0, slot1)
	if not slot1 then
		return
	end

	slot0:getOrCreateCollectionItem(slot1.id):onUpdateMO(slot1)
end

function slot0.getOrCreateCollectionItem(slot0, slot1)
	if not slot0._collectionItemMap[slot1] then
		slot2 = RougeCollectionBaseSlotItem.New()

		slot2:onInit(gohelper.cloneInPlace(slot0._gochessitem, "item_" .. tostring(slot1)))
		slot2:setPerCellWidthAndHeight(slot0._cellWidth, slot0._cellHeight)

		slot0._collectionItemMap[slot1] = slot2
	end

	return slot2
end

function slot0.deleteSlotCollection(slot0, slot1)
	if slot0._coverCells and slot0._coverCells[slot1] then
		for slot6, slot7 in ipairs(slot2) do
			slot7:revertCellState()
		end

		slot2[slot1] = nil
	end
end

function slot0.revertCoverCells(slot0, slot1)
	if slot0._coverCells and slot0._coverCells[slot1] then
		for slot6, slot7 in pairs(slot2) do
			slot7:updateCellState(RougeEnum.LineState.Grey)
		end

		slot0._coverCells[slot1] = {}
	end
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

function slot0.disposeAllCollections(slot0)
	if slot0._collectionItemMap then
		for slot4, slot5 in pairs(slot0._collectionItemMap) do
			slot5:destroy()
		end
	end
end

function slot0.destroy(slot0)
	slot0:disposeAllSlotCells()

	if slot0._slotItemLoader then
		slot0._slotItemLoader:onDestroy()

		slot0._slotItemLoader = nil
	end
end

return slot0
