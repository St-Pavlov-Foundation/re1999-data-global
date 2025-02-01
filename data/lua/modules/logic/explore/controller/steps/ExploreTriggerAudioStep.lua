module("modules.logic.explore.controller.steps.ExploreTriggerAudioStep", package.seeall)

slot0 = class("ExploreTriggerAudioStep", ExploreStepBase)

function slot0.onStart(slot0)
	AudioMgr.instance:trigger(slot0._data.id)
	slot0:onDone()
end

return slot0
