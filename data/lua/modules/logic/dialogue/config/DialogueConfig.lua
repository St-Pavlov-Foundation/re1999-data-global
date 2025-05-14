module("modules.logic.dialogue.config.DialogueConfig", package.seeall)

local var_0_0 = class("DialogueConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"dialog_group",
		"dialog",
		"dialog_step",
		"dialogue_chess_info"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "dialog" then
		arg_3_0.dialogueDict = arg_3_2
	elseif arg_3_1 == "dialog_step" then
		arg_3_0:initDialogueStepList(arg_3_2.configList)
	elseif arg_3_1 == "dialogue_chess_info" then
		arg_3_0:initChessInfo(arg_3_2.configList)
	end
end

function var_0_0.initDialogueStepList(arg_4_0, arg_4_1)
	arg_4_0.dialogueGroup2StepList = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_0 = arg_4_0.dialogueGroup2StepList[iter_4_1.groupId]

		if not var_4_0 then
			var_4_0 = {}
			arg_4_0.dialogueGroup2StepList[iter_4_1.groupId] = var_4_0
		end

		table.insert(var_4_0, iter_4_1)
	end

	for iter_4_2, iter_4_3 in pairs(arg_4_0.dialogueGroup2StepList) do
		table.sort(iter_4_3, var_0_0.sortStepFunc)
	end
end

function var_0_0.sortStepFunc(arg_5_0, arg_5_1)
	return arg_5_0.id < arg_5_1.id
end

function var_0_0.initChessInfo(arg_6_0, arg_6_1)
	arg_6_0.dialogueId2ChessCoList = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		local var_6_0 = arg_6_0.dialogueId2ChessCoList[iter_6_1.dialogueId]

		if not var_6_0 then
			var_6_0 = {}
			arg_6_0.dialogueId2ChessCoList[iter_6_1.dialogueId] = var_6_0
		end

		table.insert(var_6_0, iter_6_1)
	end
end

function var_0_0.getDialogueCo(arg_7_0, arg_7_1)
	return arg_7_0.dialogueDict.configDict[arg_7_1]
end

function var_0_0.getDialogueStepList(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.dialogueGroup2StepList[arg_8_1]

	if not var_8_0 then
		logError("not found group step , group id : " .. tostring(arg_8_1))
	end

	return var_8_0
end

function var_0_0.getChessCoList(arg_9_0, arg_9_1)
	return arg_9_0.dialogueId2ChessCoList[arg_9_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
