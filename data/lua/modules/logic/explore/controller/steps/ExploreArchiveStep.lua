module("modules.logic.explore.controller.steps.ExploreArchiveStep", package.seeall)

local var_0_0 = class("ExploreArchiveStep", ExploreStepBase)

function var_0_0.onStart(arg_1_0)
	ExploreSimpleModel.instance:onGetArchive(arg_1_0._data.archiveId)
	arg_1_0:onDone()
end

return var_0_0
