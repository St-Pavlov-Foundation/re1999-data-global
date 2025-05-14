module("modules.logic.dungeon.model.DungeonPuzzleQuestionModel", package.seeall)

local var_0_0 = class("DungeonPuzzleQuestionModel", BaseModel)

function var_0_0.reInit(arg_1_0)
	arg_1_0:release()
end

function var_0_0.initByElementCo(arg_2_0, arg_2_1)
	arg_2_0._cfgElement = arg_2_1

	if arg_2_0._cfgElement and arg_2_0._cfgElement.param then
		arg_2_0._cfgQuestion = DungeonConfig.instance:getPuzzleQuestionCo(tonumber(arg_2_0._cfgElement.param))

		if arg_2_0._cfgQuestion then
			local var_2_0 = "#"

			arg_2_0._answer = string.split(arg_2_0._cfgQuestion.answer, var_2_0)
			arg_2_0._desc = string.split(arg_2_0._cfgQuestion.desc, var_2_0)
			arg_2_0._descEn = string.split(arg_2_0._cfgQuestion.descEn, var_2_0)
			arg_2_0._title = string.split(arg_2_0._cfgQuestion.title, var_2_0)
			arg_2_0._titleEn = string.split(arg_2_0._cfgQuestion.titleEn, var_2_0)
			arg_2_0._question = string.split(arg_2_0._cfgQuestion.question, var_2_0)
			arg_2_0._questionCount = #arg_2_0._question

			if arg_2_0:CheckConfigAvailable() then
				arg_2_0._isReady = true

				arg_2_0:initAnswer()
			else
				logError("DungeonPuzzleQuestion confg error, id = " .. tostring(arg_2_0._cfgQuestion.id))
			end
		else
			logError("DungeonPuzzleQuestion confg not found, element id = " .. tostring(arg_2_0._cfgElement.id))
		end
	end
end

function var_0_0.initAnswer(arg_3_0)
	local var_3_0 = "|"
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._answer) do
		local var_3_2 = string.split(iter_3_1, var_3_0)
		local var_3_3 = {}

		for iter_3_2, iter_3_3 in ipairs(var_3_2) do
			var_3_3[iter_3_3] = true
		end

		var_3_1[iter_3_0] = var_3_3
	end

	arg_3_0._answer = var_3_1
end

function var_0_0.CheckConfigAvailable(arg_4_0)
	return #arg_4_0._desc == DungeonPuzzleEnum.hintCount and #arg_4_0._descEn == DungeonPuzzleEnum.hintCount and #arg_4_0._title == DungeonPuzzleEnum.hintCount and #arg_4_0._titleEn == DungeonPuzzleEnum.hintCount and #arg_4_0._question == #arg_4_0._answer
end

function var_0_0.getHint(arg_5_0, arg_5_1)
	return arg_5_0._title[arg_5_1], arg_5_0._titleEn[arg_5_1], arg_5_0._desc[arg_5_1], arg_5_0._descEn[arg_5_1]
end

function var_0_0.getQuestion(arg_6_0, arg_6_1)
	return arg_6_0._question[arg_6_1]
end

function var_0_0.getQuestionTitle(arg_7_0)
	return arg_7_0._cfgQuestion.questionTitle, arg_7_0._cfgQuestion.questionTitleEn
end

function var_0_0.getQuestionCount(arg_8_0)
	return arg_8_0._questionCount
end

function var_0_0.getIsReady(arg_9_0)
	return arg_9_0._isReady
end

function var_0_0.release(arg_10_0)
	arg_10_0._cfgElement = nil
	arg_10_0._cfgQuestion = nil
	arg_10_0._answer = nil
	arg_10_0._desc = nil
	arg_10_0._descEn = nil
	arg_10_0._question = nil
	arg_10_0._questionEn = nil
	arg_10_0._isReady = false
end

function var_0_0.getAnswers(arg_11_0, arg_11_1)
	return arg_11_0._answer[arg_11_1]
end

function var_0_0.getElementCo(arg_12_0)
	return arg_12_0._cfgElement
end

var_0_0.instance = var_0_0.New()

return var_0_0
