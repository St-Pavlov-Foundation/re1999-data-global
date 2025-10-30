module("modules.logic.versionactivity3_0.karong.view.base.KaRongDrawBaseView", package.seeall)

local var_0_0 = class("KaRongDrawBaseView", BaseView)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._curDragLine = {
		x2 = 0,
		y2 = 0,
		x1 = 0,
		y1 = 0
	}
	arg_1_0._objectMap = {}
	arg_1_0._pathLineMap = {}
	arg_1_0._mapLineSet = {}
	arg_1_0._alertObjList = {}
	arg_1_0._alertFreePool = {}
	arg_1_0._modelInst = arg_1_0:getModelInst()
	arg_1_0._ctrlInst = arg_1_0:getCtrlInst()
	arg_1_0._alertTriggerFuncMap = {}

	local var_1_0 = arg_1_0:getDragGo()

	if var_1_0 then
		arg_1_0._drag = SLFramework.UGUI.UIDragListener.Get(var_1_0)

		arg_1_0._drag:AddDragBeginListener(arg_1_0.onBeginDragHandler, arg_1_0)
		arg_1_0._drag:AddDragListener(arg_1_0.onDragHandler, arg_1_0)
		arg_1_0._drag:AddDragEndListener(arg_1_0.onEndDragHandler, arg_1_0)
	end
end

function var_0_0.onDestroyView(arg_2_0)
	if arg_2_0._drag then
		arg_2_0._drag:RemoveDragBeginListener()
		arg_2_0._drag:RemoveDragListener()
		arg_2_0._drag:RemoveDragEndListener()

		arg_2_0._drag = nil
	end

	arg_2_0:destroyPawnObj()
	arg_2_0:removeAllPathLines()
	arg_2_0:removeAllMapLines()
	arg_2_0:removeAllObjects()
end

function var_0_0.startGame(arg_3_0)
	arg_3_0._hasAvatar = arg_3_0._modelInst:getAvatarStartPos() and true or false

	arg_3_0:setCanTouch(true)
	arg_3_0:setGameFinished(false)
	arg_3_0:removeAllPathLines()
	arg_3_0:removeAllMapLines()
	arg_3_0:removeAllObjects()
	arg_3_0:initAllMapLines()
	arg_3_0:initAllObjects()
	arg_3_0:initPawn()
	arg_3_0:syncPath()
	arg_3_0:syncAlertObjs()
	arg_3_0:syncCheckPoints()
	arg_3_0._ctrlInst:dispatchEvent(KaRongDrawEvent.InitGameDone)
end

function var_0_0.restartGame(arg_4_0)
	arg_4_0._ctrlInst:restartGame()
	arg_4_0:startGame()
end

function var_0_0.initAllMapLines(arg_5_0)
	local var_5_0, var_5_1 = arg_5_0._modelInst:getGameSize()

	for iter_5_0 = 1, var_5_0 + 1 do
		for iter_5_1 = 1, var_5_1 + 1 do
			if iter_5_0 <= var_5_0 then
				arg_5_0:initMapLine(iter_5_0, iter_5_1, iter_5_0 + 1, iter_5_1)
			end

			if iter_5_1 <= var_5_1 then
				arg_5_0:initMapLine(iter_5_0, iter_5_1, iter_5_0, iter_5_1 + 1)
			end
		end
	end
end

