module("modules.logic.dungeon.model.DungeonPuzzleQuestionModel", package.seeall)

slot0 = class("DungeonPuzzleQuestionModel", BaseModel)

function slot0.reInit(slot0)
	slot0:release()
end

function slot0.initByElementCo(slot0, slot1)
	slot0._cfgElement = slot1

	if slot0._cfgElement and slot0._cfgElement.param then
		slot0._cfgQuestion = DungeonConfig.instance:getPuzzleQuestionCo(tonumber(slot0._cfgElement.param))

		if slot0._cfgQuestion then
			slot2 = "#"
			slot0._answer = string.split(slot0._cfgQuestion.answer, slot2)
			slot0._desc = string.split(slot0._cfgQuestion.desc, slot2)
			slot0._descEn = string.split(slot0._cfgQuestion.descEn, slot2)
			slot0._title = string.split(slot0._cfgQuestion.title, slot2)
			slot0._titleEn = string.split(slot0._cfgQuestion.titleEn, slot2)
			slot0._question = string.split(slot0._cfgQuestion.question, slot2)
			slot0._questionCount = #slot0._question

			if slot0:CheckConfigAvailable() then
				slot0._isReady = true

				slot0:initAnswer()
			else
				logError("DungeonPuzzleQuestion confg error, id = " .. tostring(slot0._cfgQuestion.id))
			end
		else
			logError("DungeonPuzzleQuestion confg not found, element id = " .. tostring(slot0._cfgElement.id))
		end
	end
end

function slot0.initAnswer(slot0)
	slot1 = "|"
	slot2 = {}

	for slot6, slot7 in ipairs(slot0._answer) do
		for slot13, slot14 in ipairs(string.split(slot7, slot1)) do
			-- Nothing
		end

		slot2[slot6] = {
			[slot14] = true
		}
	end

	slot0._answer = slot2
end

function slot0.CheckConfigAvailable(slot0)
	return #slot0._desc == DungeonPuzzleEnum.hintCount and #slot0._descEn == DungeonPuzzleEnum.hintCount and #slot0._title == DungeonPuzzleEnum.hintCount and #slot0._titleEn == DungeonPuzzleEnum.hintCount and #slot0._question == #slot0._answer
end

function slot0.getHint(slot0, slot1)
	return slot0._title[slot1], slot0._titleEn[slot1], slot0._desc[slot1], slot0._descEn[slot1]
end

function slot0.getQuestion(slot0, slot1)
	return slot0._question[slot1]
end

function slot0.getQuestionTitle(slot0)
	return slot0._cfgQuestion.questionTitle, slot0._cfgQuestion.questionTitleEn
end

function slot0.getQuestionCount(slot0)
	return slot0._questionCount
end

function slot0.getIsReady(slot0)
	return slot0._isReady
end

function slot0.release(slot0)
	slot0._cfgElement = nil
	slot0._cfgQuestion = nil
	slot0._answer = nil
	slot0._desc = nil
	slot0._descEn = nil
	slot0._question = nil
	slot0._questionEn = nil
	slot0._isReady = false
end

function slot0.getAnswers(slot0, slot1)
	return slot0._answer[slot1]
end

function slot0.getElementCo(slot0)
	return slot0._cfgElement
end

slot0.instance = slot0.New()

return slot0
