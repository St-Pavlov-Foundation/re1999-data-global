module("modules.logic.survival.controller.work.PopupViewFinishWork", package.seeall)

local var_0_0 = pureTable("PopupViewFinishWork", BaseWork)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0)
	PopupController.instance:registerCallback(PopupEvent.OnPopupFinish, arg_2_0.onPopupFinish, arg_2_0)
end

function var_0_0.onPopupFinish(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	PopupController.instance:unregisterCallback(PopupEvent.OnPopupFinish, arg_4_0.onPopupFinish, arg_4_0)
end

return var_0_0
