module("modules.logic.scene.summon.work.VirtualSummonBehaviorFlow", package.seeall)

local var_0_0 = class("VirtualSummonBehaviorFlow", FlowParallel)

function var_0_0.ctor(arg_1_0, ...)
	var_0_0.super.ctor(arg_1_0, ...)
	arg_1_0:addWork(VirtualSummonBehaviorFlow_Work1.New())
end

function var_0_0.start(arg_2_0, arg_2_1, arg_2_2)
	assert(arg_2_1 and #arg_2_1 > 0)

	arg_2_0._heroIdList = arg_2_1
	arg_2_0._backToMainSceneCallBack = arg_2_2

	var_0_0.super.start(arg_2_0)
end

function var_0_0.heroIdList(arg_3_0)
	return arg_3_0._heroIdList
end

function var_0_0.backToMainSceneCallBack(arg_4_0)
	return arg_4_0._backToMainSceneCallBack
end

function var_0_0.onDestroyView(arg_5_0)
	arg_5_0:destroy()
end

function var_0_0.addWork(arg_6_0, arg_6_1)
	var_0_0.super.addWork(arg_6_0, arg_6_1)
	arg_6_1:setRootInternal(arg_6_0)

	return arg_6_1
end

return var_0_0
