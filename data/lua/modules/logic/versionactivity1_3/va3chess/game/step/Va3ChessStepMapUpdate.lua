module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepMapUpdate", package.seeall)

local var_0_0 = class("Va3ChessStepMapUpdate", Va3ChessStepBase)

function var_0_0.start(arg_1_0)
	arg_1_0:processMapUpdate()
end

function var_0_0.processMapUpdate(arg_2_0)
	local var_2_0 = Va3ChessModel.instance:getActId()

	Va3ChessGameController.instance:updateServerMap(var_2_0, arg_2_0.originData)
	arg_2_0:finish()
end

return var_0_0
