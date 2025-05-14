module("modules.logic.explore.controller.steps.ExploreDialogueStep", package.seeall)

local var_0_0 = class("ExploreDialogueStep", ExploreStepBase)

function var_0_0.onStart(arg_1_0)
	ViewMgr.instance:openView(ViewName.ExploreInteractView, arg_1_0._data)
	arg_1_0:onDone()
end

return var_0_0
