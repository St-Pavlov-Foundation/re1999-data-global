module("modules.logic.explore.controller.steps.ExploreArchiveStep", package.seeall)

slot0 = class("ExploreArchiveStep", ExploreStepBase)

function slot0.onStart(slot0)
	ExploreSimpleModel.instance:onGetArchive(slot0._data.archiveId)
	slot0:onDone()
end

return slot0
