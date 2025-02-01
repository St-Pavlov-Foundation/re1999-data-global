module("modules.logic.rouge.view.RougeCollectionEffectActiveComp", package.seeall)

slot0 = class("RougeCollectionEffectActiveComp", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.OnBeginDragCollection, slot0.onBeginDragCollection, slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.DeleteSlotCollection, slot0.deleteSlotCollection, slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.UpdateSlotCollectionEffect, slot0.updateSomeSlotCollectionEffect, slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.RotateSlotCollection, slot0.onRotateSlotCollection, slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.Failed2PlaceSlotCollection, slot0.failed2PlaceSlotCollection, slot0)

	slot0._poolComp = slot0.viewContainer:getRougePoolComp()
	slot0._effectTab = slot0:getUserDataTb_()
	slot0._activeEffectMap = {}
end

function slot0.onOpenFinish(slot0)
	slot0:init()
end

function slot0.init(slot0)
	slot0:updateSomeSlotCollectionEffect(RougeCollectionModel.instance:getSlotAreaCollection())
end

function slot0.updateSomeSlotCollectionEffect(slot0, slot1)
	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			slot0:recycleCollectionEffects(slot6.id)
		end

		for slot5, slot6 in ipairs(slot1) do
			slot0:updateSlotCollectionEffect(slot6.id)
		end

		slot0:playNeedTriggerAudio()
	end
end

function slot0.updateSlotCollectionEffect(slot0, slot1)
	slot0:excuteActiveEffect(slot1)
end

function slot0.excuteActiveEffect(slot0, slot1)
	if not RougeCollectionModel.instance:getCollectionByUid(slot1) then
		return
	end

	if not RougeCollectionModel.instance:isCollectionPlaceInSlotArea(slot1) then
		return
	end

	for slot7, slot8 in pairs(RougeEnum.EffectActiveType) do
		slot0:executeEffectCmd(slot2:getEffectShowTypeRelations(slot8), slot2, slot8, slot2:isEffectActive(slot8))
	end
end

function slot0.executeEffectCmd(slot0, slot1, slot2, slot3, slot4)
	if not slot1 or not slot2 then
		return
	end

	if not slot0:tryGetExecuteEffectFunc(slot3) then
		logError(string.format("无法找到肉鸽造物效果表现执行方法,效果id = %s, 造物uid = %s", slot3, slot2.id))

		return
	end

	for slot9, slot10 in ipairs(slot1) do
		slot5(slot0, slot2, slot10, slot4)
	end
end

function slot0.tryGetExecuteEffectFunc(slot0, slot1)
	if not slot0._effectExcuteFuncTab then
		slot0._effectExcuteFuncTab = {
			[RougeEnum.EffectActiveType.Electric] = slot0.electricEffectFunc,
			[RougeEnum.EffectActiveType.Engulf] = slot0.engulfEffectFunc,
			[RougeEnum.EffectActiveType.LevelUp] = slot0.levelUpEffectFunc
		}
	end

	return slot0._effectExcuteFuncTab[slot1]
end

function slot0.electricEffectFunc(slot0, slot1, slot2, slot3)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateActiveEffect, slot1.id, RougeEnum.EffectActiveType.Electric, slot3)

	if slot3 then
		slot0:try2PlayEffectActiveAudio(slot1.id, nil, RougeEnum.EffectActiveType.Electric, AudioEnum.UI.ElectricEffect)
		RougeCollectionHelper.foreachCollectionCells(slot1, slot0.electircTypeCellFunc, slot0)
	end

	slot0:updateActiveEffectInfo(slot1.id, RougeEnum.EffectActiveType.Electric, slot3)
end

function slot0.electircTypeCellFunc(slot0, slot1, slot2, slot3)
	slot4 = slot1:getLeftTopPos()
	slot6, slot7 = RougeCollectionHelper.slotPos2AnchorPos(Vector2(slot4.x + slot3 - 1, slot4.y + slot2 - 1))
	slot8 = slot0._poolComp:getEffectItem(RougeEnum.CollectionArtType.Lighting)

	gohelper.setActive(slot8, true)
	recthelper.setAnchor(slot8.transform, slot6, slot7)
	slot0:saveEffectGO(slot1.id, RougeEnum.CollectionArtType.Lighting, slot8)
end

