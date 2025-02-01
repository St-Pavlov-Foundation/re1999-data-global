module("modules.logic.explore.controller.steps.ExploreDialogueStep", package.seeall)

slot0 = class("ExploreDialogueStep", ExploreStepBase)

function slot0.onStart(slot0)
	ViewMgr.instance:openView(ViewName.ExploreInteractView, slot0._data)
	slot0:onDone()
end

return slot0
