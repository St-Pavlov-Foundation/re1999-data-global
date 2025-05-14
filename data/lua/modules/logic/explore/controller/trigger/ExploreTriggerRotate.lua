module("modules.logic.explore.controller.trigger.ExploreTriggerRotate", package.seeall)

local var_0_0 = class("ExploreTriggerRotate", ExploreTriggerBase)

function var_0_0.handle(arg_1_0, arg_1_1, arg_1_2)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetRotateUnit, arg_1_2)
	arg_1_0:onDone(false)
end

return var_0_0
