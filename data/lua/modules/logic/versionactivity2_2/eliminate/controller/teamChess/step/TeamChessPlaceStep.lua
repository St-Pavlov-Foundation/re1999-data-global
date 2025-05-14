module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.TeamChessPlaceStep", package.seeall)

local var_0_0 = class("TeamChessPlaceStep", EliminateTeamChessStepBase)

function var_0_0.onStart(arg_1_0)
	if EliminateTeamChessModel.instance:getCurTeamRoundStepState() == EliminateTeamChessEnum.TeamChessRoundType.enemy then
		EliminateLevelController.instance:registerCallback(EliminateChessEvent.LevelDialogClosed, arg_1_0._checkRoundStep, arg_1_0)
		EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.TeamChessEnemyPlaceBefore)
	else
		arg_1_0:_checkRoundStep()
	end
end

function var_0_0._checkRoundStep(arg_2_0)
	EliminateLevelController.instance:unregisterCallback(EliminateChessEvent.LevelDialogClosed, arg_2_0._checkRoundStep, arg_2_0)

	local var_2_0 = arg_2_0._data
	local var_2_1 = EliminateTeamChessModel.instance:getStronghold(var_2_0.strongholdId)
	local var_2_2 = var_2_0.chessPiece
	local var_2_3 = var_2_2.teamType
	local var_2_4 = var_2_1:updatePiece(var_2_3, var_2_2)
	local var_2_5 = var_2_1:getChess(var_2_2.uid)

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.AddStrongholdChess, var_2_5, var_2_0.strongholdId, var_2_4)
	TaskDispatcher.runDelay(arg_2_0._onDone, arg_2_0, EliminateTeamChessEnum.teamChessPlaceStep)
end

return var_0_0
