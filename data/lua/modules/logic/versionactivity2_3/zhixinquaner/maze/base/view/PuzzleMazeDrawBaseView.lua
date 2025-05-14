module("modules.logic.versionactivity2_3.zhixinquaner.maze.base.view.PuzzleMazeDrawBaseView", package.seeall)

local var_0_0 = class("PuzzleMazeDrawBaseView", BaseView)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0:onInit()
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0:startGame()
end

function var_0_0.onClose(arg_3_0)
	arg_3_0:unregisterDragCallBacks()
	arg_3_0:destroyPawnObj()
	arg_3_0:removeAllPathLines()
	arg_3_0:removeAllMapLines()
	arg_3_0:removeAllObjects()
end

function var_0_0.onInit(arg_4_0)
	arg_4_0._curDragLine = {
		x2 = 0,
		y2 = 0,
		x1 = 0,
		y1 = 0
	}
	arg_4_0._objectMap = {}
	arg_4_0._pathLineMap = {}
	arg_4_0._mapLineSet = {}
	arg_4_0._alertObjList = {}
	arg_4_0._alertFreePool = {}

	arg_4_0:setCanTouch(true)

	arg_4_0._modelInst = arg_4_0:getModelInst()
	arg_4_0._ctrlInst = arg_4_0:getCtrlInst()
	arg_4_0._alertTriggerFuncMap = {}

	arg_4_0:registerDragCallBacks()
end

function var_0_0.registerDragCallBacks(arg_5_0)
	local var_5_0 = arg_5_0:getDragGo()

	if var_5_0 then
		arg_5_0._drag = SLFramework.UGUI.UIDragListener.Get(var_5_0)

		arg_5_0._drag:AddDragBeginListener(arg_5_0.onBeginDragHandler, arg_5_0)
		arg_5_0._drag:AddDragListener(arg_5_0.onDragHandler, arg_5_0)
		arg_5_0._drag:AddDragEndListener(arg_5_0.onEndDragHandler, arg_5_0)
	end
end

function var_0_0.unregisterDragCallBacks(arg_6_0)
	if arg_6_0._drag then
		arg_6_0._drag:RemoveDragBeginListener()
		arg_6_0._drag:RemoveDragListener()
		arg_6_0._drag:RemoveDragEndListener()

		arg_6_0._drag = nil
	end
end

function var_0_0.startGame(arg_7_0)
	arg_7_0:setCanTouch(true)
	arg_7_0:setGameFinished(false)
	arg_7_0:removeAllPathLines()
	arg_7_0:removeAllMapLines()
	arg_7_0:removeAllObjects()
	arg_7_0:initAllMapLines()
	arg_7_0:initAllObjects()
	arg_7_0:initPawn()
	arg_7_0:syncPath()
	arg_7_0:syncAlertObjs()
	arg_7_0:syncCheckPoints()
	arg_7_0._ctrlInst:dispatchEvent(PuzzleEvent.InitGameDone)
end

function var_0_0.restartGame(arg_8_0)
	arg_8_0._ctrlInst:restartGame()
	arg_8_0:startGame()
end

function var_0_0.initAllMapLines(arg_9_0)
	local var_9_0, var_9_1 = arg_9_0._modelInst:getGameSize()

	for iter_9_0 = 1, var_9_0 + 1 do
		for iter_9_1 = 1, var_9_1 + 1 do
			if iter_9_0 <= var_9_0 then
				arg_9_0:initMapLine(iter_9_0, iter_9_1, iter_9_0 + 1, iter_9_1)
			end

			if iter_9_1 <= var_9_1 then
				arg_9_0:initMapLine(iter_9_0, iter_9_1, iter_9_0, iter_9_1 + 1)
			end
		end
	end
end

