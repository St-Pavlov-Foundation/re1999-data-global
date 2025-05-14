module("modules.logic.guide.controller.GuideSpecialController", package.seeall)

local var_0_0 = class("GuideSpecialController", BaseController)

function var_0_0.onInitFinish(arg_1_0)
	arg_1_0._guideJumpHandler = GuideJumpHandler.New()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._guideJumpHandler:reInit()
end

var_0_0.instance = var_0_0.New()

return var_0_0
