module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessMoveStep", package.seeall)

slot0 = class("EliminateChessMoveStep", EliminateChessStepBase)

function slot0.onStart(slot0)
	slot1 = slot0._data.chessItem
	slot3 = slot0._data.animType

	if not slot0._data.time or not slot1 then
		logError("步骤 Move 参数错误")
		slot0:onDone(true)

		return
	end

	EliminateStepUtil.putMoveStepTable(slot0._data)
	slot1:toMove(slot2, slot3, slot0._onDone, slot0)
end

return slot0
