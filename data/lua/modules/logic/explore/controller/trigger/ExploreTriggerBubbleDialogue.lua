module("modules.logic.explore.controller.trigger.ExploreTriggerBubbleDialogue", package.seeall)

slot0 = class("ExploreTriggerBubbleDialogue", ExploreTriggerBase)

function slot0.handle(slot0, slot1, slot2)
	slot2.uiComp:addUI(ExploreUnitDialogueView):setDialogueId(slot1)
	slot0:onStepDone(true)
end

return slot0
