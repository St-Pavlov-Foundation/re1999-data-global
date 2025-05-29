module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepResult", package.seeall)

local var_0_0 = class("XugoujiGameStepResult", XugoujiGameStepBase)

function var_0_0.start(arg_1_0)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.GameResult, arg_1_0._stepData)
	XugoujiGameStepController.instance:disposeAllStep()
end

return var_0_0
