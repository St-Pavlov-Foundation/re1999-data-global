module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.StrongHoldPowerChangeStep", package.seeall)

slot0 = class("StrongHoldPowerChangeStep", EliminateTeamChessStepBase)

function slot0.onStart(slot0)
	if slot0._data.teamType == nil or slot1.diffValue == nil or slot1.strongholdId == nil then
		slot0:onDone(true)

		return
	end

	EliminateTeamChessModel.instance:updateStrongholdsScore(slot1.strongholdId, slot1.teamType, slot1.diffValue)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.StrongHoldPowerChange, slot1.strongholdId, slot1.teamType, slot1.diffValue)
	slot0:onDone(true)
end

return slot0
