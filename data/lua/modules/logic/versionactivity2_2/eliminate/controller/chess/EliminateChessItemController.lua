module("modules.logic.versionactivity2_2.eliminate.controller.chess.EliminateChessItemController", package.seeall)

local var_0_0 = class("EliminateChessItemController")

function var_0_0.ctor(arg_1_0)
	arg_1_0._chess = {}
	arg_1_0._chessboard = {}
	arg_1_0._chessboardMaxWidth = 0
	arg_1_0._chessboardMaxHeight = 0
	arg_1_0._chessboardMaxRowValue = 0
	arg_1_0._chessboardMaxLineValue = 0
end

function var_0_0.InitCloneGo(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if gohelper.isNil(arg_2_1) or gohelper.isNil(arg_2_2) or gohelper.isNil(arg_2_3) or gohelper.isNil(arg_2_4) then
		return false
	end

	arg_2_0._gochess = arg_2_1
	arg_2_0._gochessBoard = arg_2_2
	arg_2_0._gochessBg = arg_2_3
	arg_2_0._gochessBoardBg = arg_2_4

	return true
end

function var_0_0.InitChess(arg_3_0)
	local var_3_0 = EliminateChessModel.instance:getChessMoList()

	for iter_3_0 = 1, #var_3_0 do
		if arg_3_0._chess[iter_3_0] == nil then
			arg_3_0._chess[iter_3_0] = {}
		end

		local var_3_1 = var_3_0[iter_3_0]

		for iter_3_1 = 1, #var_3_1 do
			local var_3_2 = var_3_1[iter_3_1]
			local var_3_3 = arg_3_0:createChess(iter_3_0, iter_3_1)

			var_3_3:initData(var_3_2)

			arg_3_0._chess[iter_3_0][iter_3_1] = var_3_3
		end
	end
end

function var_0_0.refreshChess(arg_4_0)
	for iter_4_0 = 1, #arg_4_0._chess do
		local var_4_0 = arg_4_0._chess[iter_4_0]

		for iter_4_1 = 1, #var_4_0 do
			var_4_0[iter_4_1]:updateInfo()
		end
	end
end

function var_0_0.InitChessBoard(arg_5_0)
	local var_5_0 = EliminateChessModel.instance:getChessMoList()

	for iter_5_0 = 1, #var_5_0 do
		if arg_5_0._chessboard[iter_5_0] == nil then
			arg_5_0._chessboard[iter_5_0] = {}
		end

		local var_5_1 = var_5_0[iter_5_0]

		for iter_5_1 = 1, #var_5_1 do
			local var_5_2 = var_5_1[iter_5_1]
			local var_5_3 = gohelper.clone(arg_5_0._gochessBoard, arg_5_0._gochessBoardBg, string.format("chessBoard_%d_%d", iter_5_0, iter_5_1))

			gohelper.setActiveCanvasGroup(var_5_3, false)

			local var_5_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_5_3, EliminateChessBoardItem, arg_5_0)

			var_5_4:initData(var_5_2)

			arg_5_0._chessboard[iter_5_0][iter_5_1] = var_5_4
		end
	end

	if var_5_0 and #var_5_0 > 0 then
		arg_5_0._chessboardMaxWidth = #var_5_0 * EliminateEnum.ChessWidth
		arg_5_0._chessboardMaxHeight = #var_5_0[1] * EliminateEnum.ChessHeight
		arg_5_0._chessboardMaxRowValue = #var_5_0
		arg_5_0._chessboardMaxLineValue = #var_5_0[1]
	end
end

function var_0_0.createChess(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:getChessItemGo(string.format("chess_%d_%d", arg_6_1, arg_6_2), arg_6_1, arg_6_2)
	local var_6_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_0, EliminateChessItem, arg_6_0)

	var_6_1:init(var_6_0)

	return var_6_1
end

function var_0_0.getMaxWidthAndHeight(arg_7_0)
	return arg_7_0._chessboardMaxWidth, arg_7_0._chessboardMaxHeight
end

function var_0_0.getMaxLineAndRow(arg_8_0)
	return arg_8_0._chessboardMaxLineValue, arg_8_0._chessboardMaxRowValue
end

