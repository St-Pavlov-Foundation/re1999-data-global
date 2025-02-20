module("modules.logic.versionactivity2_3.zhixinquaner.maze.base.view.PuzzleMazeDrawBaseView", package.seeall)

slot0 = class("PuzzleMazeDrawBaseView", BaseView)

function slot0._editableInitView(slot0)
	slot0:onInit()
end

function slot0.onOpen(slot0)
	slot0:startGame()
end

function slot0.onClose(slot0)
	slot0:unregisterDragCallBacks()
	slot0:destroyPawnObj()
	slot0:removeAllPathLines()
	slot0:removeAllMapLines()
	slot0:removeAllObjects()
end

function slot0.onInit(slot0)
	slot0._curDragLine = {
		x2 = 0,
		y2 = 0,
		x1 = 0,
		y1 = 0
	}
	slot0._objectMap = {}
	slot0._pathLineMap = {}
	slot0._mapLineSet = {}
	slot0._alertObjList = {}
	slot0._alertFreePool = {}

	slot0:setCanTouch(true)

	slot0._modelInst = slot0:getModelInst()
	slot0._ctrlInst = slot0:getCtrlInst()
	slot0._alertTriggerFuncMap = {}

	slot0:registerDragCallBacks()
end

function slot0.registerDragCallBacks(slot0)
	if slot0:getDragGo() then
		slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot1)

		slot0._drag:AddDragBeginListener(slot0.onBeginDragHandler, slot0)
		slot0._drag:AddDragListener(slot0.onDragHandler, slot0)
		slot0._drag:AddDragEndListener(slot0.onEndDragHandler, slot0)
	end
end

function slot0.unregisterDragCallBacks(slot0)
	if slot0._drag then
		slot0._drag:RemoveDragBeginListener()
		slot0._drag:RemoveDragListener()
		slot0._drag:RemoveDragEndListener()

		slot0._drag = nil
	end
end

function slot0.startGame(slot0)
	slot0:setCanTouch(true)
	slot0:setGameFinished(false)
	slot0:removeAllPathLines()
	slot0:removeAllMapLines()
	slot0:removeAllObjects()
	slot0:initAllMapLines()
	slot0:initAllObjects()
	slot0:initPawn()
	slot0:syncPath()
	slot0:syncAlertObjs()
	slot0:syncCheckPoints()
	slot0._ctrlInst:dispatchEvent(PuzzleEvent.InitGameDone)
end

function slot0.restartGame(slot0)
	slot0._ctrlInst:restartGame()
	slot0:startGame()
end

function slot0.initAllMapLines(slot0)
	slot1, slot2 = slot0._modelInst:getGameSize()

	for slot6 = 1, slot1 + 1 do
		for slot10 = 1, slot2 + 1 do
			if slot6 <= slot1 then
				slot0:initMapLine(slot6, slot10, slot6 + 1, slot10)
			end

			if slot10 <= slot2 then
				slot0:initMapLine(slot6, slot10, slot6, slot10 + 1)
			end
		end
	end
end

