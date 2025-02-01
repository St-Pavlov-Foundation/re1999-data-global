module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessDebugStep", package.seeall)

slot0 = class("EliminateChessDebugStep", EliminateChessStepBase)

function slot0.onStart(slot0)
	slot2 = EliminateChessModel.instance:getChessMoList()
	slot3 = "\n"

	for slot7, slot8 in ipairs(EliminateChessItemController.instance:getChess()) do
		for slot12, slot13 in ipairs(slot8) do
			slot3 = slot13._data and slot3 .. " " .. tostring(slot13._data.id) or slot3 .. " " .. tostring(slot13._data.id) .. " " .. "-1"
		end

		slot3 = slot3 .. "\n"
	end

	slot4 = "\n"

	for slot8, slot9 in ipairs(slot2) do
		for slot13, slot14 in ipairs(slot9) do
			slot4 = slot14 and slot4 .. " " .. tostring(slot14.id) or slot4 .. " " .. tostring(slot14.id) .. " " .. "-1"
		end

		slot4 = slot4 .. "\n"
	end

	logNormal("chessStr = " .. slot3)
	logNormal("chessMOStr = " .. slot4)
	slot0:onDone(true)
end

return slot0
