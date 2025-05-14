module("modules.logic.explore.controller.trigger.ExploreTriggerOpenArchiveView", package.seeall)

local var_0_0 = class("ExploreTriggerOpenArchiveView", ExploreTriggerBase)

function var_0_0.handle(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {
		stepType = ExploreEnum.StepType.ArchiveClient,
		archiveId = arg_1_2.mo.archiveId
	}

	ExploreStepController.instance:insertClientStep(var_1_0, 1)
	ExploreStepController.instance:startStep()
	arg_1_0:onDone(true)
end

return var_0_0
