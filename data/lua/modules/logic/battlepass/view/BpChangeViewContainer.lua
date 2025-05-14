module("modules.logic.battlepass.view.BpChangeViewContainer", package.seeall)

local var_0_0 = class("BpChangeViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {}
end

function var_0_0.onContainerOpen(arg_2_0)
	UIBlockMgr.instance:startBlock("BP_Switch")
	TaskDispatcher.runDelay(arg_2_0._delayClose, arg_2_0, 1)
end

function var_0_0._delayClose(arg_3_0)
	arg_3_0:closeThis()
end

function var_0_0.onContainerClose(arg_4_0)
	UIBlockMgr.instance:endBlock("BP_Switch")
	TaskDispatcher.cancelTask(arg_4_0._delayClose, arg_4_0)
end

return var_0_0
