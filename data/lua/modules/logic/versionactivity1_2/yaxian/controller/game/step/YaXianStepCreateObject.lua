module("modules.logic.versionactivity1_2.yaxian.controller.game.step.YaXianStepCreateObject", package.seeall)

local var_0_0 = class("YaXianStepCreateObject", YaXianStepBase)

function var_0_0.start(arg_1_0)
	local var_1_0 = arg_1_0.originData.id

	YaXianGameModel.instance:removeObjectById(var_1_0)
	YaXianGameController.instance:deleteInteractObj(var_1_0)

	local var_1_1 = YaXianGameModel.instance:addObject(arg_1_0.originData)

	YaXianGameController.instance:addInteractObj(var_1_1)
	logNormal("create object finish !" .. tostring(var_1_1.id))
	arg_1_0:finish()
end

return var_0_0
