module("modules.logic.dialogue.model.DialogueModel", package.seeall)

local var_0_0 = class("DialogueModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.dialogueDict = nil
end

function var_0_0.initDialogue(arg_3_0, arg_3_1)
	arg_3_0.dialogueDict = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		arg_3_0.dialogueDict[iter_3_1] = true
	end
end

function var_0_0.updateDialogueInfo(arg_4_0, arg_4_1)
	arg_4_0.dialogueDict[arg_4_1] = true

	DialogueController.instance:dispatchEvent(DialogueEvent.OnDialogueInfoChange, arg_4_1)
end

function var_0_0.isFinishDialogue(arg_5_0, arg_5_1)
	return arg_5_0.dialogueDict and arg_5_0.dialogueDict[arg_5_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
