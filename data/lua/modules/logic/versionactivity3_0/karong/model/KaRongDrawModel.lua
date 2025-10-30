module("modules.logic.versionactivity3_0.karong.model.KaRongDrawModel", package.seeall)

local var_0_0 = class("KaRongDrawModel", BaseModel)

function var_0_0.reInit(arg_1_0)
	arg_1_0:release()
end

function var_0_0.release(arg_2_0)
	arg_2_0._statusMap = nil
	arg_2_0._blockMap = nil
	arg_2_0._objMap = nil
	arg_2_0._objList = nil
	arg_2_0._startX = nil
	arg_2_0._startY = nil
	arg_2_0._endX = nil
	arg_2_0._endY = nil
	arg_2_0._lineMap = nil
	arg_2_0._interactCtrlMap = nil
	arg_2_0._elementCo = nil
	arg_2_0._interactPosX = nil
	arg_2_0._interactPosY = nil
	arg_2_0._effectDoneMap = nil
	arg_2_0._avatarStartPos = nil
	arg_2_0._avatarEndPos = nil
	arg_2_0._checkPoints = {}

	arg_2_0:clear()
end

function var_0_0.startGame(arg_3_0, arg_3_1)
	arg_3_0:release()
	arg_3_0:decode(arg_3_1.param)

	arg_3_0._elementCo = arg_3_1
end

function var_0_0.decode(arg_4_0, arg_4_1)
	arg_4_0._objMap = {}
	arg_4_0._blockMap = {}
	arg_4_0._lineMap = {}
	arg_4_0._interactCtrlMap = {}

	local var_4_0 = cjson.decode(arg_4_1)

	arg_4_0._width = var_4_0.width
	arg_4_0._height = var_4_0.height

	arg_4_0:decodeObj(arg_4_0._blockMap, var_4_0.blockMap)
	arg_4_0:decodeObj(arg_4_0._objMap, var_4_0.objMap)
	arg_4_0:initMapLineState(var_4_0)
	arg_4_0:findStartAndEndPos()
	arg_4_0:initConst()
end

function var_0_0.findStartAndEndPos(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._objMap) do
		if iter_5_1.objType == KaRongDrawEnum.MazeObjType.Start then
			if iter_5_1.subType == KaRongDrawEnum.MazeObjSubType.Default or iter_5_1.subType == KaRongDrawEnum.MazeObjSubType.Three then
				arg_5_0._startPosX = iter_5_1.x
				arg_5_0._startPosY = iter_5_1.y
			end

			if iter_5_1.subType == KaRongDrawEnum.MazeObjSubType.Two or iter_5_1.subType == KaRongDrawEnum.MazeObjSubType.Three then
				arg_5_0._avatarStartPos = Vector2.New(iter_5_1.x, iter_5_1.y)
			end
		elseif iter_5_1.objType == KaRongDrawEnum.MazeObjType.End then
			if iter_5_1.subType == KaRongDrawEnum.MazeObjSubType.Default or iter_5_1.subType == KaRongDrawEnum.MazeObjSubType.Three then
				arg_5_0._endPosX = iter_5_1.x
				arg_5_0._endPosY = iter_5_1.y
			end

			if iter_5_1.subType == KaRongDrawEnum.MazeObjSubType.Two or iter_5_1.subType == KaRongDrawEnum.MazeObjSubType.Three then
				arg_5_0._avatarEndPos = Vector2.New(iter_5_1.x, iter_5_1.y)
			end
		end
	end
end

