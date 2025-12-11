module("modules.logic.necrologiststory.view.control.NecrologistStoryControlErasePic", package.seeall)

local var_0_0 = class("NecrologistStoryControlErasePic", NecrologistStoryControlMgrItem)

function var_0_0.onPlayControl(arg_1_0)
	arg_1_0:getControlItem(NecrologistStoryErasePictureItem)
end

return var_0_0
