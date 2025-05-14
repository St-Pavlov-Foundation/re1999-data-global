module("modules.logic.explore.controller.trigger.ExploreTriggerCameraCO", package.seeall)

local var_0_0 = class("ExploreTriggerCameraCO", ExploreTriggerBase)

function var_0_0.handle(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.cameraId = tonumber(arg_1_1)

	ExploreController.instance:dispatchEvent(ExploreEvent.OnChangeCameraCO, arg_1_0.cameraId)
	arg_1_0:onStepDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