function var_0_0.decodeObj(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_2 then
		return
	end

	for iter_6_0, iter_6_1 in pairs(arg_6_2) do
		local var_6_0 = string.splitToNumber(iter_6_1.key, "_")
		local var_6_1
		local var_6_2 = #var_6_0

		if var_6_2 <= 2 then
			var_6_1 = arg_6_0:createMOByPos(var_6_0[1], var_6_0[2], iter_6_1)

			if iter_6_1.type == KaRongDrawEnum.MazeObjType.CheckPoint then
				arg_6_0._checkPoints[#arg_6_0._checkPoints + 1] = var_6_1
			end
		elseif var_6_2 >= 4 then
			var_6_1 = arg_6_0:createMOByLine(var_6_0[1], var_6_0[2], var_6_0[3], var_6_0[4], iter_6_1)
		end

		arg_6_1[iter_6_1.key] = var_6_1
	end
end

function var_0_0.createMOByPos(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = KaRongDrawMO.New()

	var_7_0:initByPos(arg_7_1, arg_7_2, arg_7_3.type, arg_7_3.subType, arg_7_3.group, arg_7_3.priority, arg_7_3.iconUrl, arg_7_3.effects, arg_7_3.interactLines)
	arg_7_0:addAtLast(var_7_0)

	return var_7_0
end

function var_0_0.createMOByLine(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	local var_8_0 = KaRongDrawMO.New()

	var_8_0:initByLine(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5.type, arg_8_5.subType, arg_8_5.group, arg_8_5.priority, arg_8_5.iconUrl)
	arg_8_0:addAtLast(var_8_0)

	return var_8_0
end

function var_0_0.initMapLineState(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1 and arg_9_1.blockMap

	for iter_9_0, iter_9_1 in pairs(var_9_0 or {}) do
		local var_9_1 = iter_9_1.key

		arg_9_0._lineMap[var_9_1] = KaRongDrawEnum.LineState.Disconnect
	end

	local var_9_2 = arg_9_1 and arg_9_1.objMap or {}

	for iter_9_2, iter_9_3 in pairs(var_9_2) do
		if iter_9_3.interactLines then
			for iter_9_4, iter_9_5 in pairs(iter_9_3.interactLines) do
				local var_9_3 = KaRongDrawHelper.getLineKey(iter_9_5.x1, iter_9_5.y1, iter_9_5.x2, iter_9_5.y2)

				arg_9_0._lineMap[var_9_3] = KaRongDrawEnum.LineState.Switch_Off
				arg_9_0._interactCtrlMap[var_9_3] = iter_9_3
			end
		end
	end
end

function var_0_0.initConst(arg_10_0)
	local var_10_0, var_10_1 = arg_10_0:getGameSize()

	arg_10_0._startX = -var_10_0 * 0.5 - 0.5
	arg_10_0._startY = -var_10_1 * 0.5 - 0.5
end

function var_0_0.getStartPoint(arg_11_0)
	return arg_11_0._startPosX, arg_11_0._startPosY
end

function var_0_0.getAvatarStartPos(arg_12_0)
	return arg_12_0._avatarStartPos
end

function var_0_0.getEndPoint(arg_13_0)
	return arg_13_0._endPosX, arg_13_0._endPosY
end

function var_0_0.getAvatarEndPos(arg_14_0)
	return arg_14_0._avatarEndPos
end

function var_0_0.getElementCo(arg_15_0)
	return arg_15_0._elementCo
end

function var_0_0.setGameStatus(arg_16_0, arg_16_1)
	if arg_16_0._elementCo then
		arg_16_0._statusMap = arg_16_0._statusMap or {}
		arg_16_0._statusMap[arg_16_0._elementCo.id] = arg_16_1
	end
end

function var_0_0.getObjAtPos(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = KaRongDrawHelper.getPosKey(arg_17_1, arg_17_2)

	return arg_17_0._objMap[var_17_0]
end

function var_0_0.getObjAtLine(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local var_18_0 = KaRongDrawHelper.getLineKey(arg_18_1, arg_18_2, arg_18_3, arg_18_4)

	return arg_18_0._blockMap[var_18_0]
end

function var_0_0.getObjByLineKey(arg_19_0, arg_19_1)
	return arg_19_0._blockMap[arg_19_1]
end

function var_0_0.getGameSize(arg_20_0)
	return arg_20_0._width or 0, arg_20_0._height or 0
end

function var_0_0.getUIGridSize(arg_21_0)
	return KaRongDrawEnum.mazeUIGridWidth, KaRongDrawEnum.mazeUIGridHeight
end

function var_0_0.getObjectAnchor(arg_22_0, arg_22_1, arg_22_2)
	return arg_22_0:getGridCenterPos(arg_22_1 - 0.5, arg_22_2 - 0.5)
end

function var_0_0.getLineObjectAnchor(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	if arg_23_1 == arg_23_3 then
		return arg_23_0:getGridCenterPos(arg_23_1 - 0.5, math.min(arg_23_2, arg_23_4))
	elseif arg_23_2 == arg_23_4 then
		return arg_23_0:getGridCenterPos(math.min(arg_23_1, arg_23_3), arg_23_2 - 0.5)
	else
		logError("错误线段,x和y均不相等")
	end
end

function var_0_0.getLineAnchor(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	if arg_24_1 == arg_24_3 then
		return arg_24_0:getGridCenterPos(arg_24_1 - 0.5, math.min(arg_24_2, arg_24_4))
	elseif arg_24_2 == arg_24_4 then
		return arg_24_0:getGridCenterPos(math.min(arg_24_1, arg_24_3), arg_24_2 - 0.5)
	else
		logError("错误线段,x和y均不相等")
	end
end

function var_0_0.getGridCenterPos(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0, var_25_1 = arg_25_0:getUIGridSize()

	return (arg_25_0._startX + arg_25_1) * var_25_0, (arg_25_0._startY + arg_25_2) * var_25_1
end

function var_0_0.getIntegerPosByTouchPos(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0, var_26_1 = arg_26_0:getUIGridSize()
	local var_26_2 = math.floor((arg_26_1 - (arg_26_0._startX + 0.5) * var_26_0) / var_26_0)
	local var_26_3 = math.floor((arg_26_2 - (arg_26_0._startY + 0.5) * var_26_1) / var_26_1)
	local var_26_4, var_26_5 = arg_26_0:getGameSize()
	local var_26_6 = -1
	local var_26_7 = -1

	if var_26_2 >= 0 and var_26_2 < var_26_4 and var_26_3 >= 0 and var_26_3 < var_26_5 then
		var_26_6, var_26_7 = var_26_2 + 1, var_26_3 + 1
	else
		local var_26_8 = KaRongDrawEnum.mazeUILineWidth * 0.5
		local var_26_9 = var_26_2 >= 0 and var_26_2 < var_26_4 and var_26_2 + 1 or -1
		local var_26_10 = var_26_3 >= 0 and var_26_3 < var_26_5 and var_26_3 + 1 or -1
		local var_26_11 = arg_26_1 - (arg_26_0._startX + 0.5) * var_26_0
		local var_26_12 = arg_26_2 - (arg_26_0._startY + 0.5) * var_26_1

		if var_26_2 < 0 and var_26_11 > -var_26_8 then
			var_26_9 = 1
		elseif var_26_4 <= var_26_2 and var_26_11 < var_26_4 * var_26_0 + arg_26_0._startX + var_26_8 then
			var_26_9 = var_26_4
		end

		if var_26_3 < 0 and var_26_12 > -var_26_8 then
			var_26_10 = 1
		elseif var_26_5 <= var_26_3 and var_26_12 < var_26_5 * var_26_1 + arg_26_0._startY + var_26_8 then
			var_26_10 = var_26_5
		end

		if var_26_9 ~= -1 and var_26_10 ~= -1 then
			var_26_6, var_26_7 = var_26_9, var_26_10
		end
	end

	return var_26_6, var_26_7
end

function var_0_0.getClosePosByTouchPos(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0, var_27_1 = arg_27_0:getUIGridSize()
	local var_27_2, var_27_3 = arg_27_0:getIntegerPosByTouchPos(arg_27_1, arg_27_2)

	if var_27_2 ~= -1 then
		local var_27_4 = KaRongDrawEnum.mazeUILineWidth * 0.5
		local var_27_5 = arg_27_1 - (arg_27_0._startX + 0.5) * var_27_0
		local var_27_6 = (var_27_2 - 1) * var_27_0
		local var_27_7 = false

		if var_27_5 >= var_27_6 + var_27_4 then
			if var_27_5 >= var_27_6 + (var_27_0 - var_27_4) then
				var_27_2 = var_27_2 + 1
			else
				var_27_7 = true
			end
		end

		local var_27_8 = arg_27_2 - (arg_27_0._startY + 0.5) * var_27_1
		local var_27_9 = (var_27_3 - 1) * var_27_1
		local var_27_10 = false

		if var_27_8 >= var_27_9 + var_27_4 then
			if var_27_8 >= var_27_9 + (var_27_1 - var_27_4) then
				var_27_3 = var_27_3 + 1
			else
				var_27_10 = true
			end
		end

		if var_27_7 or var_27_10 then
			return -1, -1
		end
	end

	return var_27_2, var_27_3
end

function var_0_0.getLineFieldByTouchPos(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0, var_28_1 = arg_28_0:getUIGridSize()
	local var_28_2, var_28_3 = arg_28_0:getIntegerPosByTouchPos(arg_28_1, arg_28_2)
	local var_28_4 = var_28_2
	local var_28_5 = var_28_3
	local var_28_6
	local var_28_7

	if var_28_2 ~= -1 then
		local var_28_8 = KaRongDrawEnum.mazeUILineWidth * 0.5
		local var_28_9 = (var_28_2 - 1) * var_28_0
		local var_28_10 = arg_28_1 - (arg_28_0._startX + 0.5) * var_28_0
		local var_28_11 = false

		if var_28_10 >= var_28_9 + var_28_8 then
			var_28_4 = var_28_4 + 1

			if var_28_10 < var_28_9 + (var_28_0 - var_28_8) then
				var_28_11 = true
				var_28_6 = (var_28_10 - var_28_9) / var_28_0
			else
				var_28_2 = var_28_2 + 1
			end
		end

		local var_28_12 = (var_28_3 - 1) * var_28_1
		local var_28_13 = arg_28_2 - (arg_28_0._startY + 0.5) * var_28_1
		local var_28_14 = false

		if var_28_13 >= var_28_12 + var_28_8 then
			var_28_5 = var_28_5 + 1

			if var_28_13 < var_28_12 + (var_28_1 - var_28_8) then
				var_28_14 = true
				var_28_7 = (var_28_13 - var_28_12) / var_28_1
			else
				var_28_3 = var_28_3 + 1
			end
		end

		if not var_28_11 or not var_28_14 then
			return true, var_28_2, var_28_3, var_28_4, var_28_5, var_28_6, var_28_7
		end
	end

	return false
end

function var_0_0.getMapLineState(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	local var_29_0 = KaRongDrawHelper.getLineKey(arg_29_1, arg_29_2, arg_29_3, arg_29_4)

	return arg_29_0._lineMap and arg_29_0._lineMap[var_29_0]
end

function var_0_0.getAllMapLines(arg_30_0)
	return arg_30_0._lineMap
end

function var_0_0.getInteractLineCtrl(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	local var_31_0 = KaRongDrawHelper.getLineKey(arg_31_1, arg_31_2, arg_31_3, arg_31_4)

	return arg_31_0._interactCtrlMap and arg_31_0._interactCtrlMap[var_31_0]
end

function var_0_0.getPawnIconUrl(arg_32_0, arg_32_1)
	if arg_32_1 then
		return "v3a0_karong_puzzle_head2"
	else
		return "v3a0_karong_puzzle_head"
	end
end

function var_0_0.setMapLineState(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5)
	local var_33_0 = KaRongDrawHelper.getLineKey(arg_33_1, arg_33_2, arg_33_3, arg_33_4)

	arg_33_0._lineMap[var_33_0] = arg_33_5
end

function var_0_0.switchLine(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = arg_34_0:getInteractLines(arg_34_2, arg_34_3)

	if not var_34_0 then
		return
	end

	for iter_34_0, iter_34_1 in pairs(var_34_0) do
		local var_34_1 = iter_34_1.x1
		local var_34_2 = iter_34_1.y1
		local var_34_3 = iter_34_1.x2
		local var_34_4 = iter_34_1.y2
		local var_34_5 = KaRongDrawHelper.getLineKey(var_34_1, var_34_2, var_34_3, var_34_4)

		arg_34_0._lineMap[var_34_5] = arg_34_1

		KaRongDrawController.instance:dispatchEvent(KaRongDrawEvent.SwitchLineState, var_34_1, var_34_2, var_34_3, var_34_4)
	end

	if arg_34_1 == KaRongDrawEnum.LineState.Connect then
		arg_34_0._interactPosX = arg_34_2
		arg_34_0._interactPosY = arg_34_3
	else
		arg_34_0._interactPosX = nil
		arg_34_0._interactPosY = nil
	end
end

function var_0_0.getInteractLines(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_0:getObjAtPos(arg_35_1, arg_35_2)

	if var_35_0 then
		return var_35_0.interactLines
	end
end

function var_0_0.getInteractPos(arg_36_0)
	return arg_36_0._interactPosX, arg_36_0._interactPosY
end

function var_0_0.setTriggerEffectDone(arg_37_0, arg_37_1, arg_37_2)
	arg_37_0._effectDoneMap = arg_37_0._effectDoneMap or {}

	local var_37_0 = KaRongDrawHelper.getPosKey(arg_37_1, arg_37_2)

	arg_37_0._effectDoneMap[var_37_0] = true
end

function var_0_0.hasTriggerEffect(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = KaRongDrawHelper.getPosKey(arg_38_1, arg_38_2)

	return arg_38_0._effectDoneMap and arg_38_0._effectDoneMap[var_38_0]
end

function var_0_0.canTriggerEffect(arg_39_0, arg_39_1, arg_39_2)
	if arg_39_0:hasTriggerEffect(arg_39_1, arg_39_2) then
		return false
	end

	local var_39_0 = arg_39_0:getObjAtPos(arg_39_1, arg_39_2)

	if not var_39_0 then
		return false
	elseif #var_39_0.effects == 0 then
		return false
	end

	return true
end

function var_0_0.getTriggerEffectDoneMap(arg_40_0)
	return arg_40_0._effectDoneMap
end

function var_0_0.setTriggerEffectDoneMap(arg_41_0, arg_41_1)
	arg_41_0._effectDoneMap = arg_41_1
end

function var_0_0.getCheckPointMoList(arg_42_0)
	return arg_42_0._checkPoints
end

var_0_0.instance = var_0_0.New()

return var_0_0
