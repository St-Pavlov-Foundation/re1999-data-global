module("modules.logic.rouge.view.RougeCollectionEffectTriggerComp", package.seeall)

slot0 = class("RougeCollectionEffectTriggerComp", BaseView)

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
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.PlaceCollection2SlotArea, slot0.placeCollection2SlotAreaSucc, slot0)

	slot0._poolComp = slot0.viewContainer:getRougePoolComp()
	slot0._effectTab = slot0:getUserDataTb_()
	slot0._collectionMap = slot0:getUserDataTb_()
end

function slot0.onOpenFinish(slot0)
	if not RougeCollectionModel.instance:checkHasTmpTriggerEffectInfo() then
		return
	end

	slot0:init()
end

slot1 = 2

function slot0.placeCollection2SlotAreaSucc(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = slot1.id
	slot3 = slot1:getCenterSlotPos()
	slot6 = RougeCollectionConfig.instance:getRotateEditorParam(slot1.cfgId, slot1:getRotation(), RougeEnum.CollectionEditorParamType.Effect)
	slot7 = FlowSequence.New()

	slot7:addWork(FunctionWork.New(function ()
		uv0:recycleEffectGOs(uv1, RougeEnum.CollectionArtType.Place)
		uv0:recycleEffectGOs(uv1, RougeEnum.CollectionArtType.Effect)
	end))
	slot7:addWork(FunctionWork.New(slot0.shapeTriggerForeachCollectionCells, slot0, slot1))
	slot7:addWork(FunctionWork.New(function ()
		uv0:playCellEffect(uv1, uv2, uv3, RougeEnum.CollectionArtType.Effect)
	end))
	slot7:addWork(WorkWaitSeconds.New(uv0))
	slot7:addWork(FunctionWork.New(function ()
		uv0:recycleEffectGOs(uv1, RougeEnum.CollectionArtType.Place)
		uv0:recycleEffectGOs(uv1, RougeEnum.CollectionArtType.Effect)
	end))
	slot7:start()
end

function slot0.shapeTriggerForeachCollectionCells(slot0, slot1)
	RougeCollectionHelper.foreachCollectionCells(slot1, slot0.collectionCellsEffectExcuteFunc, slot0, RougeEnum.CollectionArtType.Place)
end

function slot0.playCellEffect(slot0, slot1, slot2, slot3, slot4)
	slot8 = slot1
	slot9 = slot4

	slot0:recycleEffectGOs(slot8, slot9)

	for slot8, slot9 in ipairs(slot2) do
		slot0:playSlotCellEffect(slot1, RougeCollectionHelper.getCollectionCellSlotPos(slot3, slot9), slot4)
	end
end

function slot0.recycleEffectGOs(slot0, slot1, slot2)
	if slot0._effectTab and slot0._effectTab[slot1] and slot3[slot2] then
		for slot8 = #slot3[slot2], 1, -1 do
			slot0._poolComp:recycleEffectItem(slot2, slot3[slot2][slot8])
			table.remove(slot3[slot2], slot8)
		end
	end
end

function slot0.checkIsSlotPosInSlotArea(slot0, slot1, slot2)
	slot3 = RougeCollectionModel.instance:getCurSlotAreaSize()

	if slot1 >= 0 and slot1 < slot3.col and slot2 >= 0 and slot2 < slot3.row then
		return true
	end
end

slot2 = 1.5

function slot0.init(slot0)
	if not RougeCollectionModel.instance:getTmpCollectionTriggerEffectInfo() then
		return
	end

	UIBlockMgrExtend.setNeedCircleMv(false)

	slot5 = "RougeCollectionEffectTriggerComp_PlayEffect"

	UIBlockMgr.instance:startBlock(slot5)

	for slot5, slot6 in ipairs(slot1) do
		slot0:excuteActiveEffect(slot6)
	end

	TaskDispatcher.cancelTask(slot0._endUIBlock, slot0)
	TaskDispatcher.runDelay(slot0._endUIBlock, slot0, uv0)
end

function slot0._endUIBlock(slot0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("RougeCollectionEffectTriggerComp_PlayEffect")
end

function slot0.excuteActiveEffect(slot0, slot1)
	slot0:executeEffectCmd(slot1, slot1.showType)
end

function slot0.executeEffectCmd(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	if not slot0:tryGetExecuteEffectFunc(slot2) then
		logError(string.format("无法找到肉鸽造物效果表现执行方法,效果id = %s, 造物uid = %s", slot2, slot1.trigger.id))

		return
	end

	slot3(slot0, slot1)
end

function slot0.tryGetExecuteEffectFunc(slot0, slot1)
	if not slot0._effectExcuteFuncTab then
		slot0._effectExcuteFuncTab = {
			[RougeEnum.EffectTriggerType.Engulf] = slot0.engulfEffectFunc,
			[RougeEnum.EffectTriggerType.LevelUp] = slot0.levelUpEffectFunc
		}
	end

	return slot0._effectExcuteFuncTab[slot1]
end

function slot0.levelUpEffectFunc(slot0, slot1)
	slot3 = slot1.trigger

	if slot1.removeCollections then
		for slot7, slot8 in ipairs(slot2) do
			slot0:levelupEffectCollectionFunc(slot3, slot8)
		end
	end
end

function slot0.levelupEffectCollectionFunc(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return
	end

	slot3, slot4 = RougeCollectionHelper.getTwoCollectionConnectCell(slot1, slot2)

	if not slot3 or not slot4 then
		return
	end

	slot5 = FlowSequence.New()
	slot6 = FlowParallel.New()

	slot6:addWork(FunctionWork.New(slot0.levelupTriggerForeachCollectionCells, slot0, slot1))
	slot6:addWork(FunctionWork.New(slot0.levelupTriggerForeachCollectionCells, slot0, slot2))
	slot6:addWork(FunctionWork.New(function ()
		uv0:drawTriggerLine(uv1, uv2, RougeEnum.CollectionArtType.LevelUPTrigger2)
	end))
	slot5:addWork(slot6)
	slot5:addWork(WorkWaitSeconds.New(uv0))
	slot5:addWork(FunctionWork.New(function ()
		uv0:recycleEffectGOs(uv1.id, RougeEnum.CollectionArtType.LevelUPTrigger1)
	end))
	slot5:addWork(FunctionWork.New(function ()
		uv0:recycleEffectGOs(uv1.id, RougeEnum.CollectionArtType.LevelUPTrigger1)
	end))
	slot5:addWork(FunctionWork.New(function ()
		uv0:recycleEffectGOs(uv1.id, RougeEnum.CollectionArtType.LevelUPTrigger2)
	end))
	slot5:start()
end

function slot0.levelupTriggerForeachCollectionCells(slot0, slot1)
	RougeCollectionHelper.foreachCollectionCells(slot1, slot0.collectionCellsEffectExcuteFunc, slot0, RougeEnum.CollectionArtType.LevelUPTrigger1)
end

function slot0.collectionCellsEffectExcuteFunc(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot1:getLeftTopPos()

	slot0:playSlotCellEffect(slot1.id, Vector2(slot5.x + slot3 - 1, slot5.y + slot2 - 1), slot4)
end

function slot0.drawTriggerLine(slot0, slot1, slot2, slot3)
	slot4, slot5 = RougeCollectionHelper.getTwoCollectionConnectCell(slot1, slot2)

	if not slot4 or not slot5 then
		return
	end

	slot7, slot8 = RougeCollectionHelper.slotPos2AnchorPos(slot4)
	slot9 = slot0:getAndSaveEffectItem(slot1.id, slot3)

	recthelper.setAnchor(slot9.transform, slot7, slot8)
	gohelper.setActive(slot9.gameObject, true)
	slot0:setLineDirection(slot9, slot0:getDrawLineDirection(slot4, slot5))
end

function slot0.getDrawLineDirection(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return
	end

	if slot1.y < slot2.y then
		return RougeEnum.SlotCellDirection.Bottom
	elseif slot2.y < slot1.y then
		return RougeEnum.SlotCellDirection.Top
	elseif slot1.x < slot2.x then
		return RougeEnum.SlotCellDirection.Right
	else
		return RougeEnum.SlotCellDirection.Left
	end
end

function slot0.setLineDirection(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	for slot7 = slot1.transform.childCount, 1, -1 do
		gohelper.setActive(slot1.transform:GetChild(slot7 - 1).gameObject, false)
	end

	slot4 = nil

	if (slot2 ~= RougeEnum.SlotCellDirection.Left or slot1.transform:Find("left")) and (slot2 ~= RougeEnum.SlotCellDirection.Right or slot1.transform:Find("right")) and (slot2 ~= RougeEnum.SlotCellDirection.Top or slot1.transform:Find("top")) and slot1.transform:Find("down") then
		gohelper.setActive(slot4.gameObject, true)
	end
end

function slot0.playSlotCellEffect(slot0, slot1, slot2, slot3)
	if not slot1 or not slot2 or not slot3 then
		return
	end

	if not slot0:checkIsSlotPosInSlotArea(slot2.x, slot2.y) then
		return
	end

	slot5 = slot0:getAndSaveEffectItem(slot1, slot3)
	slot6, slot7 = RougeCollectionHelper.slotPos2AnchorPos(slot2)

	gohelper.setActive(slot5, true)
	recthelper.setAnchor(slot5.transform, slot6, slot7)
end

function slot0.getAndSaveEffectItem(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return
	end

	slot3 = slot0._poolComp:getEffectItem(slot2)
	slot4 = slot0._effectTab and slot0._effectTab[slot1]

	if not (slot4 and slot4[slot2]) then
		slot0._effectTab = slot0._effectTab or slot0:getUserDataTb_()
		slot0._effectTab[slot1] = slot0._effectTab[slot1] or slot0:getUserDataTb_()
		slot0._effectTab[slot1][slot2] = slot0:getUserDataTb_()
	end

	table.insert(slot0._effectTab[slot1][slot2], slot3)

	return slot3
end

function slot0.setCollectionsVisible(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	for slot6, slot7 in pairs(slot1) do
		RougeCollectionChessController.instance:dispatchEvent(RougeEvent.SetCollectionVisible, slot7, slot2)
	end
end

function slot0.getOrCreateTmpCollection(slot0, slot1)
	if not slot0._collectionMap[slot1.id] then
		slot2 = slot0._poolComp:getCollectionItem(RougeCollectionDragItem.__cname)

		slot2:onUpdateMO(slot1)
		slot2:setShapeCellsVisible(false)
		slot2:setHoleToolVisible(true)
		slot2:setShowTypeFlagVisible(true)

		slot0._collectionMap[slot1.id] = slot2
	end

	return slot2
end

function slot0.resetTmpCollection(slot0, slot1)
	if not slot0._collectionMap[slot1] then
		return
	end

	slot2:reset()
end

function slot0.engulfEffectFunc(slot0, slot1)
	slot3 = slot1.trigger

	if slot1.removeCollections then
		for slot7, slot8 in ipairs(slot2) do
			slot0:engulfEffectCollectionFunc(slot3, slot8)
		end
	end
end

function slot0.engulfEffectCollectionFunc(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return
	end

	slot3, slot4 = RougeCollectionHelper.getTwoCollectionConnectCell(slot1, slot2)

	if not slot3 or not slot4 then
		return
	end

	slot5 = FlowSequence.New()
	slot6 = FlowParallel.New()

	slot6:addWork(FunctionWork.New(slot0.engulfTriggerForeachCollectionCells, slot0, slot1))
	slot6:addWork(FunctionWork.New(slot0.engulfTriggerForeachCollectionCells, slot0, slot2))
	slot6:addWork(FunctionWork.New(function ()
		uv0:playEngulfCollection(uv1, uv2)
	end))
	slot6:addWork(FunctionWork.New(function ()
		uv0:drawTriggerLine(uv1, uv2, RougeEnum.CollectionArtType.EngulfTrigger2)
	end))
	slot5:addWork(slot6)
	slot5:addWork(WorkWaitSeconds.New(uv0))
	slot5:addWork(FunctionWork.New(function ()
		uv0:recycleEffectGOs(uv1.id, RougeEnum.CollectionArtType.EngulfTrigger1)
	end))
	slot5:addWork(FunctionWork.New(function ()
		uv0:recycleEffectGOs(uv1.id, RougeEnum.CollectionArtType.EngulfTrigger1)
	end))
	slot5:addWork(FunctionWork.New(function ()
		uv0:recycleEffectGOs(uv1.id, RougeEnum.CollectionArtType.EngulfTrigger2)
	end))
	slot5:addWork(FunctionWork.New(slot0.resetTmpCollection, slot0, slot2.id))
	slot5:start()
end

function slot0.engulfTriggerForeachCollectionCells(slot0, slot1)
	RougeCollectionHelper.foreachCollectionCells(slot1, slot0.collectionCellsEffectExcuteFunc, slot0, RougeEnum.CollectionArtType.EngulfTrigger1)
end

function slot0.playEngulfCollection(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return
	end

	slot3 = slot0:getOrCreateTmpCollection(slot1)
	slot4, slot5 = RougeCollectionHelper.getTwoCollectionConnectCell(slot1, slot2)

	if not slot4 or not slot5 then
		return
	end

	slot3:playAnim(slot0:getEngulfCollectionAnimStateName(slot0:getDrawLineDirection(slot4, slot5)))
	slot3:setCollectionInteractable(false)
end

function slot0.getEngulfCollectionAnimStateName(slot0, slot1)
	slot2 = "default"

	return slot1 == RougeEnum.SlotCellDirection.Left and "left" or slot1 == RougeEnum.SlotCellDirection.Right and "right" or slot1 == RougeEnum.SlotCellDirection.Top and "top" or "down"
end

function slot0.onClose(slot0)
	RougeCollectionModel.instance:clearTmpCollectionTriggerEffectInfo()
	slot0:_endUIBlock()
end

function slot0.onDestroyView(slot0)
	if slot0._collectionMap then
		for slot4, slot5 in pairs(slot0._collectionMap) do
			slot5:destroy()
		end
	end

	slot0._poolComp = nil

	TaskDispatcher.cancelTask(slot0._endUIBlock, slot0)
end

return slot0
