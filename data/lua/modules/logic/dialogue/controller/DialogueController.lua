module("modules.logic.dialogue.controller.DialogueController", package.seeall)

slot0 = class("DialogueController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.enterDialogue(slot0, slot1, slot2, slot3)
	ViewMgr.instance:openView(ViewName.DialogueView, {
		dialogueId = slot1,
		callback = slot2,
		callbackTarget = slot3
	})
end

slot0.instance = slot0.New()

return slot0
