module("modules.logic.rouge.common.comp.RougeCollectionSlotCompParam", package.seeall)

slot0 = pureTable("RougeCollectionSlotCompParam")

function slot0.ctor(slot0)
	slot0.cellWidth = 20
	slot0.cellHeight = 20
	slot0.isNeedShowIcon = false
	slot0.cellLineNameMap = {
		[RougeEnum.LineState.Grey] = "rouge_bagline_yellow",
		[RougeEnum.LineState.Green] = "rouge_bagline_green"
	}
	slot0.cls = RougeCollectionCompCellItem
end

function slot0.getLine(slot0, slot1)
	return slot0.cellLineNameMap and slot0.cellLineNameMap[slot1]
end

return slot0
