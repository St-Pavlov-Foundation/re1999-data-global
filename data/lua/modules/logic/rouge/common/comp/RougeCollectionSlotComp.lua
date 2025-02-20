module("modules.logic.rouge.common.comp.RougeCollectionSlotComp", package.seeall)

slot0 = class("RougeCollectionSlotComp", UserDataDispose)

function slot0.Get(slot0, slot1)
	slot2 = uv0.New()

	slot2:init(slot0, slot1 or RougeCollectionHelper.DefaultSlotParam)

	return slot2
end

function slot0.init(slot0, slot1, slot2)
	slot0:__onInit()

	slot0.params = slot2
	slot0._slotItemLoader = PrefabInstantiate.Create(slot1)

	slot0._slotItemLoader:startLoad(RougeEnum.ResPath.CommonCollectionSlotItem, slot0._onCollectionSlotLoaded, slot0)
end

function slot0._onCollectionSlotLoaded(slot0)
	slot0.viewGO = slot0._slotItemLoader:getInstGO()

	slot0:_editableInitView()
	slot0:checkIsNeedUpdate()
end

function slot0._editableInitView(slot0)
	slot0._gomeshcontainer = gohelper.findChild(slot0.viewGO, "#go_meshcontainer")
	slot0._gomeshItem = gohelper.findChild(slot0.viewGO, "#go_meshcontainer/#go_meshItem")
	slot0._goplacecontainer = gohelper.findChild(slot0.viewGO, "#go_placecontainer")
	slot0._gochessitem = gohelper.findChild(slot0.viewGO, "#go_placecontainer/#go_chessitem")
	slot0._goeffect = gohelper.findChild(slot0.viewGO, "#go_meshcontainer/#effect")
	slot0._coverCells = slot0:getUserDataTb_()
	slot0._collectionItemMap = slot0:getUserDataTb_()
	slot0._placeCollectionMap = {}

	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.PlaceCollection2SlotArea, slot0.placeCollection2SlotArea, slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.DeleteSlotCollection, slot0.deleteSlotCollection, slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.GetNewCollections, slot0._onGetNewCollections, slot0)
	slot0:initCellPrefabItem()

	slot0._slotCellTab = slot0:getUserDataTb_()
end

function slot0.initCellPrefabItem(slot0)
	if not slot0.params then
		return
	end

	slot0._cellWidth = slot0.params.cellWidth
	slot0._cellHeight = slot0.params.cellHeight

	recthelper.setSize(slot0._gochessitem.transform, slot0._cellWidth, slot0._cellHeight)

	slot0._gridlayout = slot0._gomeshcontainer:GetComponent(gohelper.Type_GridLayoutGroup)
	slot0._gridlayout.cellSize = Vector2(slot0._cellWidth, slot0._cellHeight)

	recthelper.setSize(slot0._goplacecontainer.transform, slot0._cellWidth, slot0._cellHeight)
end

function slot0.checkIsNeedUpdate(slot0)
	if slot0._isDirty then
		slot0:start2InitSlot()
	end
end

function slot0.onUpdateMO(slot0, slot1, slot2, slot3)
	if not slot1 or slot1 <= 0 or not slot2 or slot2 <= 0 then
		logError(string.format("初始化肉鸽棋盘失败,失败原因:棋盘宽或高不可小于或等于0, col = %s, row = %s", slot1, slot2))

		return
	end

	slot0._placeCollectionMOs = slot3
	slot0._col = slot1
	slot0._row = slot2

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

	recthelper.setAnchor(slot0._goplacecontainer.transform, -(slot0._row / 2 - 0.5) * slot0._cellHeight, (slot0._col / 2 - 0.5) * slot0._cellWidth)
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
		slot0.params.cls.New():onInit(slot4, slot1, slot2, slot0.params)

		slot0._slotCellTab = slot0._slotCellTab or slot0:getUserDataTb_()
		slot0._slotCellTab[slot1] = slot0._slotCellTab[slot1] or slot0:getUserDataTb_()
		slot0._slotCellTab[slot1][slot2] = slot3
	end

	slot3:initSlotCellLines()
end

slot0.PlayEffectDuration = 0.5

function slot0.placeCollection2SlotArea(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	if slot0._placeCollectionMap[slot1 and slot1.id] then
		slot0._placeCollectionMap[slot3] = nil
	end

	slot4 = slot1:getRotation()
	slot6 = slot1:getCenterSlotPos()
	slot12 = RougeEnum.CollectionEditorParamType.Shape
	slot11 = slot1.id

	slot0:revertCoverCells(slot11)

	for slot11, slot12 in ipairs(RougeCollectionConfig.instance:getRotateEditorParam(slot1.cfgId, slot4, slot12)) do
		slot13 = Vector2(slot12.x + slot6.x, slot6.y - slot12.y)

		if slot0:getCollectionSlotCell(slot13.x, slot13.y) then
			slot14:onPlaceCollection(RougeCollectionHelper.getSlotCellInsideLine(RougeCollectionConfig.instance:getOrBuildCollectionShapeMap(slot1.cfgId, slot4), slot12))

			slot0._placeCollectionMap[slot3] = slot0._placeCollectionMap[slot3] or {}
			slot0._coverCells[slot3] = slot0._coverCells[slot3] or {}

			table.insert(slot0._placeCollectionMap[slot3], slot13)
			table.insert(slot0._coverCells[slot3], slot14)
		end
	end

	if slot0.params and slot0.params.showIcon then
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

function slot0._onGetNewCollections(slot0, slot1, slot2, slot3)
	if not slot1 or not slot2 then
		return
	end

	if slot3 == RougeEnum.CollectionPlaceArea.SlotArea then
		for slot7, slot8 in ipairs(slot1) do
			RougeCollectionHelper.foreachCollectionCells(RougeCollectionModel.instance:getCollectionByUid(slot8), slot0._playEffectAfterGetNewSlotCollection, slot0)
		end
	end

	slot0:showGetCollectionEffect()
	AudioMgr.instance:trigger(AudioEnum.UI.CollectionChange)
end

function slot0._playEffectAfterGetNewSlotCollection(slot0, slot1, slot2, slot3)
	slot4 = slot1:getLeftTopPos()

	if slot0:getCollectionSlotCell(slot4.x + slot3 - 1, slot4.y + slot2 - 1) then
		slot7:playGetCollectionEffect()
	end
end

function slot0.showGetCollectionEffect(slot0)
	if slot0._isPlayingEffect then
		return
	end

	TaskDispatcher.cancelTask(slot0._delay2HideEffect, slot0)
	TaskDispatcher.runDelay(slot0._delay2HideEffect, slot0, uv0.PlayEffectDuration)
	gohelper.setActive(slot0._goeffect, true)

	slot0._isPlayingEffect = true
end

function slot0._delay2HideEffect(slot0)
	gohelper.setActive(slot0._goeffect, false)

	slot0._isPlayingEffect = false
end

function slot0.revertCoverCells(slot0, slot1)
	if slot0._coverCells and slot0._coverCells[slot1] then
		for slot6, slot7 in pairs(slot2) do
			slot7:updateCellState(RougeEnum.LineState.Normal)
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

	TaskDispatcher.cancelTask(slot0._delay2HideEffect, slot0)
	slot0:__onDispose()
end

return slot0
