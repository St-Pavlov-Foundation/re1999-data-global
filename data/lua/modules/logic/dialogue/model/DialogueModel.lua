module("modules.logic.dialogue.model.DialogueModel", package.seeall)

slot0 = class("DialogueModel", ListScrollModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
	slot0.dialogueDict = nil
end

function slot0.initDialogue(slot0, slot1)
	slot0.dialogueDict = {}

	for slot5, slot6 in ipairs(slot1) do
		slot0.dialogueDict[slot6] = true
	end
end

function slot0.updateDialogueInfo(slot0, slot1)
	slot0.dialogueDict[slot1] = true

	DialogueController.instance:dispatchEvent(DialogueEvent.OnDialogueInfoChange, slot1)
end

function slot0.isFinishDialogue(slot0, slot1)
	return slot0.dialogueDict and slot0.dialogueDict[slot1]
end

slot0.instance = slot0.New()

return slot0