function slot0.initMapLine(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6, slot7, slot8 = PuzzleMazeHelper.formatPos(slot1, slot2, slot3, slot4)

	if not slot0._mapLineSet[PuzzleMazeHelper.getLineKey(slot5, slot6, slot7, slot8)] then
		slot11, slot12 = slot0:getLineTemplateFillOrigin()
		slot0._mapLineSet[slot5] = slot0:getLineObjCls(PuzzleEnum.LineType.Map).New(slot0:getResInst(slot0:getLineResUrl(PuzzleEnum.LineType.Map), slot0:getLineParentGo(PuzzleEnum.LineType.Map), slot5), slot11, slot12)
	end

	slot6:onInit(slot1, slot2, slot3, slot4)

	return slot6
end

function slot0.getOrCreatePathLine(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6, slot7, slot8, slot9 = PuzzleMazeHelper.formatPos(slot2, slot3, slot4, slot5)

	if not slot0._pathLineMap[PuzzleMazeHelper.getLineKey(slot6, slot7, slot8, slot9)] then
		slot12, slot13 = slot0:getLineTemplateFillOrigin()
		slot7 = slot0:getLineObjCls(slot1).New(slot0:getResInst(slot0:getLineResUrl(slot1), slot0:getLineParentGo(slot1), slot6), slot12, slot13)

		slot7:onInit(slot2, slot3, slot4, slot5)

		slot0._pathLineMap[slot6] = slot7
	end

	return slot7
end

function slot0.removeAllPathLines(slot0)
	for slot4, slot5 in pairs(slot0._pathLineMap) do
		slot5:destroy()

		slot0._pathLineMap[slot4] = nil
	end
end

function slot0.removeAllMapLines(slot0)
	for slot4, slot5 in pairs(slot0._mapLineSet) do
		slot5:destroy()

		slot0._mapLineSet[slot4] = nil
	end
end

function slot0.getOrCreateObject(slot0, slot1)
	if not slot0._objectMap[slot1:getKey()] then
		slot0._objectMap[slot2] = slot0:getMazeObjCls(slot1.objType, slot1.subType, slot1.group).New(slot0:getResInst(slot0:getObjectResUrl(slot1.objType, slot1.subType, slot1.group), slot0:getObjectParentGo(), slot2))
	end

	return slot3
end

function slot0.removeAllObjects(slot0)
	for slot4, slot5 in pairs(slot0._objectMap) do
		slot5:destroy()

		slot0._objectMap[slot4] = nil
	end
end

function slot0.initAllObjects(slot0)
	for slot5, slot6 in ipairs(slot0._modelInst:getList()) do
		slot0:getOrCreateObject(slot6):onInit(slot6)
	end
end

function slot0.getOrCreateAlertObj(slot0, slot1)
	slot2 = nil
	slot2 = (#slot0._alertFreePool > 0 or slot0:getAlertObjCls(slot1).New(slot0:getResInst(slot0:getAlertResUrl(slot1), slot0:getAlertParentGo(slot1), string.format("alert_%s", (slot0._alertObjList and #slot0._alertObjList or 0) + 1)))) and table.remove(slot0._alertFreePool)

	table.insert(slot0._alertObjList, slot2)

	return slot2
end

function slot0.recycleAlertObjs(slot0)
	for slot4 = #slot0._alertObjList, 1, -1 do
		slot5 = slot0._alertObjList[slot4]

		slot5:onDisable()
		slot5:onRecycle()
		table.insert(slot0._alertFreePool, slot5)

		slot0._alertObjList[slot4] = nil
	end
end

function slot0.initPawn(slot0)
	slot1, slot2 = slot0._ctrlInst:getLastPos()

	if slot1 ~= nil then
		slot3, slot4 = slot0._modelInst:getObjectAnchor(slot1, slot2)

		slot0:getOrCreatePawnObj():onInit(slot3, slot4)
	end
end

function slot0.getOrCreatePawnObj(slot0)
	if not slot0._objPawn then
		slot4 = slot0:getResInst(slot0:getPawnResUrl(), slot0:getPawnParentGo(), "pawn")

		gohelper.setAsLastSibling(slot4)

		slot0._objPawn = slot0:getPawnObjCls().New(slot4)
	end

	return slot1
end

function slot0.destroyPawnObj(slot0)
	if slot0:getOrCreatePawnObj() then
		slot1:destroy()
	end
end

function slot0.syncPath(slot0)
	slot1, slot2 = slot0._ctrlInst:getPassedPoints()
	slot3, slot4 = nil
	slot5 = {
		[PuzzleMazeHelper.getLineKey(slot3, slot4, slot10, slot11)] = true
	}

	for slot9 = 1, slot1 and #slot1 or 0 do
		slot10 = slot1[slot9]
		slot11 = slot2[slot9]

		if slot3 ~= nil then
			if PuzzleMazeHelper.getFromToDir(slot3, slot4, slot10, slot11) then
				slot14 = slot0:getOrCreatePathLine(PuzzleEnum.LineType.Path, slot3, slot4, slot10, slot11)

				slot14:onCrossFull(slot12)
				slot14:onAlert(slot0._alertType)
			else
				logNormal(string.format("error dir in (%s,%s,%s,%s)", slot3, slot4, slot10, slot11))
			end
		end

		slot4 = slot11
		slot3 = slot10
	end

	for slot9, slot10 in pairs(slot0._pathLineMap) do
		if not slot5[slot9] then
			slot10:clear()
		end
	end

	slot0._ctrlInst:resetLineDirty()
end

function slot0.syncDragLine(slot0)
	slot1 = false
	slot2, slot3, slot4, slot5 = slot0._ctrlInst:getProgressLine()

	if not slot0._ctrlInst:isBackward(slot2, slot3) then
		for slot10, slot11 in pairs(slot0._ctrlInst:getAlertMap()) do
			return false
		end
	end

	slot6 = slot4 or slot5

	if slot2 and slot3 and slot6 then
		slot7, slot8 = slot0._ctrlInst:getLastPos()
		slot9, slot10, slot11, slot12 = PuzzleMazeHelper.formatPos(slot7, slot8, slot2, slot3)

		if slot0._curDragLine.x1 ~= slot9 or slot0._curDragLine.y1 ~= slot10 or slot0._curDragLine.x2 ~= slot11 or slot0._curDragLine.y2 ~= slot12 then
			slot0._curDragLine.y2 = slot12
			slot0._curDragLine.x2 = slot11
			slot0._curDragLine.y1 = slot10
			slot0._curDragLine.x1 = slot9
			slot1 = true

			slot0:cleanDragLine()
		end

		slot13 = PuzzleMazeHelper.getFromToDir(slot7, slot8, slot2, slot3)

		slot0:getOrCreatePawnObj():setDir(slot13)
		slot0:getOrCreatePathLine(PuzzleEnum.LineType.Path, slot9, slot10, slot11, slot12):onCrossHalf(slot13, slot6)

		return slot1
	end

	return false
end

function slot0.syncAlertObjs(slot0)
	slot0:recycleAlertObjs()

	slot0._alertType = PuzzleEnum.MazeAlertType.None

	if slot0._ctrlInst:getAlertMap() then
		for slot5, slot6 in pairs(slot1) do
			slot0:onTriggerAlert(slot6, slot5)

			slot0._alertType = slot6

			return
		end
	end
end

function slot0.onTriggerAlert(slot0, slot1, slot2)
	slot0:getOrCreateAlertObj(slot1):onEnable(slot1, slot2)

	if slot0:getAlertTriggerFunc(slot1) then
		slot4(slot0, slot2)
	end
end

function slot0.registerAlertTriggerFunc(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		logError("注册警告触发方法时警告类型及回调方法不可为空")

		return
	end

	if slot0._alertTriggerFuncMap[slot1] then
		logError("注册了重复的警告执行方法 :" .. tostring(slot1))

		return
	end

	slot0._alertTriggerFuncMap[slot1] = slot2
end

function slot0.getAlertTriggerFunc(slot0, slot1)
	if not slot1 then
		return
	end

	return slot0._alertTriggerFuncMap and slot0._alertTriggerFuncMap[slot1]
end

function slot0.onBeginDragHandler(slot0, slot1, slot2)
	if not slot0:canTouch() then
		slot0:onBeginDragFailed(slot2)

		return
	end

	slot0:onBeginDragSucc(slot2)
end

function slot0.onDragHandler(slot0, slot1, slot2)
	if not slot0:canTouch() then
		return
	end

	if slot0._isPawnMoving then
		slot5 = recthelper.screenPosToAnchorPos(slot2.position, slot0:getDragGo().transform)

		slot0:onDrag_StartProcessPos(slot2, slot5)
		slot0:onDrag_EndProcessPos(slot2, slot5)
	end
end

function slot0.onDrag_StartProcessPos(slot0, slot1, slot2)
	slot3, slot4 = slot0._modelInst:getClosePosByTouchPos(slot2.x, slot2.y)

	if slot3 ~= -1 then
		slot0._ctrlInst:goPassPos(slot3, slot4)
	else
		slot5, slot6, slot7, slot8, slot9, slot10, slot11 = slot0._modelInst:getLineFieldByTouchPos(slot2.x, slot2.y)

		if slot5 then
			slot0._ctrlInst:goPassLine(slot6, slot7, slot8, slot9, slot10, slot11)
		end
	end
end

function slot0.onDrag_EndProcessPos(slot0, slot1, slot2)
	slot0:onDrag_SyncPawn(slot1, slot2)
	slot0:onDrag_SyncPath(slot1, slot2)
end

function slot0.onDrag_SyncPath(slot0, slot1, slot2)
	if slot0._ctrlInst:isLineDirty() then
		slot0:syncPath()
		slot0:syncAlertObjs()
		slot0:syncCheckPoints()
	end

	if not slot3 and slot0:syncDragLine() then
		slot0:syncPath()
	end

	if slot3 then
		slot0:checkGameFinished()
	end
end

function slot0.onEndDragHandler(slot0, slot1, slot2)
	if not slot0:canTouch() then
		return
	end

	if slot0._isPawnMoving then
		slot0._isPawnMoving = false

		if slot0._ctrlInst:hasAlertObj() then
			slot0:onEndDrag_HasAlert()
		else
			slot0:onEndDrag_NoneAlert()
		end
	end
end

function slot0.cleanDragLine(slot0)
	for slot4, slot5 in pairs(slot0._pathLineMap) do
		if slot5:getProgress() <= 0.999 and slot6 >= 0.01 then
			slot5:clear()
		end
	end
end

function slot0.syncCheckPoints(slot0)
	slot2 = {}

	for slot7, slot8 in ipairs(slot0._modelInst:getList()) do
		slot9 = slot0:getOrCreateObject(slot8)

		if slot8.objType == PuzzleEnum.MazeObjType.CheckPoint and slot0._ctrlInst:alreadyCheckPoint(slot8) then
			table.insert(slot2, tostring(slot8))

			slot3 = 0 + 1
		end

		slot0:tickObjBehaviour(slot8, slot9)
	end

	slot0:onEndRefreshCheckPoint(slot0._lastCheckSum, table.concat(slot2), slot0._lastCheckCount, slot3)
end

function slot0.tickObjBehaviour(slot0, slot1, slot2)
	slot3 = false

	if slot1.objType ~= PuzzleEnum.MazeObjType.Block then
		slot3 = slot0._ctrlInst:alreadyPassed(slot1.x, slot1.y)
	end

	if slot2:HasEnter() then
		if slot3 then
			slot2:onAlreadyEnter()
		else
			slot2:onExit()
		end
	elseif not slot4 and slot3 then
		slot2:onEnter()
	end
end

function slot0.checkGameFinished(slot0)
	if slot0:isGameFinished() then
		return
	end

	if slot0:checkIsGameFailed() then
		slot0:onGameFailed()

		return
	end

	if slot0:checkIsGameSucc() then
		slot0:onGameSucc()

		return
	end
end

function slot0.onBeginDragSucc(slot0, slot1)
	slot2, slot3 = slot0._ctrlInst:getLastPos()
	slot4, slot5 = slot0:getPawnPosByPointerEventData(slot1)

	if slot4 ~= -1 and slot2 == slot4 and slot3 == slot5 then
		slot0:onBeginDrag_SyncPawn()
	end
end

function slot0.getPawnPosByPointerEventData(slot0, slot1)
	slot3 = recthelper.screenPosToAnchorPos(slot1.position, slot0:getDragGo().transform)
	slot4, slot5 = slot0._modelInst:getClosePosByTouchPos(slot3.x - PuzzleEnum.mazeMonsterTouchOffsetX, slot3.y - PuzzleEnum.mazeMonsterHeight)

	return slot4, slot5
end

function slot0.onEndDrag_HasAlert(slot0)
	slot0._ctrlInst:goBackPos()
	slot0:onEndDrag_SyncPawn()
	slot0:syncAlertObjs()
	slot0:syncPath()
	slot0:cleanDragLine()
	slot0:syncCheckPoints()
end

function slot0.onEndDrag_NoneAlert(slot0)
	slot0:onEndDrag_SyncPawn()
	slot0:syncPath()
	slot0:cleanDragLine()
	slot0:checkGameFinished()
end

function slot0.onBeginDrag_SyncPawn(slot0)
	slot0._isPawnMoving = true

	slot0:getOrCreatePawnObj():onBeginDrag()
	slot0._ctrlInst:dispatchEvent(PuzzleEvent.OnBeginDragPawn)
end

function slot0.onDrag_SyncPawn(slot0, slot1, slot2)
	slot0:getOrCreatePawnObj():onDraging(slot2.x, slot2.y)
end

function slot0.onEndDrag_SyncPawn(slot0)
	slot1, slot2 = slot0._ctrlInst:getLastPos()
	slot3, slot4 = slot0._modelInst:getObjectAnchor(slot1, slot2)

	slot0:getOrCreatePawnObj():onEndDrag(slot3, slot4)
	slot0._ctrlInst:dispatchEvent(PuzzleEvent.OnEndDragPawn)
end

function slot0.canTouch(slot0)
	return slot0._canTouch
end

function slot0.setCanTouch(slot0, slot1)
	slot0._canTouch = slot1
end

function slot0.onBeginDragFailed(slot0, slot1)
end

function slot0.onEndRefreshCheckPoint(slot0, slot1, slot2, slot3, slot4)
	slot0._lastCheckSum = slot2
	slot0._lastCheckCount = slot4
end

function slot0.checkIsGameSucc(slot0)
	return slot0._ctrlInst:isGameClear()
end

function slot0.onGameSucc(slot0)
	if slot0._isPawnMoving then
		slot0:onEndDrag_SyncPawn()
	end

	slot0:setCanTouch(false)
	slot0:setGameFinished(true)
	slot0._modelInst:setGameStatus(true)

	if slot0._modelInst:getElementCo() and slot1.id and not DungeonModel.instance:isFinishElementList(slot1) then
		DungeonRpc.instance:sendMapElementRequest(slot2)
	end

	slot0._ctrlInst:dispatchEvent(PuzzleEvent.OnGameFinished, slot2)
end

function slot0.checkIsGameFailed(slot0)
end

function slot0.onGameFailed(slot0)
	slot0:setGameFinished(true)
end

function slot0.isGameFinished(slot0)
	return slot0._isFinished
end

function slot0.setGameFinished(slot0, slot1)
	slot0._isFinished = slot1
end

function slot0.getModelInst(slot0)
end

function slot0.getCtrlInst(slot0)
end

function slot0.getDragGo(slot0)
end

function slot0.getLineParentGo(slot0)
end

function slot0.getPawnParentGo(slot0)
end

function slot0.getObjectParentGo(slot0)
end

function slot0.getAlertParentGo(slot0)
end

function slot0.getMazeObjCls(slot0, slot1, slot2, slot3)
end

function slot0.getPawnObjCls(slot0)
end

function slot0.getLineObjCls(slot0, slot1)
end

function slot0.getAlertObjCls(slot0, slot1)
end

function slot0.getPawnResUrl(slot0)
end

function slot0.getLineResUrl(slot0, slot1)
end

function slot0.getObjectResUrl(slot0, slot1, slot2, slot3)
end

function slot0.getAlertResUrl(slot0, slot1)
end

function slot0.getLineTemplateFillOrigin(slot0)
end

return slot0
