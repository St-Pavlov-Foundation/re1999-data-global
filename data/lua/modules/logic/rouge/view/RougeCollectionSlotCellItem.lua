module("modules.logic.rouge.view.RougeCollectionSlotCellItem", package.seeall)

slot0 = class("RougeCollectionSlotCellItem", RougeCollectionBaseSlotCellItem)

function slot0.onInit(slot0, slot1, slot2, slot3, slot4)
	uv0.super.onInit(slot0, slot1, slot2, slot3, slot4)
end

function slot0._onInitView(slot0, slot1, slot2, slot3, slot4)
	uv0.super._onInitView(slot0, slot1, slot2, slot3, slot4)

	slot0._goarea = gohelper.findChild(slot0.viewGO, "area")
	slot0._imagestate = gohelper.findChildImage(slot0.viewGO, "area/state")
	slot0._goplace = gohelper.findChild(slot0.viewGO, "area/place")

	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.OnBeginDragCollection, slot0._onBeginDragCollection, slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.OnEndDragCollection, slot0._onEndDragCollection, slot0)
end

function slot0.chechCellHasPlace(slot0)
	return RougeCollectionModel.instance:getSlotFilledCollectionId(slot0._cellPosX, slot0._cellPosY) ~= nil and slot1 > 0, slot1
end

function slot0.onCoverCollection(slot0, slot1, slot2)
	slot3, slot4 = slot0:chechCellHasPlace()

	if slot3 and slot4 == slot1 then
		slot0:updateCellState(RougeEnum.LineState.Green)
		slot0:hideInsideLines(slot2)

		return
	end

	if not RougeCollectionModel.instance:getCollectionByUid(slot1) then
		return
	end

	if slot3 then
		if slot0:checkIsCanEnchant2PlaceCollection(slot4, slot5) then
			slot0:updateCellState(RougeEnum.LineState.Green)
		else
			slot0:updateCellState(RougeEnum.LineState.Red)
		end
	else
		slot0:updateCellState(RougeEnum.LineState.Green)
	end

	slot0:hideInsideLines(slot2)
end

function slot0.checkIsCanEnchant2PlaceCollection(slot0, slot1, slot2)
	return RougeCollectionConfig.instance:getCollectionCfg(slot2.cfgId).type == RougeEnum.CollectionType.Enchant and RougeCollectionConfig.instance:getCollectionCfg(RougeCollectionModel.instance:getCollectionByUid(slot1).cfgId).type ~= RougeEnum.CollectionType.Enchant
end

function slot0.updateCellColor(slot0, slot1)
	gohelper.setActive(slot0._imagestate.gameObject, true)

	if slot1 == RougeEnum.LineState.Green then
		UISpriteSetMgr.instance:setRougeSprite(slot0._imagestate, "rouge_collection_grid_big_3")
	elseif slot1 == RougeEnum.LineState.Blue then
		UISpriteSetMgr.instance:setRougeSprite(slot0._imagestate, "rouge_collection_grid_big_1")
	else
		gohelper.setActive(slot0._imagestate.gameObject, false)
	end
end

function slot0.updateCellState(slot0, slot1)
	uv0.super.updateCellState(slot0, slot1)
	slot0:updateCellColor(slot0._curCellState)
end

function slot0._onBeginDragCollection(slot0, slot1)
	slot2 = RougeCollectionModel.instance:getSlotFilledCollectionId(slot0._cellPosX, slot0._cellPosY)

	gohelper.setActive(slot0._goplace, slot1 and slot1.id == slot2 or not slot2 or slot2 <= 0)
end

function slot0._onEndDragCollection(slot0)
	gohelper.setActive(slot0._goplace, false)
end

function slot0.onPlaceCollection(slot0, slot1)
	uv0.super.onPlaceCollection(slot0, slot1)
	gohelper.setActive(slot0._imagestate.gameObject, false)
end

function slot0.revertCellState(slot0, slot1)
	uv0.super.revertCellState(slot0, slot1)
	gohelper.setActive(slot0._imagestate.gameObject, false)
end

function slot0.destroy(slot0)
	uv0.super.destroy(slot0)
end

return slot0
