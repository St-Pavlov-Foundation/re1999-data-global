module("modules.logic.explore.controller.trigger.ExploreTriggerOpenArchiveView", package.seeall)

slot0 = class("ExploreTriggerOpenArchiveView", ExploreTriggerBase)

function slot0.handle(slot0, slot1, slot2)
	ExploreStepController.instance:insertClientStep({
		stepType = ExploreEnum.StepType.ArchiveClient,
		archiveId = slot2.mo.archiveId
	}, 1)
	ExploreStepController.instance:startStep()
	slot0:onDone(true)
end

return slot0
