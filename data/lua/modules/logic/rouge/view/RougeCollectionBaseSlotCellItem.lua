module("modules.logic.rouge.view.RougeCollectionBaseSlotCellItem", package.seeall)

slot0 = class("RougeCollectionBaseSlotCellItem", UserDataDispose)

function slot0.onInit(slot0, slot1, slot2, slot3, slot4)
	slot0:__onInit()
	slot0:_onInitView(slot1, slot2, slot3, slot4)
	slot0:_editableInitView()
end

function slot0._onInitView(slot0, slot1, slot2, slot3, slot4)
	slot0.viewGO = slot1
	slot0._cellPosX = slot2
	slot0._cellPosY = slot3
	slot0._curLineState = RougeEnum.LineState.Grey
	slot0._curInsideLines = nil
	slot0._cellLineNameMap = slot4.cellLineNameMap
	slot0._cellWidth = slot4.cellWidth
	slot0._cellHeight = slot4.cellHeight
end

function slot0._editableInitView(slot0)
	slot0:buildLineTranMap()
	slot0:initSlotCellLines()
end

slot1 = {
	[RougeEnum.SlotCellDirection.Top] = "top",
	[RougeEnum.SlotCellDirection.Bottom] = "bottom",
	[RougeEnum.SlotCellDirection.Left] = "left",
	[RougeEnum.SlotCellDirection.Right] = "right"
}

function slot0.buildLineTranMap(slot0)
	slot0._directionTranMap = slot0:getUserDataTb_()

	for slot4, slot5 in pairs(RougeEnum.SlotCellDirection) do
		slot0:buildSingleLineTranMap(slot5, slot0._directionTranMap)
	end
end

slot2 = 2

function slot0.buildSingleLineTranMap(slot0, slot1, slot2)
	if slot1 and slot2 then
		slot4 = gohelper.findChildImage(slot0.viewGO, uv0[slot1])
		slot2[slot1] = slot4

		recthelper.setSize(slot4.transform, slot0._cellWidth, uv1)
	end
end

function slot0.initSlotCellLines(slot0)
	slot1, slot2 = slot0:chechCellHasPlace()
	slot3 = nil
	slot4 = RougeEnum.LineState.Grey

	if slot1 then
		slot3 = slot0:getInsideLines(slot2)
		slot4 = RougeEnum.LineState.Green
	end

	slot0:updateCellState(slot4)
	slot0:hideInsideLines(slot3)
end

function slot0.chechCellHasPlace(slot0)
	return false, nil
end

function slot0.getInsideLines(slot0, slot1)
	slot4 = RougeCollectionModel.instance:getSlotFilledCollectionId(slot0._cellPosX - 1, slot0._cellPosY)
	slot5 = RougeCollectionModel.instance:getSlotFilledCollectionId(slot0._cellPosX, slot0._cellPosY - 1)
	slot6 = RougeCollectionModel.instance:getSlotFilledCollectionId(slot0._cellPosX, slot0._cellPosY + 1)

	if RougeCollectionModel.instance:getSlotFilledCollectionId(slot0._cellPosX + 1, slot0._cellPosY) == slot1 then
		table.insert({}, RougeEnum.SlotCellDirection.Right)
	end

	if slot4 == slot1 then
		table.insert(slot2, RougeEnum.SlotCellDirection.Left)
	end

	if slot5 == slot1 then
		table.insert(slot2, RougeEnum.SlotCellDirection.Top)
	end

	if slot6 == slot1 then
		table.insert(slot2, RougeEnum.SlotCellDirection.Bottom)
	end

	return slot2
end

function slot0.onPlaceCollection(slot0, slot1)
	slot0:updateCellState(RougeEnum.LineState.Green)
	slot0:hideInsideLines(slot1)
end

function slot0.revertCellState(slot0, slot1)
	if RougeCollectionModel.instance:getSlotFilledCollectionId(slot0._cellPosX, slot0._cellPosY) and slot1 and slot2 == slot1 then
		slot0:updateCellState()

		return
	end

	slot0:initSlotCellLines()
end

function slot0.hideInsideLines(slot0, slot1)
	if slot1 then
		for slot5, slot6 in pairs(slot1) do
			gohelper.setActive(slot0._directionTranMap[slot6].gameObject, false)
		end
	end
end

function slot0.updateCellState(slot0, slot1)
	slot0._curCellState = slot1 or RougeEnum.LineState.Grey

	slot0:updateAllCellLine(slot0._curCellState)
end

function slot0.updateAllCellLine(slot0, slot1)
	if slot0._directionTranMap then
		for slot5, slot6 in pairs(slot0._directionTranMap) do
			gohelper.setActive(slot6.transform, true)
			UISpriteSetMgr.instance:setRougeSprite(slot6, slot0._cellLineNameMap and slot0._cellLineNameMap[slot1])
		end
	end
end

function slot0.getSlotCellPosition(slot0)
	return slot0._cellPosX, slot0._cellPosY
end

function slot0.setItemVisible(slot0, slot1)
	gohelper.setActive(slot0.viewGO, slot1)
end

function slot0.destroy(slot0)
	slot0:__onDispose()
end

return slot0
