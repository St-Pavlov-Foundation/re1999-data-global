module("modules.logic.versionactivity1_2.yaxian.controller.game.step.YaXianStepInteractFinish", package.seeall)

local var_0_0 = class("YaXianStepInteractFinish", YaXianStepBase)

function var_0_0.start(arg_1_0)
	local var_1_0 = arg_1_0.originData.id

	YaXianGameModel.instance:addFinishInteract(var_1_0)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.OnInteractFinish)
	arg_1_0:finish()
end

return var_0_0
