module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessArrangeStep", package.seeall)

slot0 = class("EliminateChessArrangeStep", EliminateChessStepBase)

function slot0.onStart(slot0)
	if slot0._data == nil or #slot0._data < 1 then
		slot0:onDone(true)

		return
	end

	for slot4, slot5 in ipairs(slot0._data) do
		slot7 = slot5.viewItem

		if slot5.model and slot7 then
			EliminateChessItemController.instance:updateChessItem(slot6.x, slot6.y, slot7)
		end
	end

	slot0:onDone(true)
end

return slot0
