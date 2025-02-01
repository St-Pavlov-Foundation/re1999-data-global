module("modules.logic.versionactivity1_5.peaceulu.model.PeaceUluModel", package.seeall)

slot0 = class("PeaceUluModel", BaseModel)

function slot0.ctor(slot0)
	slot0.super:ctor()

	slot0.serverTaskModel = BaseModel.New()
end

function slot0.setActivityInfo(slot0, slot1)
	slot0.removeNum = slot1.removeNum
	slot0.gameNum = slot1.gameNum
	slot0.hasGetBonusIds = slot1.hasGetBonusIds
	slot0.lastGameRecord = slot1.lastGameRecord

	slot0.serverTaskModel:clear()
	slot0:setTasksInfo(slot1.tasks)
end

function slot0.onGetRemoveTask(slot0, slot1)
	slot0.taskId = slot1.taskId
	slot0.removeNum = slot1.removeNum

	slot0:setTasksInfo(slot1.tasks)
	PeaceUluController.instance:dispatchEvent(PeaceUluEvent.OnUpdateInfo)
end

function slot0.checkTaskId(slot0)
	if slot0.taskId then
		return true
	end

	return false
end

function slot0.cleanTaskId(slot0)
	if slot0.taskId then
		slot0.taskId = nil
	end
end

function slot0.getLastGameRecord(slot0)
	return slot0.lastGameRecord
end

function slot0.onGetGameResult(slot0, slot1)
	slot0.gameRes = slot1.gameRes
	slot0.removeNum = slot1.removeNum
	slot0.gameNum = slot1.gameNum
	slot0.lastSelect = slot1.content

	slot0:setOtherChoice()
	PeaceUluController.instance:dispatchEvent(PeaceUluEvent.onGetGameResult)
end

function slot0.onUpdateReward(slot0, slot1)
	slot0.hasGetBonusIds = slot1.hasGetBonusIds
	slot0.bonusIds = slot1.bonusIds
end

function slot0.checkBonusIds(slot0)
	if slot0.bonusIds then
		return true
	end

	return false
end

function slot0.cleanBonusIds(slot0)
	if slot0.bonusIds then
		slot0.bonusIds = nil
	end
end

function slot0.checkCanRemove(slot0)
	if not slot0.removeNum or slot0.removeNum == 0 then
		return false
	end

	return true
end

function slot0.checkCanPlay(slot0)
	if not slot0.gameNum then
		return
	end

	if slot0.gameNum < PeaceUluConfig.instance:getGameTimes() then
		return true
	end

	return false
end

function slot0.getRemoveNum(slot0)
	if not slot0.removeNum or slot0.removeNum == 0 then
		return false
	end

	return slot0.removeNum
end

function slot0.getGameHaveTimes(slot0)
	if not slot0.gameNum then
		return
	end

	return PeaceUluConfig.instance:getGameTimes() - slot0.gameNum
end

function slot0.setOtherChoice(slot0)
	if slot0.gameRes == PeaceUluEnum.GameResult.Draw then
		slot0.otherChoice = slot0.lastSelect
	elseif slot0.gameRes == PeaceUluEnum.GameResult.Win then
		slot0.otherChoice = slot0:_gameRule(slot0.lastSelect, true)
	else
		slot0.otherChoice = slot0:_gameRule(slot0.lastSelect, false)
	end
end

function slot0._gameRule(slot0, slot1, slot2)
	if slot1 == PeaceUluEnum.Game.Scissors then
		if slot2 then
			return PeaceUluEnum.Game.Paper
		else
			return PeaceUluEnum.Game.Rock
		end
	elseif slot1 == PeaceUluEnum.Game.Rock then
		if slot2 then
			return PeaceUluEnum.Game.Scissors
		else
			return PeaceUluEnum.Game.Paper
		end
	elseif slot2 then
		return PeaceUluEnum.Game.Rock
	else
		return PeaceUluEnum.Game.Scissors
	end
end

function slot0.getGameRes(slot0)
	return slot0.gameRes
end

function slot0.setPlaying(slot0, slot1)
	slot0._isPlaying = slot1
end

function slot0.isPlaying(slot0)
	if slot0._isPlaying == true then
		return true
	end

	return false
end

function slot0.getSchedule(slot0)
	slot1 = 0
	slot2 = 0.1
	slot3 = 0.955
	slot4 = PeaceUluConfig.instance:getBonusCoList()
	slot5 = #slot4
	slot6 = PeaceUluConfig.instance:getProgressByIndex(1)
	slot7 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Act145).quantity
	slot8 = 0
	slot9 = 0
	slot10 = 0

	for slot14, slot15 in ipairs(slot4) do
		if PeaceUluConfig.instance:getProgressByIndex(slot14) <= slot7 then
			slot8 = slot14
			slot9 = PeaceUluConfig.instance:getProgressByIndex(slot14)
		else
			slot10 = PeaceUluConfig.instance:getProgressByIndex(slot14)

			break
		end
	end

	slot12 = (slot7 - slot9) / (slot10 - slot9)

	return slot8 == slot5 and 1 or slot8 - 1 + slot12 <= 0 and slot7 / slot6 * slot2 or slot2 + (slot3 - slot2) / (slot5 - 1) * (slot8 - 1 + slot12)
end

function slot0.checkGetReward(slot0, slot1)
	if slot0.hasGetBonusIds then
		for slot5, slot6 in pairs(slot0.hasGetBonusIds) do
			if slot6 == slot1 then
				return true
			end
		end
	end

	return false
end

function slot0.checkGetAllReward(slot0)
	if slot0.hasGetBonusIds and #PeaceUluConfig.instance:getBonusCoList() == #slot0.hasGetBonusIds then
		return true
	end

	return false
end

function slot0.getOtherChoice(slot0)
	return slot0.otherChoice
end

function slot0.getTasksInfo(slot0)
	return slot0.serverTaskModel:getList()
end

function slot0.setTasksInfo(slot0, slot1)
	slot2 = nil

	for slot6, slot7 in ipairs(slot1) do
		if slot0.serverTaskModel:getById(slot7.id) then
			slot8:update(slot7)
		elseif PeaceUluConfig.instance:getTaskCo(slot7.id) then
			slot8 = TaskMo.New()

			slot8:init(slot7, slot9)
			slot0.serverTaskModel:addAtLast(slot8)
		end

		slot2 = true
	end

	if slot2 then
		slot0:sortList()
	end

	return slot2
end

function slot0.sortList(slot0)
	slot0.serverTaskModel:sort(function (slot0, slot1)
		if (slot0.finishCount > 0 and 3 or slot0.config.maxProgress <= slot0.progress and 1 or 2) ~= (slot1.finishCount > 0 and 3 or slot1.config.maxProgress <= slot1.progress and 1 or 2) then
			return slot2 < slot3
		else
			return slot0.config.id < slot1.config.id
		end
	end)
end

slot0.instance = slot0.New()

return slot0
