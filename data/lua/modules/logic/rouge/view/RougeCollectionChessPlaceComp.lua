module("modules.logic.rouge.view.RougeCollectionChessPlaceComp", package.seeall)

slot0 = class("RougeCollectionChessPlaceComp", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclosetipArea = gohelper.findChildButtonWithAudio(slot0.viewGO, "bg/#btn_closetipArea")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._gochessContainer = gohelper.findChild(slot0.viewGO, "chessboard/#go_chessContainer")
	slot0._gomeshContainer = gohelper.findChild(slot0.viewGO, "chessboard/#go_meshContainer")
	slot0._gomeshItem = gohelper.findChild(slot0.viewGO, "chessboard/#go_meshContainer/#go_meshItem")
	slot0._godragContainer = gohelper.findChild(slot0.viewGO, "chessboard/#go_dragContainer")
	slot0._gocellModel = gohelper.findChild(slot0.viewGO, "chessboard/#go_cellModel")
	slot0._gochessitem = gohelper.findChild(slot0.viewGO, "chessboard/#go_dragAnchor/#go_dragContainer/#go_chessitem")
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
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.Start2CheckAndPlace, slot0.try2PlaceCollection, slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.PlaceCollection2SlotArea, slot0.placeCollection2SlotAreaWithAudio, slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.OnBeginDragCollection, slot0._onBeginDragCollection, slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.DeleteSlotCollection, slot0.deleteSlotCollection, slot0)
	slot0:addEventCb(RougeCollectionEnchantController.instance, RougeEvent.UpdateCollectionEnchant, slot0.updateEnchantInfo, slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.Failed2PlaceSlotCollection, slot0.placeCollection2OriginPos, slot0)

	slot0._poolComp = slot0.viewContainer:getRougePoolComp()
	slot0._placeCollectionMap = slot0:getUserDataTb_()
	slot0._placeHoleIndexMap = {}
end

function slot0.onOpen(slot0)
	slot0:placeAllBagCollections()
end

function slot0.onUpdateParam(slot0)
end

function slot0.placeAllBagCollections(slot0)
	if RougeCollectionModel.instance:getSlotAreaCollection() then
		for slot5, slot6 in ipairs(slot1) do
			slot0:placeCollection2SlotArea(slot6)
		end
	end
end

function slot0.placeCollection2SlotAreaWithAudio(slot0, slot1)
	slot0:placeCollection2SlotArea(slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.PlaceSlotCollection)
end

function slot0.placeCollection2SlotArea(slot0, slot1)
	if not slot1 then
		return
	end

	slot0:revertErrorCollection(slot1.id)

	slot2 = slot0:getOrCreateCollectionItem(slot1.id)

	slot2:onUpdateMO(slot1)
	slot2:setHoleToolVisible(true)
	slot2:setShowTypeFlagVisible(true)
	slot2:setParent(slot0._gocellModel.transform, false)
end

function slot0.getOrCreateCollectionItem(slot0, slot1)
	if not slot0._placeCollectionMap[slot1] then
		slot0._placeCollectionMap[slot1] = slot0._poolComp:getCollectionItem(RougeCollectionDragItem.__cname)
	end

	return slot2
end

function slot0._onBeginDragCollection(slot0, slot1)
	slot2 = slot1 and slot1.id

	slot0:revertErrorCollection(slot2)

	if slot0._placeCollectionMap[slot2] then
		slot3:setItemVisible(false)
	end
end

function slot0.revertErrorCollection(slot0, slot1)
	if slot0._errorItemId and slot0._errorItemId > 0 and slot0._errorItemId ~= slot1 then
		RougeCollectionChessController.instance:dispatchEvent(RougeEvent.Failed2PlaceSlotCollection, slot0._errorItemId)

		slot0._errorItemId = nil
	end
end

