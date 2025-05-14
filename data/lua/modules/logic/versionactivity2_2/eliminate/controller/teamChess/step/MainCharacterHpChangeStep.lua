module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.MainCharacterHpChangeStep", package.seeall)

local var_0_0 = class("MainCharacterHpChangeStep", EliminateTeamChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0._data

	if var_1_0.diffValue == nil or var_1_0.teamType == nil then
		arg_1_0:onDone(true)

		return
	end

	EliminateTeamChessModel.instance:updateMainCharacterHp(var_1_0.teamType, var_1_0.diffValue)

	if math.abs(var_1_0.diffValue) > 0 then
		EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.MainCharacterHpChange, var_1_0.teamType, var_1_0.diffValue)
		TaskDispatcher.runDelay(arg_1_0._onDone, arg_1_0, EliminateTeamChessEnum.teamChessHpChangeStepTime)
	else
		arg_1_0:onDone(true)
	end
end

return var_0_0
