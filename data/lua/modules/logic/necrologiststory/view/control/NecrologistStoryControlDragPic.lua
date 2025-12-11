module("modules.logic.necrologiststory.view.control.NecrologistStoryControlDragPic", package.seeall)

local var_0_0 = class("NecrologistStoryControlDragPic", NecrologistStoryControlMgrItem)

function var_0_0.onPlayControl(arg_1_0)
	arg_1_0:getControlItem(NecrologistStoryDragPictureItem)
end

return var_0_0