function var_0_0.initMapLine(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_1, arg_6_2, arg_6_3, arg_6_4 = KaRongDrawHelper.formatPos(arg_6_1, arg_6_2, arg_6_3, arg_6_4)

	local var_6_0 = KaRongDrawHelper.getLineKey(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_1 = arg_6_0._mapLineSet[var_6_0]

	if not var_6_1 then
		local var_6_2 = arg_6_0:getLineObjCls(KaRongDrawEnum.LineType.Map)
		local var_6_3 = arg_6_0:getLineResUrl(KaRongDrawEnum.LineType.Map)
		local var_6_4 = arg_6_0:getLineParentGo(KaRongDrawEnum.LineType.Map)
		local var_6_5 = arg_6_0:getResInst(var_6_3, var_6_4, var_6_0)
		local var_6_6, var_6_7 = arg_6_0:getLineTemplateFillOrigin()

		var_6_1 = var_6_2.New(var_6_5, var_6_6, var_6_7)
		arg_6_0._mapLineSet[var_6_0] = var_6_1
	end

	var_6_1:onInit(arg_6_1, arg_6_2, arg_6_3, arg_6_4)

	return var_6_1
end

function var_0_0.getOrCreatePathLine(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	arg_7_2, arg_7_3, arg_7_4, arg_7_5 = KaRongDrawHelper.formatPos(arg_7_2, arg_7_3, arg_7_4, arg_7_5)

	local var_7_0 = KaRongDrawHelper.getLineKey(arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	local var_7_1 = arg_7_0._pathLineMap[var_7_0]

	if not var_7_1 then
		local var_7_2 = arg_7_0:getLineObjCls(arg_7_1)
		local var_7_3 = arg_7_0:getLineResUrl(arg_7_1)
		local var_7_4 = arg_7_0:getLineParentGo(arg_7_1)
		local var_7_5 = arg_7_0:getResInst(var_7_3, var_7_4, var_7_0)
		local var_7_6, var_7_7 = arg_7_0:getLineTemplateFillOrigin()

		var_7_1 = var_7_2.New(var_7_5, var_7_6, var_7_7)

		var_7_1:onInit(arg_7_2, arg_7_3, arg_7_4, arg_7_5)

		arg_7_0._pathLineMap[var_7_0] = var_7_1
	end

	return var_7_1
end

function var_0_0.removeAllPathLines(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0._pathLineMap) do
		iter_8_1:destroy()

		arg_8_0._pathLineMap[iter_8_0] = nil
	end
end

function var_0_0.removeAllMapLines(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0._mapLineSet) do
		iter_9_1:destroy()

		arg_9_0._mapLineSet[iter_9_0] = nil
	end
end

function var_0_0.getOrCreateObject(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.key
	local var_10_1 = arg_10_0._objectMap[var_10_0]

	if not var_10_1 then
		local var_10_2 = arg_10_0:getObjectParentGo(arg_10_1.objType)
		local var_10_3 = arg_10_0:getObjectResUrl(arg_10_1.objType, arg_10_1.subType, arg_10_1.group)
		local var_10_4 = arg_10_0:getResInst(var_10_3, var_10_2, var_10_0)

		var_10_1 = arg_10_0:getMazeObjCls(arg_10_1.objType, arg_10_1.subType, arg_10_1.group).New(var_10_4)
		arg_10_0._objectMap[var_10_0] = var_10_1
	end

	return var_10_1
end

function var_0_0.removeAllObjects(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0._objectMap) do
		iter_11_1:destroy()

		arg_11_0._objectMap[iter_11_0] = nil
	end
end

function var_0_0.initAllObjects(arg_12_0)
	local var_12_0 = arg_12_0._modelInst:getList()

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		arg_12_0:getOrCreateObject(iter_12_1):onInit(iter_12_1)
	end
end

function var_0_0.getOrCreateAlertObj(arg_13_0, arg_13_1)
	local var_13_0

	if #arg_13_0._alertFreePool <= 0 then
		local var_13_1 = arg_13_0:getAlertParentGo(arg_13_1)
		local var_13_2 = arg_13_0:getAlertResUrl(arg_13_1)
		local var_13_3 = arg_13_0:getAlertObjCls(arg_13_1)
		local var_13_4 = arg_13_0._alertObjList and #arg_13_0._alertObjList or 0
		local var_13_5 = string.format("alert_%s", var_13_4 + 1)
		local var_13_6 = arg_13_0:getResInst(var_13_2, var_13_1, var_13_5)

		var_13_0 = var_13_3.New(var_13_6)
	else
		var_13_0 = table.remove(arg_13_0._alertFreePool)
	end

	table.insert(arg_13_0._alertObjList, var_13_0)

	return var_13_0
end

function var_0_0.recycleAlertObjs(arg_14_0)
	for iter_14_0 = #arg_14_0._alertObjList, 1, -1 do
		local var_14_0 = arg_14_0._alertObjList[iter_14_0]

		var_14_0:onDisable()
		table.insert(arg_14_0._alertFreePool, var_14_0)

		arg_14_0._alertObjList[iter_14_0] = nil
	end
end

function var_0_0.initPawn(arg_15_0)
	local var_15_0, var_15_1 = arg_15_0._ctrlInst:getLastPos()

	if var_15_0 ~= nil then
		local var_15_2, var_15_3 = arg_15_0._modelInst:getObjectAnchor(var_15_0, var_15_1)

		arg_15_0:getOrCreatePawnObj():onInit(var_15_2, var_15_3)
	end

	local var_15_4 = arg_15_0._modelInst:getAvatarStartPos()

	if var_15_4 then
		local var_15_5, var_15_6 = arg_15_0._modelInst:getObjectAnchor(var_15_4.x, var_15_4.y)

		arg_15_0:getOrCreateAvatar():onInit(var_15_5, var_15_6)
	end
end

function var_0_0.getOrCreatePawnObj(arg_16_0)
	local var_16_0 = arg_16_0._objPawn

	if not var_16_0 then
		local var_16_1 = arg_16_0:getPawnResUrl()
		local var_16_2 = arg_16_0:getPawnParentGo()
		local var_16_3 = arg_16_0:getResInst(var_16_1, var_16_2, "pawn")

		gohelper.setAsLastSibling(var_16_3)

		var_16_0 = arg_16_0:getPawnObjCls().New(var_16_3)
		arg_16_0._objPawn = var_16_0
	end

	return var_16_0
end

function var_0_0.getOrCreateAvatar(arg_17_0)
	if not arg_17_0._objAvatar then
		local var_17_0 = arg_17_0:getPawnResUrl()
		local var_17_1 = arg_17_0:getPawnParentGo()
		local var_17_2 = arg_17_0:getResInst(var_17_0, var_17_1, "avatar")

		gohelper.setAsLastSibling(var_17_2)

		arg_17_0._objAvatar = arg_17_0:getPawnObjCls().New(var_17_2, true)
	end

	return arg_17_0._objAvatar
end

function var_0_0.destroyPawnObj(arg_18_0)
	if arg_18_0._objPawn then
		arg_18_0._objPawn:destroy()
	end

	if arg_18_0._objAvatar then
		arg_18_0._objAvatar:destroy()
	end
end

function var_0_0.syncPath(arg_19_0)
	local var_19_0, var_19_1 = arg_19_0._ctrlInst:getPassedPoints()
	local var_19_2
	local var_19_3
	local var_19_4 = {}

	for iter_19_0 = 1, var_19_0 and #var_19_0 or 0 do
		local var_19_5 = var_19_0[iter_19_0]
		local var_19_6 = var_19_1[iter_19_0]

		if var_19_2 ~= nil then
			local var_19_7 = KaRongDrawHelper.getFromToDir(var_19_2, var_19_3, var_19_5, var_19_6)

			if var_19_7 then
				local var_19_8 = KaRongDrawHelper.getLineKey(var_19_2, var_19_3, var_19_5, var_19_6)
				local var_19_9 = arg_19_0:getOrCreatePathLine(KaRongDrawEnum.LineType.Path, var_19_2, var_19_3, var_19_5, var_19_6)

				var_19_9:onCrossFull(var_19_7)
				var_19_9:onAlert(arg_19_0._alertType)

				var_19_4[var_19_8] = true
			end
		end

		var_19_2, var_19_3 = var_19_5, var_19_6
	end

	local var_19_10 = arg_19_0._ctrlInst:getAvatarPassPoints()

	if var_19_10 then
		local var_19_11, var_19_12

		for iter_19_1, iter_19_2 in ipairs(var_19_10) do
			if var_19_11 ~= nil then
				local var_19_13 = KaRongDrawHelper.getFromToDir(var_19_11, var_19_12, iter_19_2.x, iter_19_2.y)

				if var_19_13 then
					local var_19_14 = KaRongDrawHelper.getLineKey(var_19_11, var_19_12, iter_19_2.x, iter_19_2.y)
					local var_19_15 = arg_19_0:getOrCreatePathLine(KaRongDrawEnum.LineType.Path, var_19_11, var_19_12, iter_19_2.x, iter_19_2.y)

					var_19_15:onCrossFull(var_19_13)
					var_19_15:onAlert(arg_19_0._alertType)

					var_19_4[var_19_14] = true
				end
			end

			var_19_11, var_19_12 = iter_19_2.x, iter_19_2.y
		end
	end

	for iter_19_3, iter_19_4 in pairs(arg_19_0._pathLineMap) do
		if not var_19_4[iter_19_3] then
			iter_19_4:clear()
		end
	end

	arg_19_0._ctrlInst:resetLineDirty()
end

function var_0_0.syncDragLine(arg_20_0)
	local var_20_0 = false
	local var_20_1, var_20_2, var_20_3, var_20_4 = arg_20_0._ctrlInst:getProgressLine()

	if not arg_20_0._ctrlInst:isBackward(var_20_1, var_20_2) then
		local var_20_5 = arg_20_0._ctrlInst:getAlertMap()

		if next(var_20_5) then
			return false
		end
	end

	local var_20_6 = var_20_3 or var_20_4

	if var_20_1 and var_20_2 and var_20_6 then
		local var_20_7, var_20_8 = arg_20_0._ctrlInst:getLastPos()
		local var_20_9, var_20_10, var_20_11, var_20_12 = KaRongDrawHelper.formatPos(var_20_7, var_20_8, var_20_1, var_20_2)

		if arg_20_0._curDragLine.x1 ~= var_20_9 or arg_20_0._curDragLine.y1 ~= var_20_10 or arg_20_0._curDragLine.x2 ~= var_20_11 or arg_20_0._curDragLine.y2 ~= var_20_12 then
			arg_20_0._curDragLine.x1, arg_20_0._curDragLine.y1, arg_20_0._curDragLine.x2, arg_20_0._curDragLine.y2 = var_20_9, var_20_10, var_20_11, var_20_12
			var_20_0 = true

			arg_20_0:cleanDragLine()
		end

		local var_20_13 = KaRongDrawHelper.getFromToDir(var_20_7, var_20_8, var_20_1, var_20_2)

		arg_20_0:getOrCreatePawnObj():setDir(var_20_13)

		if arg_20_0._hasAvatar then
			arg_20_0:getOrCreateAvatar():setDir(var_20_13)
		end

		arg_20_0:getOrCreatePathLine(KaRongDrawEnum.LineType.Path, var_20_9, var_20_10, var_20_11, var_20_12):onCrossHalf(var_20_13, var_20_6)

		return var_20_0
	end

	return false
end

function var_0_0.syncAlertObjs(arg_21_0)
	arg_21_0:recycleAlertObjs()

	arg_21_0._alertType = KaRongDrawEnum.MazeAlertType.None

	local var_21_0 = arg_21_0._ctrlInst:getAlertMap()

	if var_21_0 then
		for iter_21_0, iter_21_1 in pairs(var_21_0) do
			arg_21_0:onTriggerAlert(iter_21_1, iter_21_0)

			arg_21_0._alertType = iter_21_1

			return
		end
	end
end

function var_0_0.onTriggerAlert(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0:getOrCreateAlertObj(arg_22_1):onEnable(arg_22_1, arg_22_2)

	local var_22_0 = arg_22_0:getAlertTriggerFunc(arg_22_1)

	if var_22_0 then
		var_22_0(arg_22_0, arg_22_2)
	end
end

function var_0_0.registerAlertTriggerFunc(arg_23_0, arg_23_1, arg_23_2)
	if not arg_23_1 or not arg_23_2 then
		logError("注册警告触发方法时警告类型及回调方法不可为空")

		return
	end

	if arg_23_0._alertTriggerFuncMap[arg_23_1] then
		logError("注册了重复的警告执行方法 :" .. tostring(arg_23_1))

		return
	end

	arg_23_0._alertTriggerFuncMap[arg_23_1] = arg_23_2
end

function var_0_0.getAlertTriggerFunc(arg_24_0, arg_24_1)
	if not arg_24_1 then
		return
	end

	return arg_24_0._alertTriggerFuncMap and arg_24_0._alertTriggerFuncMap[arg_24_1]
end

function var_0_0.onBeginDragHandler(arg_25_0, arg_25_1, arg_25_2)
	if not arg_25_0._canTouch then
		GameFacade.showToast(ToastEnum.DungeonPuzzle)

		return
	end

	local var_25_0, var_25_1 = arg_25_0._ctrlInst:getLastPos()
	local var_25_2, var_25_3 = arg_25_0:getPawnPosByPointerEventData(arg_25_2)

	if var_25_2 ~= -1 and var_25_0 == var_25_2 and var_25_1 == var_25_3 then
		arg_25_0._isPawnMoving = true

		arg_25_0:getOrCreatePawnObj():onBeginDrag()
		arg_25_0._ctrlInst:dispatchEvent(KaRongDrawEvent.OnBeginDragPawn)
	end
end

function var_0_0.onDragHandler(arg_26_0, arg_26_1, arg_26_2)
	if not arg_26_0._canTouch then
		return
	end

	if arg_26_0._isPawnMoving then
		local var_26_0 = false
		local var_26_1 = arg_26_0:getDragGo()
		local var_26_2 = recthelper.screenPosToAnchorPos(arg_26_2.position, var_26_1.transform)
		local var_26_3, var_26_4 = arg_26_0._modelInst:getClosePosByTouchPos(var_26_2.x, var_26_2.y)

		if var_26_3 ~= -1 then
			var_26_0 = arg_26_0._ctrlInst:goPassPos(var_26_3, var_26_4)
		else
			local var_26_5, var_26_6, var_26_7, var_26_8, var_26_9, var_26_10, var_26_11 = arg_26_0._modelInst:getLineFieldByTouchPos(var_26_2.x, var_26_2.y)

			if var_26_5 then
				arg_26_0._ctrlInst:goPassLine(var_26_6, var_26_7, var_26_8, var_26_9, var_26_10, var_26_11)
			end
		end

		arg_26_0:getOrCreatePawnObj():onDraging(var_26_2.x, var_26_2.y)
		arg_26_0:onDrag_SyncPath(arg_26_2, var_26_2)

		if var_26_0 then
			arg_26_0:onEndDragHandler()
		end
	end
end

function var_0_0.onDrag_SyncPath(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0._ctrlInst:isLineDirty()

	if var_27_0 then
		arg_27_0:syncPath()
		arg_27_0:syncAlertObjs()
		arg_27_0:syncCheckPoints()
	end

	local var_27_1 = arg_27_0:syncDragLine()

	if not var_27_0 and var_27_1 then
		arg_27_0:syncPath()
	end

	if var_27_0 then
		arg_27_0:checkGameFinished()
	end
end

function var_0_0.onEndDragHandler(arg_28_0, arg_28_1, arg_28_2)
	if not arg_28_0._canTouch then
		return
	end

	if arg_28_0._isPawnMoving then
		arg_28_0._isPawnMoving = false

		if arg_28_0._ctrlInst:hasAlertObj() then
			arg_28_0:onEndDrag_HasAlert()
		else
			arg_28_0:onEndDrag_NoneAlert()
		end
	end
end

function var_0_0.onEndDrag_HasAlert(arg_29_0)
	arg_29_0._ctrlInst:goBackPos()
	arg_29_0:onEndDrag_SyncPawn()
	arg_29_0:syncAlertObjs()
	arg_29_0:syncPath()
	arg_29_0:cleanDragLine()
	arg_29_0:syncCheckPoints()
end

function var_0_0.onEndDrag_NoneAlert(arg_30_0)
	arg_30_0:onEndDrag_SyncPawn()
	arg_30_0:syncPath()
	arg_30_0:cleanDragLine()
	arg_30_0:checkGameFinished()
end

function var_0_0.cleanDragLine(arg_31_0)
	for iter_31_0, iter_31_1 in pairs(arg_31_0._pathLineMap) do
		local var_31_0 = iter_31_1:getProgress()

		if var_31_0 <= 0.999 and var_31_0 >= 0.01 then
			iter_31_1:clear()
		end
	end
end

function var_0_0.syncCheckPoints(arg_32_0)
	local var_32_0 = arg_32_0._modelInst:getList()
	local var_32_1 = {}
	local var_32_2 = 0

	for iter_32_0, iter_32_1 in ipairs(var_32_0) do
		local var_32_3 = arg_32_0:getOrCreateObject(iter_32_1)

		if iter_32_1.objType == KaRongDrawEnum.MazeObjType.CheckPoint and arg_32_0._ctrlInst:alreadyCheckPoint(iter_32_1) then
			table.insert(var_32_1, tostring(iter_32_1))

			var_32_2 = var_32_2 + 1
		end

		arg_32_0:tickObjBehaviour(iter_32_1, var_32_3)
	end

	local var_32_4 = table.concat(var_32_1)

	if arg_32_0._lastCheckSum and arg_32_0._lastCheckSum ~= var_32_4 and var_32_2 >= arg_32_0._lastCheckCount then
		AudioMgr.instance:trigger(AudioEnum3_0.ActKaRong.play_ui_lushang_arrival)
	end

	arg_32_0._lastCheckSum = var_32_4
	arg_32_0._lastCheckCount = var_32_2
end

function var_0_0.tickObjBehaviour(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = false

	if not arg_33_1.obstacle then
		var_33_0 = arg_33_0._ctrlInst:alreadyPassed(arg_33_1.x, arg_33_1.y) or arg_33_0._ctrlInst:alreadyAvatarPassed(arg_33_1.x, arg_33_1.y)
	end

	if arg_33_2.isEnter then
		if not var_33_0 then
			arg_33_2:onExit()
		end
	elseif var_33_0 then
		arg_33_2:onEnter()
	end
end

function var_0_0.checkGameFinished(arg_34_0)
	if arg_34_0:isGameFinished() then
		return
	end

	if arg_34_0._ctrlInst:isGameClear() then
		arg_34_0:onGameSucc()

		return
	end
end

function var_0_0.getPawnPosByPointerEventData(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0:getDragGo()
	local var_35_1 = recthelper.screenPosToAnchorPos(arg_35_1.position, var_35_0.transform)
	local var_35_2, var_35_3 = arg_35_0._modelInst:getClosePosByTouchPos(var_35_1.x - KaRongDrawEnum.mazeMonsterTouchOffsetX, var_35_1.y - KaRongDrawEnum.mazeMonsterHeight)

	return var_35_2, var_35_3
end

function var_0_0.onEndDrag_SyncPawn(arg_36_0)
	local var_36_0, var_36_1 = arg_36_0._ctrlInst:getLastPos()
	local var_36_2, var_36_3 = arg_36_0._modelInst:getObjectAnchor(var_36_0, var_36_1)

	arg_36_0:getOrCreatePawnObj():onEndDrag(var_36_2, var_36_3)
	arg_36_0:_syncAvatar()
	arg_36_0._ctrlInst:dispatchEvent(KaRongDrawEvent.OnEndDragPawn)
end

function var_0_0.setCanTouch(arg_37_0, arg_37_1)
	arg_37_0._canTouch = arg_37_1
end

function var_0_0.onGameSucc(arg_38_0)
	if arg_38_0._isPawnMoving then
		arg_38_0:onEndDrag_SyncPawn()
	end

	arg_38_0:setCanTouch(false)
	arg_38_0:setGameFinished(true)
	arg_38_0._modelInst:setGameStatus(true)

	local var_38_0 = arg_38_0._modelInst:getElementCo()
	local var_38_1 = var_38_0 and var_38_0.id
	local var_38_2 = DungeonModel.instance:isFinishElementList(var_38_0)

	if var_38_1 and not var_38_2 then
		DungeonRpc.instance:sendMapElementRequest(var_38_1)
	end

	arg_38_0._ctrlInst:dispatchEvent(KaRongDrawEvent.OnGameFinished, var_38_1)
end

function var_0_0.isGameFinished(arg_39_0)
	return arg_39_0._isFinished
end

function var_0_0.setGameFinished(arg_40_0, arg_40_1)
	arg_40_0._isFinished = arg_40_1
end

function var_0_0.getModelInst(arg_41_0)
	return
end

function var_0_0.getCtrlInst(arg_42_0)
	return
end

function var_0_0.getDragGo(arg_43_0)
	return
end

function var_0_0.getLineParentGo(arg_44_0)
	return
end

function var_0_0.getPawnParentGo(arg_45_0)
	return
end

function var_0_0.getObjectParentGo(arg_46_0)
	return
end

function var_0_0.getAlertParentGo(arg_47_0)
	return
end

function var_0_0.getMazeObjCls(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	return
end

function var_0_0.getPawnObjCls(arg_49_0)
	return
end

function var_0_0.getLineObjCls(arg_50_0, arg_50_1)
	return
end

function var_0_0.getAlertObjCls(arg_51_0, arg_51_1)
	return
end

function var_0_0.getPawnResUrl(arg_52_0)
	return
end

function var_0_0.getLineResUrl(arg_53_0, arg_53_1)
	return
end

function var_0_0.getObjectResUrl(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	return
end

function var_0_0.getAlertResUrl(arg_55_0, arg_55_1)
	return
end

function var_0_0.getLineTemplateFillOrigin(arg_56_0)
	return
end

function var_0_0._syncAvatar(arg_57_0)
	local var_57_0 = arg_57_0._ctrlInst:getAvatarPos()

	if var_57_0 then
		local var_57_1, var_57_2 = arg_57_0._modelInst:getObjectAnchor(var_57_0.x, var_57_0.y)

		arg_57_0:getOrCreateAvatar():onEndDrag(var_57_1, var_57_2)
	end
end

return var_0_0
