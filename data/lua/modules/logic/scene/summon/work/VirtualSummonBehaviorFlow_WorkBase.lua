module("modules.logic.scene.summon.work.VirtualSummonBehaviorFlow_WorkBase", package.seeall)

local var_0_0 = class("VirtualSummonBehaviorFlow_WorkBase", BaseWork)
local var_0_1 = 3

function var_0_0.startBlock(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_1 or arg_1_0.class.__cname

	UIBlockHelper.instance:startBlock(var_1_0, arg_1_2 or var_0_1)

	return var_1_0
end

function var_0_0.endBlock(arg_2_0, arg_2_1)
	UIBlockHelper.instance:startBlock(arg_2_1 or arg_2_0.class.__cname)
end

return var_0_0
