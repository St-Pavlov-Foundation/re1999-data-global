-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/chess/step/EliminateChessDebugStep.lua

module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessDebugStep", package.seeall)

local EliminateChessDebugStep = class("EliminateChessDebugStep", EliminateChessStepBase)

function EliminateChessDebugStep:onStart()
	local chess = EliminateChessItemController.instance:getChess()
	local chessMo = EliminateChessModel.instance:getChessMoList()
	local chessStr = "\n"

	for _, row in ipairs(chess) do
		for j, data in ipairs(row) do
			if data._data then
				chessStr = chessStr .. " " .. tostring(data._data.id)
			else
				chessStr = chessStr .. " " .. "-1"
			end
		end

		chessStr = chessStr .. "\n"
	end

	local chessMOStr = "\n"

	for _, row in ipairs(chessMo) do
		for j, data in ipairs(row) do
			if data then
				chessMOStr = chessMOStr .. " " .. tostring(data.id)
			else
				chessMOStr = chessMOStr .. " " .. "-1"
			end
		end

		chessMOStr = chessMOStr .. "\n"
	end

	logNormal("chessStr = " .. chessStr)
	logNormal("chessMOStr = " .. chessMOStr)
	self:onDone(true)
end

return EliminateChessDebugStep