function slot0.levelUpEffectFunc(slot0, slot1, slot2, slot3)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateActiveEffect, slot1.id, RougeEnum.EffectActiveType.LevelUp, slot3)

	if slot3 then
		slot4 = slot2:getTrueCollectionIds()

		slot0:try2PlayEffectActiveAudio(slot1.id, slot4, RougeEnum.EffectActiveType.LevelUp, AudioEnum.UI.LevelUpEffect)

		if slot4 then
			for slot8, slot9 in ipairs(slot4) do
				slot0:levelupTypeTrueIdFunc(RougeCollectionModel.instance:getCollectionByUid(slot9), slot1)
				slot0:updateActiveEffectInfo(slot9, RougeEnum.EffectActiveType.LevelUp, slot3)
			end
		end
	end

	slot0:updateActiveEffectInfo(slot1.id, RougeEnum.EffectActiveType.LevelUp, slot3)
end

function slot0.levelupTypeTrueIdFunc(slot0, slot1, slot2)
	slot3, slot4 = RougeCollectionHelper.getTwoCollectionConnectCell(slot1, slot2)

	if not slot3 or not slot4 then
		return
	end

	slot5 = slot1.id

	slot0:drawLineConnectTwoCollection(slot5, slot3, slot2.id, slot4, RougeEnum.CollectionArtType.LevelUpLine)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateActiveEffect, slot5, RougeEnum.EffectActiveType.LevelUp, true)
end

function slot0.drawLineConnectTwoCollection(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = slot0._poolComp:getEffectItem(slot5)
	slot7, slot8 = RougeCollectionHelper.slotPos2AnchorPos(slot2)

	gohelper.setActive(slot6, true)
	recthelper.setAnchor(slot6.transform, slot7, slot8)

	slot9 = slot6.transform.position
	slot10, slot11 = recthelper.rectToRelativeAnchorPos2(slot9, slot0.viewGO.transform)
	slot12, slot13 = RougeCollectionHelper.slotPos2AnchorPos(slot4)

	recthelper.setAnchor(slot6.transform, slot12, slot13)

	slot15, slot16 = recthelper.rectToRelativeAnchorPos2(slot6.transform.position, slot0.viewGO.transform)

	slot0:setLinePosition(gohelper.findChildImage(slot6, "line"), slot10, slot11, slot15, slot16)
	slot0:setLinePosition(gohelper.findChildImage(slot6, "lineup"), slot10, slot11, slot15, slot16)

	slot20, slot21 = recthelper.rectToRelativeAnchorPos2(slot9, slot6.transform)

	recthelper.setAnchor(gohelper.findChild(slot6, "#dot").transform, slot20, slot21)
	slot0:saveEffectGO(slot1, slot5, slot6)
	slot0:saveEffectGO(slot3, slot5, slot6)
end

function slot0.setLinePosition(slot0, slot1, slot2, slot3, slot4, slot5)
	slot1.material:SetVector("_StartVec", Vector4(slot2, slot3, 0, 0))
	slot1.material:SetVector("_EndVec", Vector4(slot4, slot5, 0, 0))
end

function slot0.engulfEffectFunc(slot0, slot1, slot2, slot3)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateActiveEffect, slot1.id, RougeEnum.EffectActiveType.Engulf, slot3)

	if slot3 then
		slot4 = slot2:getTrueCollectionIds()

		slot0:try2PlayEffectActiveAudio(slot1.id, slot4, RougeEnum.EffectActiveType.Engulf, AudioEnum.UI.EngulfEffect)

		if slot4 then
			for slot8, slot9 in ipairs(slot4) do
				slot0:engulfTypeTrueIdFunc(slot1, RougeCollectionModel.instance:getCollectionByUid(slot9))
				slot0:updateActiveEffectInfo(slot9, RougeEnum.EffectActiveType.Engulf, slot3)
			end
		end
	end

	slot0:updateActiveEffectInfo(slot1.id, RougeEnum.EffectActiveType.Engulf, slot3)
end

function slot0.engulfTypeTrueIdFunc(slot0, slot1, slot2)
	slot3, slot4 = RougeCollectionHelper.getTwoCollectionConnectCell(slot1, slot2)

	if not slot3 or not slot4 then
		return
	end

	slot0:drawLineConnectTwoCollection(slot1.id, slot3, slot2.id, slot4, RougeEnum.CollectionArtType.EngulfLine)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateActiveEffect, slot2.id, RougeEnum.EffectActiveType.Engulf, true)
end

