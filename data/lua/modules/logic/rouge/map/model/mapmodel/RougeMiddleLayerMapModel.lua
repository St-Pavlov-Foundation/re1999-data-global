module("modules.logic.rouge.map.model.mapmodel.RougeMiddleLayerMapModel", package.seeall)

local var_0_0 = class("RougeMiddleLayerMapModel")

function var_0_0.initMap(arg_1_0, arg_1_1)
	arg_1_0.layerId = arg_1_1.layerId
	arg_1_0.layerCo = lua_rouge_layer.configDict[arg_1_0.layerId]
	arg_1_0.middleLayerId = arg_1_1.middleLayerId
	arg_1_0.middleCo = lua_rouge_middle_layer.configDict[arg_1_0.middleLayerId]
	arg_1_0.curPosIndex = arg_1_1.positionIndex

	arg_1_0:initPieceInfo(arg_1_1.pieceInfo)
end

function var_0_0.updateMapInfo(arg_2_0, arg_2_1)
	arg_2_0.curPosIndex = arg_2_1.positionIndex

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.pieceInfo) do
		arg_2_0:updateOnePieceInfo(iter_2_1)
	end
end

function var_0_0.updateSimpleMapInfo(arg_3_0, arg_3_1)
	arg_3_0:updateMapInfo(arg_3_1)
end

function var_0_0.initPieceInfo(arg_4_0, arg_4_1)
	arg_4_0.pieceDict = {}
	arg_4_0.pieceList = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_0 = RougePieceInfoMO.New()

		var_4_0:init(iter_4_1)

		arg_4_0.pieceDict[var_4_0.index] = var_4_0

		table.insert(arg_4_0.pieceList, var_4_0)
	end
end

function var_0_0.updateOnePieceInfo(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.pieceDict[arg_5_1.index]

	if not arg_5_1 then
		logError("update a not exist piece .. " .. tostring(arg_5_1.index))

		return
	end

	var_5_0:update(arg_5_1)
end

function var_0_0.getPieceList(arg_6_0)
	return arg_6_0.pieceList
end

function var_0_0.getMiddleLayerPosByIndex(arg_7_0, arg_7_1)
	return arg_7_0.middleCo.pointPos[arg_7_1]
end

function var_0_0.getPathIndex(arg_8_0, arg_8_1)
	return arg_8_0:getMiddleLayerPosByIndex(arg_8_1).z
end

function var_0_0.getMiddleLayerPathPos(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getPathIndex(arg_9_1)

	return arg_9_0:getMiddleLayerPathPosByPathIndex(var_9_0)
end

function var_0_0.getMiddleLayerPathPosByPathIndex(arg_10_0, arg_10_1)
	return arg_10_0.middleCo.pathPointPos[arg_10_1]
end

function var_0_0.getCurPosIndex(arg_11_0)
	return arg_11_0.curPosIndex
end

function var_0_0.getMiddleLayerLeavePos(arg_12_0)
	local var_12_0 = arg_12_0.middleCo.leavePos

	if not var_12_0 then
		logError(string.format("间隙层地图id ：%s， 没有配置出口位置", arg_12_0.middleCo.id))

		return 5.68, 0.41
	end

	return var_12_0.x, var_12_0.y
end

function var_0_0.hadLeavePos(arg_13_0)
	return arg_13_0.middleCo and arg_13_0.middleCo.leavePos
end

function var_0_0.getMiddleLayerLeavePathIndex(arg_14_0)
	return arg_14_0.middleCo.leavePos.z
end

function var_0_0.getPieceMo(arg_15_0, arg_15_1)
	return arg_15_0.pieceDict[arg_15_1]
end

function var_0_0.getCurPieceMo(arg_16_0)
	return arg_16_0:getPieceMo(arg_16_0:getCurPosIndex())
end

function var_0_0.clear(arg_17_0)
	arg_17_0.layerId = nil
	arg_17_0.layerCo = nil
	arg_17_0.middleLayerId = nil
	arg_17_0.middleCo = nil
	arg_17_0.curPosition = nil
	arg_17_0.pieceDict = nil
	arg_17_0.pieceList = nil
end

return var_0_0
