module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.MainCharacterPowerChangeStep", package.seeall)

slot0 = class("MainCharacterPowerChangeStep", EliminateTeamChessStepBase)

function slot0.onStart(slot0)
	if slot0._data.diffValue == nil or slot1.teamType == nil then
		slot0:onDone(true)

		return
	end

	EliminateTeamChessModel.instance:updateMainCharacterPower(slot1.teamType, slot1.diffValue)
	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.MainCharacterPowerChange, slot1.teamType, slot1.diffValue)
	TaskDispatcher.runDelay(slot0._onDone, slot0, EliminateTeamChessEnum.addResourceTipTime)
end

return slot0
