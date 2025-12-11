module("modules.logic.necrologiststory.view.control.NecrologistStoryControlWeather", package.seeall)

local var_0_0 = class("NecrologistStoryControlWeather", NecrologistStoryControlMgrItem)

function var_0_0.onPlayControl(arg_1_0)
	local var_1_0 = tonumber(arg_1_0.controlParam)

	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnChangeWeather, var_1_0)
	arg_1_0:onPlayControlFinish()
end

return var_0_0
