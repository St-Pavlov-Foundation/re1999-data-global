module("modules.logic.versionactivity2_4.pinball.view.PinballLoadingViewContainer", package.seeall)

local var_0_0 = class("PinballLoadingViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {}
end

function var_0_0.onContainerOpen(arg_2_0)
	TaskDispatcher.runDelay(arg_2_0.closeThis, arg_2_0, arg_2_0._viewSetting.delayTime or 2)
end

function var_0_0.onContainerClose(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0.closeThis, arg_3_0)
end

return var_0_0