function slot0.saveEffectGO(slot0, slot1, slot2, slot3)
	slot4 = slot0._effectTab and slot0._effectTab[slot1]

	if not (slot4 and slot4[slot2]) then
		slot0._effectTab = slot0._effectTab or slot0:getUserDataTb_()
		slot0._effectTab[slot1] = slot0._effectTab[slot1] or slot0:getUserDataTb_()
		slot0._effectTab[slot1][slot2] = slot0:getUserDataTb_()
	end

	table.insert(slot0._effectTab[slot1][slot2], slot3)
end

function slot0.recycleEffectGOs(slot0, slot1, slot2)
	if slot0._effectTab and slot0._effectTab[slot1] and slot3[slot2] then
		for slot8 = #slot3[slot2], 1, -1 do
			table.remove(slot4, slot8)
			slot0._poolComp:recycleEffectItem(slot2, slot4[slot8])
		end
	end
end

function slot0.onBeginDragCollection(slot0, slot1)
	if not slot1 then
		return
	end

	slot0:recycleCollectionEffects(slot1.id)
	slot0:updateCollectionActiveEffectInfo(slot1.id)
end

function slot0.onRotateSlotCollection(slot0, slot1)
	if not slot1 then
		return
	end

	slot0:recycleCollectionEffects(slot1.id)
	slot0:updateCollectionActiveEffectInfo(slot1.id)
end

function slot0.setCollectionEffectsVisible(slot0, slot1, slot2)
	if not (slot0._effectTab and slot0._effectTab[slot1]) then
		return
	end

	for slot7, slot8 in pairs(slot3) do
		if slot0._effectTab and slot0._effectTab[slot1] and slot9[slot7] then
			for slot13, slot14 in pairs(slot9[slot7]) do
				if slot14 then
					gohelper.setActive(slot14, slot2)
				end
			end
		end
	end
end

function slot0.try2PlayEffectActiveAudio(slot0, slot1, slot2, slot3, slot4)
	if slot0:isCollectionHasActiveEffect(slot1, slot3) and slot2 then
		for slot9, slot10 in ipairs(slot2) do
			if not slot0:isCollectionHasActiveEffect(slot10, slot3) then
				break
			end
		end
	end

	if not slot5 then
		slot0._needTriggerAudioMap = slot0._needTriggerAudioMap or {}
		slot0._needTriggerAudioMap[slot4] = true
	end
end

function slot0.playNeedTriggerAudio(slot0)
	if slot0._needTriggerAudioMap then
		for slot4, slot5 in pairs(slot0._needTriggerAudioMap) do
			if slot5 then
				AudioMgr.instance:trigger(slot4)
			end

			slot0._needTriggerAudioMap[slot4] = nil
		end
	end
end

function slot0.updateActiveEffectInfo(slot0, slot1, slot2, slot3)
	if slot3 then
		slot0._activeEffectMap = slot0._activeEffectMap or {}
		slot0._activeEffectMap[slot1] = slot0._activeEffectMap[slot1] or {}
		slot0._activeEffectMap[slot1][slot2] = slot3
	elseif slot0._activeEffectMap and slot0._activeEffectMap[slot1] then
		slot4[slot2] = slot3
	end
end

function slot0.isCollectionHasActiveEffect(slot0, slot1, slot2)
	slot3 = slot0._activeEffectMap and slot0._activeEffectMap[slot1]

	return slot3 and slot3[slot2]
end

function slot0.failed2PlaceSlotCollection(slot0, slot1)
	if not RougeCollectionModel.instance:isCollectionPlaceInSlotArea(slot1) then
		return
	end

	slot0:updateSlotCollectionEffect(slot1)
end

function slot0.recycleCollectionEffects(slot0, slot1)
	if not (slot0._effectTab and slot0._effectTab[slot1]) then
		return
	end

	for slot6, slot7 in pairs(slot2) do
		slot0:recycleEffectGOs(slot1, slot6)
	end
end

function slot0.updateCollectionActiveEffectInfo(slot0, slot1)
	if not slot1 then
		return
	end

	for slot5, slot6 in pairs(RougeEnum.EffectActiveType) do
		slot0:updateActiveEffectInfo(slot1, slot6, false)
	end
end

function slot0.deleteSlotCollection(slot0, slot1)
	slot0:recycleCollectionEffects(slot1)
	slot0:updateCollectionActiveEffectInfo(slot1)
end

function slot0.onDestroyView(slot0)
	slot0._poolComp = nil
end

return slot0
