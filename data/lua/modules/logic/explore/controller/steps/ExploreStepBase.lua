module("modules.logic.explore.controller.steps.ExploreStepBase", package.seeall)

local var_0_0 = class("ExploreStepBase")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._data = arg_1_1

	arg_1_0:onInit()
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onStart(arg_3_0)
	arg_3_0:onDone()
end

function var_0_0.onDone(arg_4_0)
	arg_4_0:onDestory()

	return ExploreStepController.instance:onStepEnd()
end

function var_0_0.onDestory(arg_5_0)
	arg_5_0._data = nil
end

return var_0_0
