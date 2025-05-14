module("modules.logic.versionactivity1_2.yaxian.controller.game.step.YaXianStepDeleteObject", package.seeall)

local var_0_0 = class("YaXianStepDeleteObject", YaXianStepBase)

function var_0_0.start(arg_1_0)
	local var_1_0 = YaXianGameModel.instance:getPlayerInteractMo()

	if var_1_0 and var_1_0.id == arg_1_0.originData.id and arg_1_0.originData.reason == YaXianGameEnum.DeleteInteractReason.Win then
		arg_1_0:finish()

		return
	end

	YaXianGameController.instance:dispatchEvent(YaXianEvent.DeleteInteractObj, arg_1_0.originData.id)
	arg_1_0:finish()
end

return var_0_0
