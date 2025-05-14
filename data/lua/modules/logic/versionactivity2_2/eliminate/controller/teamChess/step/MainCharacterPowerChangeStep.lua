module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.MainCharacterPowerChangeStep", package.seeall)

local var_0_0 = class("MainCharacterPowerChangeStep", EliminateTeamChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0._data

	if var_1_0.diffValue == nil or var_1_0.teamType == nil then
		arg_1_0:onDone(true)

		return
	end

	EliminateTeamChessModel.instance:updateMainCharacterPower(var_1_0.teamType, var_1_0.diffValue)
	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.MainCharacterPowerChange, var_1_0.teamType, var_1_0.diffValue)
	TaskDispatcher.runDelay(arg_1_0._onDone, arg_1_0, EliminateTeamChessEnum.addResourceTipTime)
end

return var_0_0
