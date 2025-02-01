module("modules.logic.dialogue.config.DialogueConfig", package.seeall)

slot0 = class("DialogueConfig", BaseConfig)

function slot0.ctor(slot0)
end

function slot0.reqConfigNames(slot0)
	return {
		"dialog_group",
		"dialog",
		"dialog_step",
		"dialogue_chess_info"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "dialog" then
		slot0.dialogueDict = slot2
	elseif slot1 == "dialog_step" then
		slot0:initDialogueStepList(slot2.configList)
	elseif slot1 == "dialogue_chess_info" then
		slot0:initChessInfo(slot2.configList)
	end
end

function slot0.initDialogueStepList(slot0, slot1)
	slot0.dialogueGroup2StepList = {}

	for slot5, slot6 in ipairs(slot1) do
		if not slot0.dialogueGroup2StepList[slot6.groupId] then
			slot0.dialogueGroup2StepList[slot6.groupId] = {}
		end

		table.insert(slot7, slot6)
	end

	for slot5, slot6 in pairs(slot0.dialogueGroup2StepList) do
		table.sort(slot6, uv0.sortStepFunc)
	end
end

function slot0.sortStepFunc(slot0, slot1)
	return slot0.id < slot1.id
end

function slot0.initChessInfo(slot0, slot1)
	slot0.dialogueId2ChessCoList = {}

	for slot5, slot6 in ipairs(slot1) do
		if not slot0.dialogueId2ChessCoList[slot6.dialogueId] then
			slot0.dialogueId2ChessCoList[slot6.dialogueId] = {}
		end

		table.insert(slot7, slot6)
	end
end

function slot0.getDialogueCo(slot0, slot1)
	return slot0.dialogueDict.configDict[slot1]
end

function slot0.getDialogueStepList(slot0, slot1)
	if not slot0.dialogueGroup2StepList[slot1] then
		logError("not found group step , group id : " .. tostring(slot1))
	end

	return slot2
end

function slot0.getChessCoList(slot0, slot1)
	return slot0.dialogueId2ChessCoList[slot1]
end

slot0.instance = slot0.New()

return slot0
