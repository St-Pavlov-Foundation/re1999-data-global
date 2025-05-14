module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepBrazierTrigger", package.seeall)

local var_0_0 = class("Va3ChessStepBrazierTrigger", Va3ChessStepBase)

function var_0_0.start(arg_1_0)
	local var_1_0 = arg_1_0.originData.brazierId
	local var_1_1 = Va3ChessGameController.instance.interacts
	local var_1_2 = var_1_1 and var_1_1:get(var_1_0)

	if var_1_2 then
		if var_1_2.originData then
			var_1_2.originData:setBrazierIsLight(true)
		end

		local var_1_3 = var_1_2:getHandler()

		if var_1_3 and var_1_3.refreshBrazier then
			var_1_3:refreshBrazier()
			AudioMgr.instance:trigger(AudioEnum.chess_activity142.LightBrazier)
		end
	end

	local var_1_4 = arg_1_0.originData.fireballNum

	Va3ChessGameModel.instance:setFireBallCount(var_1_4, true)
	arg_1_0:finish()
end

function var_0_0.finish(arg_2_0)
	var_0_0.super.finish(arg_2_0)
end

function var_0_0.dispose(arg_3_0)
	var_0_0.super.dispose(arg_3_0)
end

return var_0_0
