module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessPlayEffectStep", package.seeall)

slot0 = class("EliminateChessPlayEffectStep", EliminateChessStepBase)

function slot0.onStart(slot0)
	slot1, slot2, slot0.effectType = EliminateChessModel.instance:getRecordCurNeedShowEffectAndXYAndClear()

	if slot1 == nil or slot2 == nil or slot0.effectType == nil then
		slot0:onDone(true)

		return
	end

	if not EliminateChessItemController.instance:getChessItem(slot1, slot2) then
		logError("步骤 PlayEffect 棋子：" .. slot1, slot2 .. "不存在")
		slot0:onDone(true)

		return
	end

	slot5, slot6 = slot4:getGoPos()

	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.PlayEliminateEffect, slot0.effectType, slot1, slot2, slot5, slot6, true, slot0._onPlayEnd, slot0)
end

function slot0._onPlayEnd(slot0)
	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.PlayEliminateEffect, slot0.effectType, nil, , 0, 0, false, nil, )
	slot0:onDone(true)
end

return slot0
