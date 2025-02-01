module("modules.logic.rouge.view.RougeCollectionSizeBagItem", package.seeall)

slot0 = class("RougeCollectionSizeBagItem", RougeCollectionBaseSlotItem)

function slot0.onInit(slot0, slot1)
	uv0.super.onInit(slot0, slot1)

	slot0._gomodelcontainer = gohelper.findChild(slot0.viewGO, "go_center/go_modelcontainer")
	slot0._gocell = gohelper.findChild(slot0.viewGO, "go_center/go_modelcontainer/go_cell")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)
	slot0:addClickListener()
	slot0:addDragListeners()

	slot0._edgeTab = slot0:getUserDataTb_()

	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.SelectCollection, slot0._selectCollection, slot0)
end

function slot0.addClickListener(slot0)
	slot0._btnclick = gohelper.getClick(slot0.viewGO)

	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.addDragListeners(slot0)
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0.viewGO)

	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragListener(slot0._onDrag, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
end

function slot0.releaseAllListeners(slot0)
	if slot0._drag then
		slot0._drag:RemoveDragBeginListener()
		slot0._drag:RemoveDragEndListener()
		slot0._drag:RemoveDragListener()

		slot0._drag = nil
	end

	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	if not slot0._mo then
		return
	end

	RougeController.instance:openRougeCollectionTipView({
		useCloseBtn = false,
		collectionId = slot0._mo.id,
		viewPosition = RougeEnum.CollectionTipPos.Bag,
		source = RougeEnum.OpenCollectionTipSource.BagArea
	})
	RougeCollectionChessController.instance:selectCollection(slot0._mo.id)
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot3 = RougeCollectionHelper.isCanDragCollection()
	slot0._isDraging = slot3

	if not slot3 then
		return
	end

	slot0:setCanvasGroupVisible(false)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.OnBeginDragCollection, slot0._mo, slot2)
end

function slot0._onDrag(slot0, slot1, slot2)
	if not slot0._isDraging then
		return
	end

	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.OnDragCollection, slot2)
end

function slot0._onDragEnd(slot0, slot1, slot2)
	if not slot0._isDraging then
		return
	end

	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.OnEndDragCollection, slot2)

	slot0._isDraging = false
end

function slot0.onUpdateMO(slot0, slot1)
	uv0.super.onUpdateMO(slot0, slot1)
	slot0:setShapeCellsVisible(true)
end

function slot0.onUpdateRotateAngle(slot0)
	uv0.super.onUpdateRotateAngle(slot0)
	slot0:refreshShapeGrids()
end

function slot0.refreshShapeGrids(slot0)
	gohelper.CreateObjList(slot0, slot0.refreshSlotCell, RougeCollectionConfig.instance:getRotateEditorParam(slot0._mo.cfgId, slot0._mo:getRotation(), RougeEnum.CollectionEditorParamType.Shape) or {}, slot0._gomodelcontainer, slot0._gocell)
end

function slot0.refreshSlotCell(slot0, slot1, slot2, slot3)
	slot0:setCellAnchor(slot1, slot2)
	slot0:setCellIconImage(slot1)
	slot0:checkAndPlaceAroundLine(slot1, slot2)
end

function slot0.checkAndPlaceAroundLine(slot0, slot1, slot2)
	slot5 = gohelper.findChild(slot1, "go_edge")

	gohelper.setActive(gohelper.findChild(slot1, "go_edge/go_left"), true)
	gohelper.setActive(gohelper.findChild(slot1, "go_edge/go_right"), true)
	gohelper.setActive(gohelper.findChild(slot1, "go_edge/go_bottom"), true)
	gohelper.setActive(gohelper.findChild(slot1, "go_edge/go_top"), true)

	if RougeCollectionHelper.getSlotCellInsideLine(RougeCollectionConfig.instance:getOrBuildCollectionShapeMap(slot0._mo.cfgId, slot0._mo:getRotation()), slot2) then
		for slot13, slot14 in pairs(slot4) do
			if slot14 == RougeEnum.SlotCellDirection.Left then
				gohelper.setActive(slot6, false)
			elseif slot14 == RougeEnum.SlotCellDirection.Right then
				gohelper.setActive(slot7, false)
			elseif slot14 == RougeEnum.SlotCellDirection.Bottom then
				gohelper.setActive(slot8, false)
			elseif slot14 == RougeEnum.SlotCellDirection.Top then
				gohelper.setActive(slot9, false)
			end
		end
	end

	if not slot0._edgeTab[slot5] then
		slot0._edgeTab[slot5] = true
	end
end

function slot0.setCellAnchor(slot0, slot1, slot2)
	slot5 = slot2 - RougeCollectionHelper.getCollectionTopLeftPos(slot0._mo.cfgId, slot0._mo:getRotation())

	recthelper.setAnchor(slot1.transform, slot5.x * slot0._perCellWidth, slot5.y * slot0._perCellHeight)
end

function slot0.setCellIconImage(slot0, slot1)
	UISpriteSetMgr.instance:setRougeSprite(gohelper.findChildImage(slot1, "icon"), "rouge_collection_grid_big_" .. tostring(slot0._collectionCfg and slot0._collectionCfg.showRare))
	recthelper.setSize(slot1.transform, slot0._perCellWidth, slot0._perCellHeight)
end

function slot0._selectCollection(slot0)
	slot0:setSelectFrameVisible(RougeCollectionBagListModel.instance:isCollectionSelect(slot0._mo and slot0._mo.id))
end

function slot0.setSelectFrameVisible(slot0, slot1)
	if slot0._edgeTab then
		for slot5, slot6 in pairs(slot0._edgeTab) do
			gohelper.setActive(slot5, slot1)
		end
	end
end

function slot0.reset(slot0)
	uv0.super.reset(slot0)
	slot0:setSelectFrameVisible(false)

	slot0._isDraging = false
end

function slot0.setShapeCellsVisible(slot0, slot1)
	gohelper.setActive(slot0._gomodelcontainer, slot1)
end

function slot0.destroy(slot0)
	slot0:releaseAllListeners()
	uv0.super.destroy(slot0)
end

return slot0