function var_0_0.initMapLine(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	arg_10_1, arg_10_2, arg_10_3, arg_10_4 = PuzzleMazeHelper.formatPos(arg_10_1, arg_10_2, arg_10_3, arg_10_4)

	local var_10_0 = PuzzleMazeHelper.getLineKey(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_1 = arg_10_0._mapLineSet[var_10_0]

	if not var_10_1 then
		local var_10_2 = arg_10_0:getLineObjCls(PuzzleEnum.LineType.Map)
		local var_10_3 = arg_10_0:getLineResUrl(PuzzleEnum.LineType.Map)
		local var_10_4 = arg_10_0:getLineParentGo(PuzzleEnum.LineType.Map)
		local var_10_5 = arg_10_0:getResInst(var_10_3, var_10_4, var_10_0)
		local var_10_6, var_10_7 = arg_10_0:getLineTemplateFillOrigin()

		var_10_1 = var_10_2.New(var_10_5, var_10_6, var_10_7)
		arg_10_0._mapLineSet[var_10_0] = var_10_1
	end

	var_10_1:onInit(arg_10_1, arg_10_2, arg_10_3, arg_10_4)

	return var_10_1
end

function var_0_0.getOrCreatePathLine(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	arg_11_2, arg_11_3, arg_11_4, arg_11_5 = PuzzleMazeHelper.formatPos(arg_11_2, arg_11_3, arg_11_4, arg_11_5)

	local var_11_0 = PuzzleMazeHelper.getLineKey(arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	local var_11_1 = arg_11_0._pathLineMap[var_11_0]

	if not var_11_1 then
		local var_11_2 = arg_11_0:getLineObjCls(arg_11_1)
		local var_11_3 = arg_11_0:getLineResUrl(arg_11_1)
		local var_11_4 = arg_11_0:getLineParentGo(arg_11_1)
		local var_11_5 = arg_11_0:getResInst(var_11_3, var_11_4, var_11_0)
		local var_11_6, var_11_7 = arg_11_0:getLineTemplateFillOrigin()

		var_11_1 = var_11_2.New(var_11_5, var_11_6, var_11_7)

		var_11_1:onInit(arg_11_2, arg_11_3, arg_11_4, arg_11_5)

		arg_11_0._pathLineMap[var_11_0] = var_11_1
	end

	return var_11_1
end

function var_0_0.removeAllPathLines(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0._pathLineMap) do
		iter_12_1:destroy()

		arg_12_0._pathLineMap[iter_12_0] = nil
	end
end

function var_0_0.removeAllMapLines(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0._mapLineSet) do
		iter_13_1:destroy()

		arg_13_0._mapLineSet[iter_13_0] = nil
	end
end

function var_0_0.getOrCreateObject(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1:getKey()
	local var_14_1 = arg_14_0._objectMap[var_14_0]

	if not var_14_1 then
		local var_14_2 = arg_14_0:getObjectParentGo()
		local var_14_3 = arg_14_0:getObjectResUrl(arg_14_1.objType, arg_14_1.subType, arg_14_1.group)
		local var_14_4 = arg_14_0:getResInst(var_14_3, var_14_2, var_14_0)

		var_14_1 = arg_14_0:getMazeObjCls(arg_14_1.objType, arg_14_1.subType, arg_14_1.group).New(var_14_4)
		arg_14_0._objectMap[var_14_0] = var_14_1
	end

	return var_14_1
end

function var_0_0.removeAllObjects(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0._objectMap) do
		iter_15_1:destroy()

		arg_15_0._objectMap[iter_15_0] = nil
	end
end

function var_0_0.initAllObjects(arg_16_0)
	local var_16_0 = arg_16_0._modelInst:getList()

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		arg_16_0:getOrCreateObject(iter_16_1):onInit(iter_16_1)
	end
end

function var_0_0.getOrCreateAlertObj(arg_17_0, arg_17_1)
	local var_17_0

	if #arg_17_0._alertFreePool <= 0 then
		local var_17_1 = arg_17_0:getAlertParentGo(arg_17_1)
		local var_17_2 = arg_17_0:getAlertResUrl(arg_17_1)
		local var_17_3 = arg_17_0:getAlertObjCls(arg_17_1)
		local var_17_4 = arg_17_0._alertObjList and #arg_17_0._alertObjList or 0
		local var_17_5 = string.format("alert_%s", var_17_4 + 1)
		local var_17_6 = arg_17_0:getResInst(var_17_2, var_17_1, var_17_5)

		var_17_0 = var_17_3.New(var_17_6)
	else
		var_17_0 = table.remove(arg_17_0._alertFreePool)
	end

	table.insert(arg_17_0._alertObjList, var_17_0)

	return var_17_0
end

function var_0_0.recycleAlertObjs(arg_18_0)
	for iter_18_0 = #arg_18_0._alertObjList, 1, -1 do
		local var_18_0 = arg_18_0._alertObjList[iter_18_0]

		var_18_0:onDisable()
		var_18_0:onRecycle()
		table.insert(arg_18_0._alertFreePool, var_18_0)

		arg_18_0._alertObjList[iter_18_0] = nil
	end
end

function var_0_0.initPawn(arg_19_0)
	local var_19_0, var_19_1 = arg_19_0._ctrlInst:getLastPos()

	if var_19_0 ~= nil then
		local var_19_2, var_19_3 = arg_19_0._modelInst:getObjectAnchor(var_19_0, var_19_1)

		arg_19_0:getOrCreatePawnObj():onInit(var_19_2, var_19_3)
	end
end

function var_0_0.getOrCreatePawnObj(arg_20_0)
	local var_20_0 = arg_20_0._objPawn

	if not var_20_0 then
		local var_20_1 = arg_20_0:getPawnResUrl()
		local var_20_2 = arg_20_0:getPawnParentGo()
		local var_20_3 = arg_20_0:getResInst(var_20_1, var_20_2, "pawn")

		gohelper.setAsLastSibling(var_20_3)

		var_20_0 = arg_20_0:getPawnObjCls().New(var_20_3)
		arg_20_0._objPawn = var_20_0
	end

	return var_20_0
end

function var_0_0.destroyPawnObj(arg_21_0)
	local var_21_0 = arg_21_0:getOrCreatePawnObj()

	if var_21_0 then
		var_21_0:destroy()
	end
end

function var_0_0.syncPath(arg_22_0)
	local var_22_0, var_22_1 = arg_22_0._ctrlInst:getPassedPoints()
	local var_22_2
	local var_22_3
	local var_22_4 = {}

	for iter_22_0 = 1, var_22_0 and #var_22_0 or 0 do
		local var_22_5 = var_22_0[iter_22_0]
		local var_22_6 = var_22_1[iter_22_0]

		if var_22_2 ~= nil then
			local var_22_7 = PuzzleMazeHelper.getFromToDir(var_22_2, var_22_3, var_22_5, var_22_6)

			if var_22_7 then
				local var_22_8 = PuzzleMazeHelper.getLineKey(var_22_2, var_22_3, var_22_5, var_22_6)
				local var_22_9 = arg_22_0:getOrCreatePathLine(PuzzleEnum.LineType.Path, var_22_2, var_22_3, var_22_5, var_22_6)

				var_22_9:onCrossFull(var_22_7)
				var_22_9:onAlert(arg_22_0._alertType)

				var_22_4[var_22_8] = true
			else
				logNormal(string.format("error dir in (%s,%s,%s,%s)", var_22_2, var_22_3, var_22_5, var_22_6))
			end
		end

		var_22_2, var_22_3 = var_22_5, var_22_6
	end

	for iter_22_1, iter_22_2 in pairs(arg_22_0._pathLineMap) do
		if not var_22_4[iter_22_1] then
			iter_22_2:clear()
		end
	end

	arg_22_0._ctrlInst:resetLineDirty()
end

function var_0_0.syncDragLine(arg_23_0)
	local var_23_0 = false
	local var_23_1, var_23_2, var_23_3, var_23_4 = arg_23_0._ctrlInst:getProgressLine()

	if not arg_23_0._ctrlInst:isBackward(var_23_1, var_23_2) then
		local var_23_5 = arg_23_0._ctrlInst:getAlertMap()

		for iter_23_0, iter_23_1 in pairs(var_23_5) do
			return false
		end
	end

	local var_23_6 = var_23_3 or var_23_4

	if var_23_1 and var_23_2 and var_23_6 then
		local var_23_7, var_23_8 = arg_23_0._ctrlInst:getLastPos()
		local var_23_9, var_23_10, var_23_11, var_23_12 = PuzzleMazeHelper.formatPos(var_23_7, var_23_8, var_23_1, var_23_2)

		if arg_23_0._curDragLine.x1 ~= var_23_9 or arg_23_0._curDragLine.y1 ~= var_23_10 or arg_23_0._curDragLine.x2 ~= var_23_11 or arg_23_0._curDragLine.y2 ~= var_23_12 then
			arg_23_0._curDragLine.x1, arg_23_0._curDragLine.y1, arg_23_0._curDragLine.x2, arg_23_0._curDragLine.y2 = var_23_9, var_23_10, var_23_11, var_23_12
			var_23_0 = true

			arg_23_0:cleanDragLine()
		end

		local var_23_13 = PuzzleMazeHelper.getFromToDir(var_23_7, var_23_8, var_23_1, var_23_2)

		arg_23_0:getOrCreatePawnObj():setDir(var_23_13)
		arg_23_0:getOrCreatePathLine(PuzzleEnum.LineType.Path, var_23_9, var_23_10, var_23_11, var_23_12):onCrossHalf(var_23_13, var_23_6)

		return var_23_0
	end

	return false
end

function var_0_0.syncAlertObjs(arg_24_0)
	arg_24_0:recycleAlertObjs()

	arg_24_0._alertType = PuzzleEnum.MazeAlertType.None

	local var_24_0 = arg_24_0._ctrlInst:getAlertMap()

	if var_24_0 then
		for iter_24_0, iter_24_1 in pairs(var_24_0) do
			arg_24_0:onTriggerAlert(iter_24_1, iter_24_0)

			arg_24_0._alertType = iter_24_1

			return
		end
	end
end

function var_0_0.onTriggerAlert(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0:getOrCreateAlertObj(arg_25_1):onEnable(arg_25_1, arg_25_2)

	local var_25_0 = arg_25_0:getAlertTriggerFunc(arg_25_1)

	if var_25_0 then
		var_25_0(arg_25_0, arg_25_2)
	end
end

function var_0_0.registerAlertTriggerFunc(arg_26_0, arg_26_1, arg_26_2)
	if not arg_26_1 or not arg_26_2 then
		logError("注册警告触发方法时警告类型及回调方法不可为空")

		return
	end

	if arg_26_0._alertTriggerFuncMap[arg_26_1] then
		logError("注册了重复的警告执行方法 :" .. tostring(arg_26_1))

		return
	end

	arg_26_0._alertTriggerFuncMap[arg_26_1] = arg_26_2
end

function var_0_0.getAlertTriggerFunc(arg_27_0, arg_27_1)
	if not arg_27_1 then
		return
	end

	return arg_27_0._alertTriggerFuncMap and arg_27_0._alertTriggerFuncMap[arg_27_1]
end

function var_0_0.onBeginDragHandler(arg_28_0, arg_28_1, arg_28_2)
	if not arg_28_0:canTouch() then
		arg_28_0:onBeginDragFailed(arg_28_2)

		return
	end

	arg_28_0:onBeginDragSucc(arg_28_2)
end

function var_0_0.onDragHandler(arg_29_0, arg_29_1, arg_29_2)
	if not arg_29_0:canTouch() then
		return
	end

	if arg_29_0._isPawnMoving then
		local var_29_0 = arg_29_0:getDragGo()
		local var_29_1 = recthelper.screenPosToAnchorPos(arg_29_2.position, var_29_0.transform)

		arg_29_0:onDrag_StartProcessPos(arg_29_2, var_29_1)
		arg_29_0:onDrag_EndProcessPos(arg_29_2, var_29_1)
	end
end

function var_0_0.onDrag_StartProcessPos(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0, var_30_1 = arg_30_0._modelInst:getClosePosByTouchPos(arg_30_2.x, arg_30_2.y)

	if var_30_0 ~= -1 then
		arg_30_0._ctrlInst:goPassPos(var_30_0, var_30_1)
	else
		local var_30_2, var_30_3, var_30_4, var_30_5, var_30_6, var_30_7, var_30_8 = arg_30_0._modelInst:getLineFieldByTouchPos(arg_30_2.x, arg_30_2.y)

		if var_30_2 then
			arg_30_0._ctrlInst:goPassLine(var_30_3, var_30_4, var_30_5, var_30_6, var_30_7, var_30_8)
		end
	end
end

function var_0_0.onDrag_EndProcessPos(arg_31_0, arg_31_1, arg_31_2)
	arg_31_0:onDrag_SyncPawn(arg_31_1, arg_31_2)
	arg_31_0:onDrag_SyncPath(arg_31_1, arg_31_2)
end

function var_0_0.onDrag_SyncPath(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0._ctrlInst:isLineDirty()

	if var_32_0 then
		arg_32_0:syncPath()
		arg_32_0:syncAlertObjs()
		arg_32_0:syncCheckPoints()
	end

	local var_32_1 = arg_32_0:syncDragLine()

	if not var_32_0 and var_32_1 then
		arg_32_0:syncPath()
	end

	if var_32_0 then
		arg_32_0:checkGameFinished()
	end
end

function var_0_0.onEndDragHandler(arg_33_0, arg_33_1, arg_33_2)
	if not arg_33_0:canTouch() then
		return
	end

	if arg_33_0._isPawnMoving then
		arg_33_0._isPawnMoving = false

		if arg_33_0._ctrlInst:hasAlertObj() then
			arg_33_0:onEndDrag_HasAlert()
		else
			arg_33_0:onEndDrag_NoneAlert()
		end
	end
end

function var_0_0.cleanDragLine(arg_34_0)
	for iter_34_0, iter_34_1 in pairs(arg_34_0._pathLineMap) do
		local var_34_0 = iter_34_1:getProgress()

		if var_34_0 <= 0.999 and var_34_0 >= 0.01 then
			iter_34_1:clear()
		end
	end
end

function var_0_0.syncCheckPoints(arg_35_0)
	local var_35_0 = arg_35_0._modelInst:getList()
	local var_35_1 = {}
	local var_35_2 = 0

	for iter_35_0, iter_35_1 in ipairs(var_35_0) do
		local var_35_3 = arg_35_0:getOrCreateObject(iter_35_1)

		if iter_35_1.objType == PuzzleEnum.MazeObjType.CheckPoint and arg_35_0._ctrlInst:alreadyCheckPoint(iter_35_1) then
			table.insert(var_35_1, tostring(iter_35_1))

			var_35_2 = var_35_2 + 1
		end

		arg_35_0:tickObjBehaviour(iter_35_1, var_35_3)
	end

	local var_35_4 = table.concat(var_35_1)

	arg_35_0:onEndRefreshCheckPoint(arg_35_0._lastCheckSum, var_35_4, arg_35_0._lastCheckCount, var_35_2)
end

function var_0_0.tickObjBehaviour(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = false

	if arg_36_1.objType ~= PuzzleEnum.MazeObjType.Block then
		var_36_0 = arg_36_0._ctrlInst:alreadyPassed(arg_36_1.x, arg_36_1.y)
	end

	local var_36_1 = arg_36_2:HasEnter()

	if var_36_1 then
		if var_36_0 then
			arg_36_2:onAlreadyEnter()
		else
			arg_36_2:onExit()
		end
	elseif not var_36_1 and var_36_0 then
		arg_36_2:onEnter()
	end
end

function var_0_0.checkGameFinished(arg_37_0)
	if arg_37_0:isGameFinished() then
		return
	end

	if arg_37_0:checkIsGameFailed() then
		arg_37_0:onGameFailed()

		return
	end

	if arg_37_0:checkIsGameSucc() then
		arg_37_0:onGameSucc()

		return
	end
end

function var_0_0.onBeginDragSucc(arg_38_0, arg_38_1)
	local var_38_0, var_38_1 = arg_38_0._ctrlInst:getLastPos()
	local var_38_2, var_38_3 = arg_38_0:getPawnPosByPointerEventData(arg_38_1)

	if var_38_2 ~= -1 and var_38_0 == var_38_2 and var_38_1 == var_38_3 then
		arg_38_0:onBeginDrag_SyncPawn()
	end
end

function var_0_0.getPawnPosByPointerEventData(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0:getDragGo()
	local var_39_1 = recthelper.screenPosToAnchorPos(arg_39_1.position, var_39_0.transform)
	local var_39_2, var_39_3 = arg_39_0._modelInst:getClosePosByTouchPos(var_39_1.x - PuzzleEnum.mazeMonsterTouchOffsetX, var_39_1.y - PuzzleEnum.mazeMonsterHeight)

	return var_39_2, var_39_3
end

function var_0_0.onEndDrag_HasAlert(arg_40_0)
	arg_40_0._ctrlInst:goBackPos()
	arg_40_0:onEndDrag_SyncPawn()
	arg_40_0:syncAlertObjs()
	arg_40_0:syncPath()
	arg_40_0:cleanDragLine()
	arg_40_0:syncCheckPoints()
end

function var_0_0.onEndDrag_NoneAlert(arg_41_0)
	arg_41_0:onEndDrag_SyncPawn()
	arg_41_0:syncPath()
	arg_41_0:cleanDragLine()
	arg_41_0:checkGameFinished()
end

function var_0_0.onBeginDrag_SyncPawn(arg_42_0)
	arg_42_0._isPawnMoving = true

	arg_42_0:getOrCreatePawnObj():onBeginDrag()
	arg_42_0._ctrlInst:dispatchEvent(PuzzleEvent.OnBeginDragPawn)
end

function var_0_0.onDrag_SyncPawn(arg_43_0, arg_43_1, arg_43_2)
	arg_43_0:getOrCreatePawnObj():onDraging(arg_43_2.x, arg_43_2.y)
end

function var_0_0.onEndDrag_SyncPawn(arg_44_0)
	local var_44_0, var_44_1 = arg_44_0._ctrlInst:getLastPos()
	local var_44_2, var_44_3 = arg_44_0._modelInst:getObjectAnchor(var_44_0, var_44_1)

	arg_44_0:getOrCreatePawnObj():onEndDrag(var_44_2, var_44_3)
	arg_44_0._ctrlInst:dispatchEvent(PuzzleEvent.OnEndDragPawn)
end

function var_0_0.canTouch(arg_45_0)
	return arg_45_0._canTouch
end

function var_0_0.setCanTouch(arg_46_0, arg_46_1)
	arg_46_0._canTouch = arg_46_1
end

function var_0_0.onBeginDragFailed(arg_47_0, arg_47_1)
	return
end

function var_0_0.onEndRefreshCheckPoint(arg_48_0, arg_48_1, arg_48_2, arg_48_3, arg_48_4)
	arg_48_0._lastCheckSum = arg_48_2
	arg_48_0._lastCheckCount = arg_48_4
end

function var_0_0.checkIsGameSucc(arg_49_0)
	return arg_49_0._ctrlInst:isGameClear()
end

function var_0_0.onGameSucc(arg_50_0)
	if arg_50_0._isPawnMoving then
		arg_50_0:onEndDrag_SyncPawn()
	end

	arg_50_0:setCanTouch(false)
	arg_50_0:setGameFinished(true)
	arg_50_0._modelInst:setGameStatus(true)

	local var_50_0 = arg_50_0._modelInst:getElementCo()
	local var_50_1 = var_50_0 and var_50_0.id
	local var_50_2 = DungeonModel.instance:isFinishElementList(var_50_0)

	if var_50_1 and not var_50_2 then
		DungeonRpc.instance:sendMapElementRequest(var_50_1)
	end

	arg_50_0._ctrlInst:dispatchEvent(PuzzleEvent.OnGameFinished, var_50_1)
end

function var_0_0.checkIsGameFailed(arg_51_0)
	return
end

function var_0_0.onGameFailed(arg_52_0)
	arg_52_0:setGameFinished(true)
end

function var_0_0.isGameFinished(arg_53_0)
	return arg_53_0._isFinished
end

function var_0_0.setGameFinished(arg_54_0, arg_54_1)
	arg_54_0._isFinished = arg_54_1
end

function var_0_0.getModelInst(arg_55_0)
	return
end

function var_0_0.getCtrlInst(arg_56_0)
	return
end

function var_0_0.getDragGo(arg_57_0)
	return
end

function var_0_0.getLineParentGo(arg_58_0)
	return
end

function var_0_0.getPawnParentGo(arg_59_0)
	return
end

function var_0_0.getObjectParentGo(arg_60_0)
	return
end

function var_0_0.getAlertParentGo(arg_61_0)
	return
end

function var_0_0.getMazeObjCls(arg_62_0, arg_62_1, arg_62_2, arg_62_3)
	return
end

function var_0_0.getPawnObjCls(arg_63_0)
	return
end

function var_0_0.getLineObjCls(arg_64_0, arg_64_1)
	return
end

function var_0_0.getAlertObjCls(arg_65_0, arg_65_1)
	return
end

function var_0_0.getPawnResUrl(arg_66_0)
	return
end

function var_0_0.getLineResUrl(arg_67_0, arg_67_1)
	return
end

function var_0_0.getObjectResUrl(arg_68_0, arg_68_1, arg_68_2, arg_68_3)
	return
end

function var_0_0.getAlertResUrl(arg_69_0, arg_69_1)
	return
end

function var_0_0.getLineTemplateFillOrigin(arg_70_0)
	return
end

return var_0_0
