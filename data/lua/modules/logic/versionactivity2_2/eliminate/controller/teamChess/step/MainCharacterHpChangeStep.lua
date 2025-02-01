module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.MainCharacterHpChangeStep", package.seeall)

slot0 = class("MainCharacterHpChangeStep", EliminateTeamChessStepBase)

function slot0.onStart(slot0)
	if slot0._data.diffValue == nil or slot1.teamType == nil then
		slot0:onDone(true)

		return
	end

	EliminateTeamChessModel.instance:updateMainCharacterHp(slot1.teamType, slot1.diffValue)

	if math.abs(slot1.diffValue) > 0 then
		EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.MainCharacterHpChange, slot1.teamType, slot1.diffValue)
		TaskDispatcher.runDelay(slot0._onDone, slot0, EliminateTeamChessEnum.teamChessHpChangeStepTime)
	else
		slot0:onDone(true)
	end
end

return slot0
