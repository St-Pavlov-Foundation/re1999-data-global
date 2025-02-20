module("modules.logic.versionactivity2_2.eliminate.controller.chess.EliminateChessItemController", package.seeall)

slot0 = class("EliminateChessItemController")

function slot0.ctor(slot0)
	slot0._chess = {}
	slot0._chessboard = {}
	slot0._chessboardMaxWidth = 0
	slot0._chessboardMaxHeight = 0
	slot0._chessboardMaxRowValue = 0
	slot0._chessboardMaxLineValue = 0
end

function slot0.InitCloneGo(slot0, slot1, slot2, slot3, slot4)
	if gohelper.isNil(slot1) or gohelper.isNil(slot2) or gohelper.isNil(slot3) or gohelper.isNil(slot4) then
		return false
	end

	slot0._gochess = slot1
	slot0._gochessBoard = slot2
	slot0._gochessBg = slot3
	slot0._gochessBoardBg = slot4

	return true
end

function slot0.InitChess(slot0)
	for slot5 = 1, #EliminateChessModel.instance:getChessMoList() do
		if slot0._chess[slot5] == nil then
			slot0._chess[slot5] = {}
		end

		for slot10 = 1, #slot1[slot5] do
			slot12 = slot0:createChess(slot5, slot10)

			slot12:initData(slot6[slot10])

			slot0._chess[slot5][slot10] = slot12
		end
	end
end

function slot0.refreshChess(slot0)
	for slot4 = 1, #slot0._chess do
		for slot9 = 1, #slot0._chess[slot4] do
			slot5[slot9]:updateInfo()
		end
	end
end

function slot0.InitChessBoard(slot0)
	for slot5 = 1, #EliminateChessModel.instance:getChessMoList() do
		if slot0._chessboard[slot5] == nil then
			slot0._chessboard[slot5] = {}
		end

		for slot10 = 1, #slot1[slot5] do
			slot12 = gohelper.clone(slot0._gochessBoard, slot0._gochessBoardBg, string.format("chessBoard_%d_%d", slot5, slot10))

			gohelper.setActiveCanvasGroup(slot12, false)

			slot13 = MonoHelper.addNoUpdateLuaComOnceToGo(slot12, EliminateChessBoardItem, slot0)

			slot13:initData(slot6[slot10])

			slot0._chessboard[slot5][slot10] = slot13
		end
	end

	if slot1 and #slot1 > 0 then
		slot0._chessboardMaxWidth = #slot1 * EliminateEnum.ChessWidth
		slot0._chessboardMaxHeight = #slot1[1] * EliminateEnum.ChessHeight
		slot0._chessboardMaxRowValue = #slot1
		slot0._chessboardMaxLineValue = #slot1[1]
	end
end

function slot0.createChess(slot0, slot1, slot2)
	slot3 = slot0:getChessItemGo(string.format("chess_%d_%d", slot1, slot2), slot1, slot2)
	slot4 = MonoHelper.addNoUpdateLuaComOnceToGo(slot3, EliminateChessItem, slot0)

	slot4:init(slot3)

	return slot4
end

function slot0.getMaxWidthAndHeight(slot0)
	return slot0._chessboardMaxWidth, slot0._chessboardMaxHeight
end

function slot0.getMaxLineAndRow(slot0)
	return slot0._chessboardMaxLineValue, slot0._chessboardMaxRowValue
end

function slot0.getChessItem(slot0, slot1, slot2)
	return slot0._chess[slot1][slot2]
end

function slot0.getChess(slot0)
	return slot0._chess
end

function slot0.updateChessItem(slot0, slot1, slot2, slot3)
	slot0._chess[slot1][slot2] = slot3
	slot3._go.name = string.format("chess_%d_%d", slot1, slot2)
end

function slot0.getChessBoardItem(slot0, slot1, slot2)
	return slot0._chessboard[slot1][slot2]
end

function slot0.getChessItemByModel(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._chess) do
		for slot10, slot11 in ipairs(slot6) do
			if slot11._data == slot1 then
				return slot11
			end
		end
	end

	return nil
end

function slot0.getChessItemGo(slot0, slot1, slot2, slot3)
	if slot0.chessItemPool == nil then
		slot0.chessItemPool = LuaObjPool.New(62, function ()
			if gohelper.isNil(uv0._gochess) or gohelper.isNil(uv0._gochessBg) then
				logError("EliminateChessItemController:getChessItemGo self._gochess or self._gochessBg is nil")
			end

			slot0 = gohelper.clone(uv0._gochess, uv0._gochessBg)

			if isDebugBuild and gohelper.isNil(slot0) then
				logNormal("chessItemPool get go is nil")
			end

			gohelper.setActiveCanvasGroup(slot0, false)

			return slot0
		end, function (slot0)
			if not gohelper.isNil(slot0) then
				gohelper.setActiveCanvasGroup(slot0, false)
			end
		end, function (slot0)
			if not gohelper.isNil(slot0) then
				if isDebugBuild then
					slot0.name = "cache"
				end

				gohelper.setActiveCanvasGroup(slot0, false)
			end
		end)
	end

	if gohelper.isNil(slot0.chessItemPool:getObject()) then
		slot4 = gohelper.clone(slot0._gochess, slot0._gochessBg)
	end

	if not string.nilorempty(slot1) then
		slot4.name = slot1
	end

	return slot4
end

function slot0.getDebugIndex(slot0, slot1, slot2)
	if slot0.debug == nil then
		slot0.debug = {}
	end

	if slot0.debug[slot1] == nil then
		slot0.debug[slot1] = {}
	end

	slot0.debug[slot1][slot2] = (slot0.debug[slot1][slot2] and slot0.debug[slot1][slot2] or 0) + 1

	return slot0.debug[slot1][slot2]
end

function slot0.putChessItemGo(slot0, slot1)
	if slot0.chessItemPool ~= nil then
		slot0.chessItemPool:putObject(slot1)
	else
		gohelper.destroy(slot1)
	end
end

function slot0.clear(slot0)
	for slot4, slot5 in pairs(slot0._chess) do
		for slot9, slot10 in pairs(slot5) do
			slot10:onDestroy()
		end
	end

	for slot4, slot5 in pairs(slot0._chessboard) do
		for slot9, slot10 in pairs(slot5) do
			slot10:onDestroy()
		end
	end

	if slot0.chessItemPool then
		slot0.chessItemPool:dispose()

		slot0.chessItemPool = nil
	end

	slot0._gochess = nil
	slot0._gochessBoard = nil
	slot0._gochessBg = nil
	slot0._gochessBoardBg = nil

	tabletool.clear(slot0._chess)
	tabletool.clear(slot0._chessboard)
end

slot0.instance = slot0.New()

return slot0
