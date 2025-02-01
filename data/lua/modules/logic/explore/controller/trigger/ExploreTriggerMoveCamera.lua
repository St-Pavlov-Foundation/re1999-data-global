module("modules.logic.explore.controller.trigger.ExploreTriggerMoveCamera", package.seeall)

slot0 = class("ExploreTriggerMoveCamera", ExploreTriggerBase)

function slot0.handle(slot0, slot1, slot2)
	slot3 = string.splitToNumber(slot1, "#")

	ExploreStepController.instance:insertClientStep({
		stepType = ExploreEnum.StepType.CameraMove,
		id = slot3[1],
		moveTime = slot3[2],
		keepTime = slot3[3]
	}, 1)
	ExploreStepController.instance:startStep()
	ExploreController.instance:getMap():getHero():stopMoving()
	slot0:onDone(true)
end

return slot0
