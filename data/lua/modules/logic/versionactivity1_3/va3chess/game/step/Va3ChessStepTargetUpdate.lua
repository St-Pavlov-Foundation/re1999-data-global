module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepTargetUpdate", package.seeall)

local var_0_0 = class("Va3ChessStepTargetUpdate", Va3ChessStepBase)

function var_0_0.start(arg_1_0)
	local var_1_0 = arg_1_0.originData

	Va3ChessGameModel.instance:setFinishedTargetNum(var_1_0.targetNum)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.TargetUpdate)
	arg_1_0:finish()
end

return var_0_0
