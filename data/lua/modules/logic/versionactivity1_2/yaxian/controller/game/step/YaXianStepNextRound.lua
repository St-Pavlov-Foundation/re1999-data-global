module("modules.logic.versionactivity1_2.yaxian.controller.game.step.YaXianStepNextRound", package.seeall)

local var_0_0 = class("YaXianStepNextRound", YaXianStepBase)

function var_0_0.start(arg_1_0)
	local var_1_0 = YaXianGameController.instance.state

	if var_1_0 then
		var_1_0:setCurEvent(nil)
	end

	local var_1_1 = arg_1_0.originData.currentRound

	YaXianGameModel.instance:setRound(var_1_1)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.UpdateRound)
	arg_1_0:finish()
end

return var_0_0