function slot0.try2PlaceCollection(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	slot0:revertErrorCollection(slot1.id)

	slot3 = slot1.cfgId
	slot4 = slot1:getCenterSlotPos()
	slot8 = RougeCollectionHelper.isUnremovableCollection(slot3)

	if not RougeCollectionHelper.checkIsCollectionSlotArea(slot3, slot1:getLeftTopPos(), slot1:getRotation()) then
		if slot8 then
			GameFacade.showToast(ToastEnum.RougeUnRemovableCollection, RougeCollectionConfig.instance:getCollectionName(slot3))
			RougeCollectionChessController.instance:dispatchEvent(RougeEvent.Failed2PlaceSlotCollection, slot1.id)
		else
			slot0:removeCollectionFromSlotArea(slot1)
		end

		return
	end

	if RougeCollectionConfig.instance:getCollectionCfg(slot3) and slot9.type == RougeEnum.CollectionType.Enchant and not slot8 and slot0:tryPlaceEnchant2Collection(RougeCollectionModel.instance:getSlotFilledCollectionId(slot4.x, slot4.y), slot1.id) then
		return
	end

	if slot0:checkHasSpace2Place(slot1, slot4, slot5) then
		RougeCollectionChessController.instance:placeCollection2SlotArea(slot1.id, slot6, slot5)
	else
		slot12 = slot0:getOrCreateCollectionItem(slot1.id)

		slot12:onUpdateMO(slot1)
		slot12:setShapeCellsVisible(true)
		slot12:setSelectFrameVisible(true)
		slot12:setParent(slot0._gocellModel.transform, false)

		slot0._errorItemId = slot1.id

		RougeCollectionChessController.instance:dispatchEvent(RougeEvent.NullSpace2PlaceCollection, slot1)
	end
end

function slot0.placeCollection2OriginPos(slot0, slot1, slot2)
	slot4 = RougeCollectionModel.instance:getCollectionByUid(slot1)

	if slot0._placeCollectionMap[slot1] and slot4 then
		if RougeCollectionModel.instance:isCollectionPlaceInSlotArea(slot1) and not slot2 then
			slot3:onUpdateMO(slot4)
			slot3:setShapeCellsVisible(false)
		else
			slot0._poolComp:recycleCollectionItem(RougeCollectionDragItem.__cname, slot3)

			slot0._placeCollectionMap[slot1] = nil
		end
	end
end

function slot0.checkHasSpace2Place(slot0, slot1, slot2, slot3)
	slot4 = true

	if slot1 and RougeCollectionConfig.instance:getRotateEditorParam(slot1:getCollectionCfgId(), slot3, RougeEnum.CollectionEditorParamType.Shape) then
		for slot10, slot11 in ipairs(slot6) do
			slot12 = slot11.x + slot2.x
			slot13 = slot2.y - slot11.y

			if not slot0:isInSlotAreaSize(slot12, slot13) or RougeCollectionModel.instance:getSlotFilledCollectionId(slot12, slot13) and slot15 > 0 and slot15 ~= slot1.id then
				slot4 = false

				break
			end
		end
	end

	return slot4
end

function slot0.isInSlotAreaSize(slot0, slot1, slot2)
	slot3 = RougeCollectionModel.instance:getCurSlotAreaSize()

	if slot1 >= 0 and slot1 < slot3.row and slot2 >= 0 and slot2 < slot3.col then
		return true
	end
end

function slot0.removeCollectionFromSlotArea(slot0, slot1)
	if not slot1 then
		return
	end

	if RougeCollectionModel.instance:isCollectionPlaceInSlotArea(slot1:getCollectionId()) then
		RougeCollectionChessController.instance:deselectCollection()
		RougeCollectionChessController.instance:removeCollectionFromSlotArea(slot2)
	end

	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.Failed2PlaceSlotCollection, slot2, true)
end

function slot0.tryPlaceEnchant2Collection(slot0, slot1, slot2)
	if not RougeCollectionModel.instance:getCollectionByUid(slot1) or not slot2 or slot1 == slot2 then
		return
	end

	if not RougeCollectionConfig.instance:getCollectionCfg(slot3.cfgId) then
		return
	end

	if slot4.type == RougeEnum.CollectionType.Enchant or (slot4.holeNum or 0) <= 0 then
		return
	end

	if slot0:getCollectionNextPlaceHole(slot1) and slot7 > 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.CollectionEnchant)
		RougeCollectionEnchantController.instance:trySendRogueCollectionEnchantRequest(slot1, slot2, slot7)
		slot0:updateCollectionNextPlaceHole(slot1)

		return true
	end
end

function slot0.deleteSlotCollection(slot0, slot1)
	if slot0._placeCollectionMap and slot0._placeCollectionMap[slot1] then
		slot0._poolComp:recycleCollectionItem(RougeCollectionDragItem.__cname, slot2)

		slot0._placeCollectionMap[slot1] = nil
	end

	if slot0._placeHoleIndexMap and slot0._placeHoleIndexMap[slot1] then
		slot0._placeHoleIndexMap[slot1] = nil
	end
end

function slot0.updateEnchantInfo(slot0, slot1)
	if not RougeCollectionModel.instance:getCollectionByUid(slot1) then
		return
	end

	if not slot2:getAllEnchantId() then
		return
	end

	for slot7, slot8 in pairs(slot3) do
		if slot0._placeCollectionMap and slot0._placeCollectionMap[slot8] then
			slot0._poolComp:recycleCollectionItem(RougeCollectionDragItem.__cname, slot9)

			slot0._placeCollectionMap[slot8] = nil
		end
	end
end

function slot0.getPlaceCollectionItem(slot0, slot1)
	return slot0._placeCollectionMap and slot0._placeCollectionMap[slot1]
end

function slot0.getCollectionNextPlaceHole(slot0, slot1)
	if not RougeCollectionModel.instance:getCollectionByUid(slot1) then
		return
	end

	slot3 = nil

	if slot2:getAllEnchantId() then
		for slot8, slot9 in ipairs(slot4) do
			if not slot2:isEnchant(slot8) then
				slot3 = slot8

				break
			end
		end
	end

	slot3 = slot3 or slot0._placeHoleIndexMap[slot1] or 1
	slot0._placeHoleIndexMap[slot1] = slot3

	return slot3
end

function slot0.updateCollectionNextPlaceHole(slot0, slot1)
	if not RougeCollectionModel.instance:getCollectionByUid(slot1) then
		return
	end

	if slot0._placeHoleIndexMap[slot1] then
		if (slot3 + 1) % (RougeCollectionConfig.instance:getCollectionCfg(slot2.cfgId) and slot5.holeNum or 0) <= 0 then
			slot3 = slot6
		end

		slot0._placeHoleIndexMap[slot1] = slot3
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._poolComp = nil

	if slot0._placeCollectionMap then
		for slot4, slot5 in pairs(slot0._placeCollectionMap) do
			slot5:destroy()
		end
	end
end

return slot0
