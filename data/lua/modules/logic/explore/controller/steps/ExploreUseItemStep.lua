module("modules.logic.explore.controller.steps.ExploreUseItemStep", package.seeall)

local var_0_0 = class("ExploreUseItemStep", ExploreStepBase)

function var_0_0.onStart(arg_1_0)
	ExploreModel.instance:setUseItemUid(tostring(arg_1_0._data.itemUid))
	ExploreController.instance:getMap():checkAllRuneTrigger()
	arg_1_0:onDone()
end

return var_0_0
