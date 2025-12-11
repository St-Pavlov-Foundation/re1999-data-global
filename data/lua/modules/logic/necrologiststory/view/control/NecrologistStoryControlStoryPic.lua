module("modules.logic.necrologiststory.view.control.NecrologistStoryControlStoryPic", package.seeall)

local var_0_0 = class("NecrologistStoryControlStoryPic", NecrologistStoryControlMgrItem)

function var_0_0.onPlayControl(arg_1_0)
	local var_1_0 = arg_1_0.controlParam

	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnChangePic, var_1_0)
	arg_1_0:onPlayControlFinish()
end

return var_0_0