function var_0_0.getChessItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0

	if arg_9_0._chess[arg_9_1] ~= nil then
		var_9_0 = arg_9_0._chess[arg_9_1][arg_9_2]
	end

	if var_9_0 == nil then
		logNormal("EliminateChessItemController:getChessItem chess is nil x = " .. arg_9_1 .. " y = " .. arg_9_2)
	end

	return var_9_0
end

function var_0_0.getChess(arg_10_0)
	return arg_10_0._chess
end

function var_0_0.updateChessItem(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0._chess[arg_11_1][arg_11_2] = arg_11_3

	if arg_11_3 ~= nil then
		arg_11_3._go.name = string.format("chess_%d_%d", arg_11_1, arg_11_2)
	end
end

function var_0_0.getChessBoardItem(arg_12_0, arg_12_1, arg_12_2)
	return arg_12_0._chessboard[arg_12_1][arg_12_2]
end

function var_0_0.getChessItemByModel(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0._chess) do
		for iter_13_2, iter_13_3 in ipairs(iter_13_1) do
			if iter_13_3._data == arg_13_1 then
				return iter_13_3
			end
		end
	end

	return nil
end

function var_0_0.getChessItemGo(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_0.chessItemPool == nil then
		local var_14_0 = 62

		arg_14_0.chessItemPool = LuaObjPool.New(var_14_0, function()
			if gohelper.isNil(arg_14_0._gochess) or gohelper.isNil(arg_14_0._gochessBg) then
				logError("EliminateChessItemController:getChessItemGo self._gochess or self._gochessBg is nil")
			end

			local var_15_0 = gohelper.clone(arg_14_0._gochess, arg_14_0._gochessBg)

			if isDebugBuild and gohelper.isNil(var_15_0) then
				logNormal("chessItemPool get go is nil")
			end

			gohelper.setActiveCanvasGroup(var_15_0, false)

			return var_15_0
		end, function(arg_16_0)
			if not gohelper.isNil(arg_16_0) then
				gohelper.setActiveCanvasGroup(arg_16_0, false)
			end
		end, function(arg_17_0)
			if not gohelper.isNil(arg_17_0) then
				if isDebugBuild then
					arg_17_0.name = "cache"
				end

				gohelper.setActiveCanvasGroup(arg_17_0, false)
			end
		end)
	end

	local var_14_1 = arg_14_0.chessItemPool:getObject()

	if gohelper.isNil(var_14_1) then
		var_14_1 = gohelper.clone(arg_14_0._gochess, arg_14_0._gochessBg)
	end

	if not string.nilorempty(arg_14_1) then
		var_14_1.name = arg_14_1
	end

	return var_14_1
end

function var_0_0.getDebugIndex(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0.debug == nil then
		arg_18_0.debug = {}
	end

	if arg_18_0.debug[arg_18_1] == nil then
		arg_18_0.debug[arg_18_1] = {}
	end

	arg_18_0.debug[arg_18_1][arg_18_2] = (arg_18_0.debug[arg_18_1][arg_18_2] and arg_18_0.debug[arg_18_1][arg_18_2] or 0) + 1

	return arg_18_0.debug[arg_18_1][arg_18_2]
end

function var_0_0.putChessItemGo(arg_19_0, arg_19_1)
	if arg_19_0.chessItemPool ~= nil then
		arg_19_0.chessItemPool:putObject(arg_19_1)
	else
		gohelper.destroy(arg_19_1)
	end
end

function var_0_0.clear(arg_20_0)
	for iter_20_0, iter_20_1 in pairs(arg_20_0._chess) do
		for iter_20_2, iter_20_3 in pairs(iter_20_1) do
			iter_20_3:onDestroy()
		end
	end

	for iter_20_4, iter_20_5 in pairs(arg_20_0._chessboard) do
		for iter_20_6, iter_20_7 in pairs(iter_20_5) do
			iter_20_7:onDestroy()
		end
	end

	if arg_20_0.chessItemPool then
		arg_20_0.chessItemPool:dispose()

		arg_20_0.chessItemPool = nil
	end

	arg_20_0._gochess = nil
	arg_20_0._gochessBoard = nil
	arg_20_0._gochessBg = nil
	arg_20_0._gochessBoardBg = nil

	tabletool.clear(arg_20_0._chess)
	tabletool.clear(arg_20_0._chessboard)
end

var_0_0.instance = var_0_0.New()

return var_0_0
