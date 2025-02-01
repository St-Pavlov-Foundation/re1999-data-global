module("modules.logic.explore.controller.trigger.ExploreTriggerDialogue", package.seeall)

slot0 = class("ExploreTriggerDialogue", ExploreTriggerBase)

function slot0.handle(slot0, slot1, slot2)
	slot1 = tonumber(slot1)

	if slot0.isNoFirstDialog then
		ExploreStepController.instance:insertClientStep({
			alwaysLast = true,
			stepType = ExploreEnum.StepType.Dialogue,
			id = slot1
		})
		slot0:onDone(true)

		return
	end

	ViewMgr.instance:openView(ViewName.ExploreInteractView, {
		id = slot1,
		unit = slot2,
		callBack = slot0.dialogueAccept,
		callBackObj = slot0,
		refuseCallBack = slot0.dialogueRefuse,
		refuseCallBackObj = slot0
	})
	ExploreController.instance:getMap():getHero():stopMoving(false)
end

function slot0.dialogueAccept(slot0)
	slot0:onDone(true)
end

function slot0.dialogueRefuse(slot0)
	slot0:onDone(false)
end

function slot0.clearWork(slot0)
	ViewMgr.instance:closeView(ViewName.ExploreInteractView)
end

return slot0
