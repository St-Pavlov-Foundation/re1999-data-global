module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepGameReStart", package.seeall)

local var_0_0 = class("XugoujiGameStepGameReStart", XugoujiGameStepBase)
local var_0_1 = VersionActivity2_6Enum.ActivityId.Xugouji

function var_0_0.start(arg_1_0)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.GameRestartCardDisplay)
	TaskDispatcher.runDelay(arg_1_0.finish, arg_1_0, 0.5)
end

function var_0_0.dispose(arg_2_0)
	XugoujiGameStepBase.dispose(arg_2_0)
end

return var_0_0
