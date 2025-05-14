module("modules.logic.activity.controller.chessmap.step.ActivityChessStepCreateObject", package.seeall)

local var_0_0 = class("ActivityChessStepCreateObject", ActivityChessStepBase)

function var_0_0.start(arg_1_0)
	local var_1_0 = arg_1_0.originData.id
	local var_1_1 = arg_1_0.originData.x
	local var_1_2 = arg_1_0.originData.y
	local var_1_3 = ActivityChessGameModel.instance:getActId()

	ActivityChessGameModel.instance:removeObjectById(var_1_0)
	ActivityChessGameController.instance:deleteInteractObj(var_1_0)

	local var_1_4 = ActivityChessGameModel.instance:addObject(var_1_3, arg_1_0.originData)

	ActivityChessGameController.instance:addInteractObj(var_1_4)
	logNormal("create object finish !" .. tostring(var_1_4.id))
	arg_1_0:finish()
end

return var_0_0
