module("modules.logic.rouge.view.RougeCollectionChessPoolComp", package.seeall)

slot0 = class("RougeCollectionChessPoolComp", BaseView)

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
	slot0._gosizeitem = gohelper.findChild(slot0.viewGO, "#go_sizebag/#go_sizecollections/#go_sizeitem")
	slot0._golevelupeffect = gohelper.findChild(slot0.viewGO, "chessboard/#go_effectContainer/#go_levelupeffect")
	slot0._goengulfeffect = gohelper.findChild(slot0.viewGO, "chessboard/#go_effectContainer/#go_engulfeffect")
	slot0._goplaceeffect = gohelper.findChild(slot0.viewGO, "chessboard/#go_effectContainer/#go_placeeffect")
	slot0._goareaeffect = gohelper.findChild(slot0.viewGO, "chessboard/#go_effectContainer/#go_areaeffect")
	slot0._golightingeffect = gohelper.findChild(slot0.viewGO, "chessboard/#go_effectContainer/#go_lightingeffect")
	slot0._golinelevelup = gohelper.findChild(slot0.viewGO, "chessboard/#go_lineContainer/#go_linelevelup")
	slot0._golineengulf = gohelper.findChild(slot0.viewGO, "chessboard/#go_lineContainer/#go_lineengulf")
	slot0._goleveluptrigger1 = gohelper.findChild(slot0.viewGO, "chessboard/#go_triggerContainer/#go_levelup1")
	slot0._goleveluptrigger2 = gohelper.findChild(slot0.viewGO, "chessboard/#go_triggerContainer/#go_levelup2")
	slot0._goengulftrigger1 = gohelper.findChild(slot0.viewGO, "chessboard/#go_triggerContainer/#go_engulf1")
	slot0._goengulftrigger2 = gohelper.findChild(slot0.viewGO, "chessboard/#go_triggerContainer/#go_engulf2")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._buildDragItemCount = 0
	slot0._buildEffectItemCount = 0
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.getCollectionItem(slot0, slot1)
	if slot0:getOrCreateCollectionPool(slot1) then
		return slot2:getObject()
	end
end

function slot0.recycleCollectionItem(slot0, slot1, slot2)
	if not slot2 then
		return
	end

	if slot0._poolMap and slot0._poolMap[slot1] then
		slot3:putObject(slot2)
	end
end

function slot0.getOrCreateCollectionPool(slot0, slot1)
	slot0._poolMap = slot0._poolMap or slot0:getUserDataTb_()

	if not slot0._poolMap[slot1] then
		slot0._poolMap[slot1] = (slot1 ~= RougeCollectionDragItem.__cname or slot0:buildCollectionDragItemPool()) and slot0:buildCollectionSizePool()
	end

	return slot2
end

function slot0.buildCollectionDragItemPool(slot0)
	return LuaObjPool.New(RougeEnum.MaxCollectionSlotSize.x * RougeEnum.MaxCollectionSlotSize.y, function ()
		uv0._buildDragItemCount = uv0._buildDragItemCount + 1
		slot2 = RougeCollectionDragItem.New()

		slot2:onInit(string.format("collection_%s", uv0._buildDragItemCount), uv0)

		return slot2
	end, slot0.releaseCollectionItemFunction, slot0.resetCollectionItemFunction)
end

function slot0.releaseCollectionItemFunction(slot0)
	if slot0 then
		slot0:destroy()
	end
end

function slot0.resetCollectionItemFunction(slot0)
	if slot0 then
		slot0:reset()
	end
end

function slot0.buildCollectionSizePool(slot0)
	return LuaObjPool.New(RougeEnum.MaxCollectionSlotSize.x * RougeEnum.MaxCollectionSlotSize.y, function ()
		return RougeCollectionSizeBagItem.New()
	end, slot0.releaseSizeItemFunction, slot0.resetSizeItemFunction)
end

function slot0.releaseSizeItemFunction(slot0)
	if slot0 then
		slot0:destroy()
	end
end

function slot0.resetSizeItemFunction(slot0)
	if slot0 then
		slot0:reset()
	end
end

function slot0.getEffectItem(slot0, slot1)
	if slot0:getOrCreateEffectPool(slot1) then
		return slot2:getObject()
	else
		logError("cannot find effectpool, effectType = " .. tostring(slot1))
	end
