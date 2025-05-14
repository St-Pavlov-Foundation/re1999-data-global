module("modules.logic.versionactivity2_2.eliminate.model.EliminateChessModel", package.seeall)

local var_0_0 = class("EliminateChessModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._chessMo = {}
	arg_1_0._chessConfig = {}
	arg_1_0._chessBoardConfig = {}
	arg_1_0._maxRow = 0
	arg_1_0._maxCol = 0
	arg_1_0._tips = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._chessMo = {}
	arg_2_0._chessConfig = {}
	arg_2_0._chessBoardConfig = {}
	arg_2_0._maxRow = 0
	arg_2_0._maxCol = 0
	arg_2_0._tips = nil
end

function var_0_0.mockData(arg_3_0)
	local var_3_0 = T_lua_eliminate_level[1]
	local var_3_1 = var_3_0.chess
	local var_3_2 = var_3_0.chessBoard

	arg_3_0._maxRow = #var_3_1

	for iter_3_0 = 1, #var_3_1 do
		if arg_3_0._chessMo then
			arg_3_0._chessMo[iter_3_0] = {}
		end

		local var_3_3 = var_3_1[iter_3_0]

		arg_3_0._maxCol = #var_3_3

		for iter_3_1 = 1, #var_3_3 do
			local var_3_4 = var_3_3[iter_3_1]
			local var_3_5 = EliminateChessMO.New()

			var_3_5:setXY(iter_3_0, iter_3_1)
			var_3_5:setStartXY(iter_3_0, iter_3_1)
			var_3_5:setChessId(var_3_4)
			var_3_5:setChessBoardType(var_3_2[iter_3_0][iter_3_1])

			arg_3_0._chessMo[iter_3_0][iter_3_1] = var_3_5
		end
	end
end

function var_0_0.initChessInfo(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.row

	if var_4_0 == nil or #var_4_0 <= 0 then
		return
	end

	arg_4_0._maxRow = #var_4_0

	for iter_4_0 = 1, #var_4_0 do
		if arg_4_0._chessMo[iter_4_0] == nil then
			arg_4_0._chessMo[iter_4_0] = {}
		end

		local var_4_1 = var_4_0[iter_4_0].chess

		for iter_4_1 = 1, #var_4_1 do
			arg_4_0._maxCol = #var_4_1

			local var_4_2 = var_4_1[iter_4_1]
			local var_4_3 = arg_4_0._chessMo[iter_4_0][iter_4_1]

			if var_4_3 == nil then
				var_4_3 = EliminateChessMO.New()
				arg_4_0._chessMo[iter_4_0][iter_4_1] = var_4_3
			end

			var_4_3:setXY(iter_4_0, iter_4_1)
			var_4_3:setStartXY(iter_4_0, iter_4_1)
			var_4_3:setChessId(var_4_2.id)
			var_4_3:setChessBoardType(var_4_2.type)
		end
	end

	arg_4_0:createInitMoveState()
end

function var_0_0.createInitMoveState(arg_5_0)
	for iter_5_0 = 1, #arg_5_0._chessMo do
		local var_5_0 = arg_5_0._chessMo[iter_5_0]

		for iter_5_1 = 1, #var_5_0 do
			var_5_0[iter_5_1]:setStartXY(iter_5_0, arg_5_0._maxCol + 1)
		end
	end
end

function var_0_0.getMaxRowAndCol(arg_6_0)
	return arg_6_0._maxRow, arg_6_0._maxCol
end

function var_0_0.posIsValid(arg_7_0, arg_7_1, arg_7_2)
	return arg_7_1 >= 1 and arg_7_1 <= arg_7_0._maxRow and arg_7_2 >= 1 and arg_7_2 <= arg_7_0._maxCol
end

function var_0_0.updateMatch3Tips(arg_8_0, arg_8_1)
	if not arg_8_0._tips then
		arg_8_0._tips = EliminateTipMO.New()
	end

	arg_8_0._tips:updateInfoByServer(arg_8_1)
end

function var_0_0.getTipEliminateCount(arg_9_0)
	return arg_9_0._tips and arg_9_0._tips:getEliminateCount() or 0
end

function var_0_0.updateMovePoint(arg_10_0, arg_10_1)
	arg_10_0._movePoint = arg_10_1 or 0
end

function var_0_0.getTipInfo(arg_11_0)
	return arg_11_0._tips
end

function var_0_0.getChessMo(arg_12_0, arg_12_1, arg_12_2)
	return arg_12_0._chessMo[arg_12_1][arg_12_2]
end

function var_0_0.updateChessMo(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0._chessMo[arg_13_1][arg_13_2] = arg_13_3
end

function var_0_0.getChessMoList(arg_14_0)
	return arg_14_0._chessMo
end

function var_0_0.getMovePoint(arg_15_0)
	return arg_15_0._movePoint
end

function var_0_0.setRecordCurNeedShowEffectAndXY(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_0._recordShowEffectX = arg_16_1
	arg_16_0._recordShowEffectY = arg_16_2
	arg_16_0._recordShowEffectType = arg_16_3
end

function var_0_0.getRecordCurNeedShowEffectAndXYAndClear(arg_17_0)
	local var_17_0 = arg_17_0._recordShowEffectType
	local var_17_1 = arg_17_0._recordShowEffectX
	local var_17_2 = arg_17_0._recordShowEffectY

	arg_17_0._recordShowEffectType = nil
	arg_17_0._recordShowEffectX = nil
	arg_17_0._recordShowEffectY = nil

	return var_17_1, var_17_2, var_17_0
end

function var_0_0.addCurPlayAudioCount(arg_18_0)
	arg_18_0._playAudioCount = arg_18_0._playAudioCount and arg_18_0._playAudioCount + 1 or 1
end

function var_0_0.clearCurPlayAudioCount(arg_19_0)
	arg_19_0._playAudioCount = nil
end

function var_0_0.getCurPlayAudioCount(arg_20_0)
	if arg_20_0._playAudioCount == nil then
		arg_20_0._playAudioCount = 1
	end

	return arg_20_0._playAudioCount
end

function var_0_0.calEvaluateLevel(arg_21_0)
	if arg_21_0._eliminateTotalCount == nil then
		return nil
	end

	local var_21_0 = EliminateConfig.instance:getEvaluateGear()
	local var_21_1

	if var_21_0 and #var_21_0 == 3 then
		if arg_21_0._eliminateTotalCount < var_21_0[2] then
			var_21_1 = arg_21_0._eliminateTotalCount >= var_21_0[1] and 1 or nil
		else
			var_21_1 = arg_21_0._eliminateTotalCount < var_21_0[3] and 2 or 3
		end
	end

	return var_21_1
end

function var_0_0.addTotalEliminateCount(arg_22_0, arg_22_1)
	if arg_22_0._eliminateTotalCount == nil then
		arg_22_0._eliminateTotalCount = 0
	end

	arg_22_0._eliminateTotalCount = arg_22_0._eliminateTotalCount + arg_22_1
end

function var_0_0.clearTotalCount(arg_23_0)
	arg_23_0._eliminateTotalCount = nil
end

function var_0_0.getNeedResetData(arg_24_0)
	return arg_24_0._cacheData
end

function var_0_0.setNeedResetData(arg_25_0, arg_25_1)
	arg_25_0._cacheData = arg_25_1
end

function var_0_0.clear(arg_26_0)
	arg_26_0._chessMo = {}
	arg_26_0._cacheData = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
