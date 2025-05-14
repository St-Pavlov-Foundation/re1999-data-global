module("modules.logic.rouge.map.work.WaitRougeInteractDoneWork", package.seeall)

local var_0_0 = class("WaitRougeInteractDoneWork", BaseWork)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = RougeMapModel.instance:getCurInteractive()

	if string.nilorempty(var_2_0) then
		return arg_2_0:onDone(true)
	end

	RougeMapController.instance:registerCallback(RougeMapEvent.onClearInteract, arg_2_0.onClearInteract, arg_2_0)
	RougeMapInteractHelper.triggerInteractive()
end

function var_0_0.onClearInteract(arg_3_0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onClearInteract, arg_3_0.onClearInteract, arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onClearInteract, arg_4_0.onClearInteract, arg_4_0)
end

return var_0_0