end

function slot0.recycleEffectItem(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return
	end

	if slot0._effectPoolMap and slot0._effectPoolMap[slot1] then
		slot3:putObject(slot2)
	end
end

function slot0.getOrCreateEffectPool(slot0, slot1)
	slot0._effectPoolMap = slot0._effectPoolMap or slot0:getUserDataTb_()

	if not slot0._effectPoolMap[slot1] then
		slot0._effectPoolMap[slot1] = slot0:buildEffectPool(slot1)
	end

	return slot2
end

slot1 = 4

function slot0.buildEffectPool(slot0, slot1)
	return LuaObjPool.New(RougeEnum.MaxCollectionSlotSize.x * RougeEnum.MaxCollectionSlotSize.y * uv0, function ()
		uv0._buildEffectItemCount = uv0._buildEffectItemCount + 1
		slot1 = string.format("effect_%s_%s", uv1, uv0._buildEffectItemCount)

		if not uv0:getEffectClonePrefab(uv1) then
			logError("克隆造物动效失败,失败原因:找不到指定效果类型的动效预制体,效果类型effectType = " .. tostring(uv1))
		end

		slot3 = gohelper.cloneInPlace(slot2, slot1)

		if uv1 == RougeEnum.CollectionArtType.LevelUpLine then
			slot4 = gohelper.findChildImage(slot3, "line")
			slot4.material = UnityEngine.GameObject.Instantiate(slot4.material)
			slot5 = gohelper.findChildImage(slot3, "lineup")
			slot5.material = UnityEngine.GameObject.Instantiate(slot5.material)
		elseif uv1 == RougeEnum.CollectionArtType.EngulfLine then
			slot4 = gohelper.findChildImage(slot3, "line")
			slot4.material = UnityEngine.GameObject.Instantiate(slot4.material)
			slot5 = gohelper.findChildImage(slot3, "lineup")
			slot5.material = UnityEngine.GameObject.Instantiate(slot5.material)
		end

		return slot3
	end, slot0.releaseEffectItemFunction, slot0.resetEffectItemFunction)
end

function slot0.getEffectClonePrefab(slot0, slot1)
	if not slot0._effectPrefabTab then
		slot0._effectPrefabTab = slot0:getUserDataTb_()
		slot0._effectPrefabTab[RougeEnum.CollectionArtType.Place] = slot0._goplaceeffect
		slot0._effectPrefabTab[RougeEnum.CollectionArtType.Effect] = slot0._goareaeffect
		slot0._effectPrefabTab[RougeEnum.CollectionArtType.Lighting] = slot0._golightingeffect
		slot0._effectPrefabTab[RougeEnum.CollectionArtType.LevelUpLine] = slot0._golinelevelup
		slot0._effectPrefabTab[RougeEnum.CollectionArtType.EngulfLine] = slot0._golineengulf
		slot0._effectPrefabTab[RougeEnum.CollectionArtType.LevelUP] = slot0._golevelupeffect
		slot0._effectPrefabTab[RougeEnum.CollectionArtType.LevelUPTrigger1] = slot0._goleveluptrigger1
		slot0._effectPrefabTab[RougeEnum.CollectionArtType.LevelUPTrigger2] = slot0._goleveluptrigger2
		slot0._effectPrefabTab[RougeEnum.CollectionArtType.EngulfTrigger1] = slot0._goengulftrigger1
		slot0._effectPrefabTab[RougeEnum.CollectionArtType.EngulfTrigger2] = slot0._goengulftrigger2
	end

	return slot0._effectPrefabTab and slot0._effectPrefabTab[slot1]
end

function slot0.releaseEffectItemFunction(slot0)
	if slot0 then
		gohelper.destroy(slot0)
	end
end

function slot0.resetEffectItemFunction(slot0)
	if slot0 then
		gohelper.setActive(slot0, false)
	end
end

function slot0.onDestroyView(slot0)
	if slot0._poolMap then
		for slot4, slot5 in pairs(slot0._poolMap) do
			slot5:dispose()
		end

		slot0._poolMap = nil
	end

	if slot0._effectPoolMap then
		for slot4, slot5 in pairs(slot0._effectPoolMap) do
			slot5:dispose()
		end

		slot0._effectPoolMap = nil
	end
end

return slot0
