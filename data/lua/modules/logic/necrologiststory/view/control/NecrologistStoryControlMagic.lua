module("modules.logic.necrologiststory.view.control.NecrologistStoryControlMagic", package.seeall)

local var_0_0 = class("NecrologistStoryControlMagic", NecrologistStoryControlMgrItem)

function var_0_0.onPlayControl(arg_1_0)
	arg_1_0:getControlItem(NecrologistStoryMagicItem)
end

return var_0_0
