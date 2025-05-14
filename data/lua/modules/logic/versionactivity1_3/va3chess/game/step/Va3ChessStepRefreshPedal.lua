module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepRefreshPedal", package.seeall)

local var_0_0 = class("Va3ChessStepRefreshPedal", Va3ChessStepBase)

function var_0_0.start(arg_1_0)
	local var_1_0 = arg_1_0.originData.id
	local var_1_1 = arg_1_0.originData.pedalStatus

	if var_1_0 and var_1_0 > 0 then
		local var_1_2 = Va3ChessGameController.instance.interacts
		local var_1_3 = var_1_2 and var_1_2:get(var_1_0)

		if var_1_3 and var_1_3.originData then
			var_1_3.originData:setPedalStatus(var_1_1)
		end
	end

	arg_1_0:finish()
end

return var_0_0
