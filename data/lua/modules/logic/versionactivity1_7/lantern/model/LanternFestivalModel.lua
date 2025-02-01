module("modules.logic.versionactivity1_7.lantern.model.LanternFestivalModel", package.seeall)

slot0 = class("LanternFestivalModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._loginCount = 0
	slot0._puzzleInfos = {}
end

function slot0.setActivity154Infos(slot0, slot1)
	slot0._loginCount = slot1.loginCount
	slot0._puzzleInfos = {}

	for slot5, slot6 in ipairs(slot1.infos) do
		slot7 = LanternFestivalPuzzleMo.New()

		slot7:init(slot6)

		slot0._puzzleInfos[slot6.puzzleId] = slot7
	end
end

function slot0.getLoginCount(slot0)
	return slot0._loginCount
end

function slot0.getPuzzleInfo(slot0, slot1)
	return slot0._puzzleInfos[slot1]
end

function slot0.updatePuzzleInfo(slot0, slot1)
	if slot0._puzzleInfos[slot1.puzzleId] then
		slot0._puzzleInfos[slot1.puzzleId]:reset(slot1)
	else
		slot2 = LanternFestivalPuzzleMo.New()

		slot2:init(slot1)

		slot0._puzzleInfos[slot1.puzzleId] = slot2
	end
end

function slot0.isPuzzleUnlock(slot0, slot1)
	return slot0._puzzleInfos[slot1].state ~= LanternFestivalEnum.PuzzleState.Lock
end

function slot0.isPuzzleGiftGet(slot0, slot1)
	return slot0._puzzleInfos[slot1].state == LanternFestivalEnum.PuzzleState.RewardGet
end

function slot0.getPuzzleState(slot0, slot1)
	return slot0._puzzleInfos[slot1].state
end

function slot0.getPuzzleOptionState(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot0._puzzleInfos[slot1].answerRecords) do
		if slot7 == slot2 then
			if LanternFestivalConfig.instance:getPuzzleCo(slot1).answerId == slot2 then
				return LanternFestivalEnum.OptionState.Right
			else
				return LanternFestivalEnum.OptionState.Wrong
			end
		end
	end

	return LanternFestivalEnum.OptionState.UnAnswer
end

function slot0.getCurPuzzleId(slot0)
	if not slot0._curPuzzleId or slot0._curPuzzleId == 0 then
		slot0._curPuzzleId = LanternFestivalConfig.instance:getAct154Co(nil, slot0._loginCount > 5 and 5 or slot0._loginCount).puzzleId
		slot2 = 0

		for slot6, slot7 in pairs(slot0._puzzleInfos) do
			if slot7.state == LanternFestivalEnum.PuzzleState.Solved or slot7.state == LanternFestivalEnum.PuzzleState.RewardGet then
				slot2 = slot7.puzzleId < slot2 and slot2 or slot7.puzzleId
			end
		end

		if slot2 > 0 then
			slot0._curPuzzleId = slot2
		end
	end

	return slot0._curPuzzleId
end

function slot0.setCurPuzzleId(slot0, slot1)
	slot0._curPuzzleId = slot1
end

function slot0.hasPuzzleCouldGetReward(slot0)
	for slot4, slot5 in pairs(slot0._puzzleInfos) do
		if slot5.state ~= LanternFestivalEnum.PuzzleState.Lock and slot5.state ~= LanternFestivalEnum.PuzzleState.RewardGet then
			return true
		end
	end

	return false
end

function slot0.isAllPuzzleFinished(slot0)
	for slot5, slot6 in pairs(LanternFestivalConfig.instance:getAct154Cos()) do
		if not slot0:isPuzzleGiftGet(slot6.puzzleId) then
			return false
		end
	end

	return true
end

function slot0.isAllPuzzleUnSolved(slot0)
	for slot4, slot5 in pairs(slot0._puzzleInfos) do
		if slot5.state == LanternFestivalEnum.PuzzleState.Solved or slot5.state == LanternFestivalEnum.PuzzleState.RewardGet then
			return false
		end
	end

	return true
end

slot0.instance = slot0.New()

return slot0
