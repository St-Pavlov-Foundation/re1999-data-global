module("modules.logic.versionactivity1_4.act134.model.Activity134Model", package.seeall)

slot0 = class("Activity134Model", BaseModel)

function slot0.ctor(slot0)
	slot0.super:ctor()

	slot0.serverTaskModel = BaseModel.New()
end

function slot0.onInitMo(slot0, slot1)
	slot0.actId = slot1.activityId

	slot0:initStory(slot1.hasGetBonusIds)
	slot0:setTasksInfo(slot1.tasks)
end

function slot0.getCurActivityID(slot0)
	return slot0.actId
end

function slot0.initStory(slot0, slot1)
	slot0.storyMoList = {}
	slot0.finishStoryCount = #slot1
	slot0.maxNeedClueCount = 0

	for slot5, slot6 in ipairs(Activity134Config.instance:getBonusAllConfig()) do
		Activity134StoryMo.New():init(slot5, slot6)

		slot7.status = slot1[slot6.id] and Activity134Enum.StroyStatus.Finish or Activity134Enum.StroyStatus.Orgin
		slot0.maxNeedClueCount = Mathf.Max(slot0.maxNeedClueCount, slot7.needTokensQuantity)

		table.insert(slot0.storyMoList, slot7)
	end

	table.sort(slot0.storyMoList, function (slot0, slot1)
		return slot0.needTokensQuantity < slot1.needTokensQuantity
	end)
end

function slot0.getStoryMoByIndex(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.storyMoList) do
		if slot6.index == slot1 then
			return slot6
		end
	end
end

function slot0.getStoryMoById(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.storyMoList) do
		if slot1 == slot6.config.id then
			return slot6
		end
	end
end

function slot0.getAllStoryMo(slot0)
	return slot0.storyMoList
end

function slot0.getStoryTotalCount(slot0)
	return #slot0.storyMoList
end

function slot0.getFinishStoryCount(slot0)
	return slot0.finishStoryCount
end

function slot0.getClueCount(slot0)
	if CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Act134Clue) then
		return slot1.quantity
	end
end

function slot0.getMaxClueCount(slot0)
	return slot0.maxNeedClueCount
end

function slot0.checkGetStoryBonus(slot0)
	slot2 = nil

	for slot6, slot7 in ipairs(slot0.storyMoList) do
		if slot7.status == Activity134Enum.StroyStatus.Orgin and tonumber(slot7.needTokensQuantity) <= slot0:getClueCount() then
			Activity134Rpc.instance:sendGet134BonusRequest(slot0.actId, slot7.config.id)

			slot2 = true
		end
	end

	return slot2
end

function slot0.onReceiveBonus(slot0, slot1)
	if not slot1 then
		return
	end

	if not slot0.storyMoList[slot1] or slot2.status == Activity134Enum.StroyStatus.Finish then
		return
	end

	slot2.status = Activity134Enum.StroyStatus.Finish
	slot0.finishStoryCount = Mathf.Max(slot0.finishStoryCount, slot2.index)
end

function slot0.getTaskMoById(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.serverTaskModel) do
		if slot1 == slot6.config.id then
			return slot6
		end
	end
end

function slot0.getTasksInfo(slot0)
	return slot0.serverTaskModel:getList()
end

function slot0.setTasksInfo(slot0, slot1)
	slot2 = nil

	for slot6, slot7 in ipairs(slot1) do
		if slot0.serverTaskModel:getById(slot7.id) then
			slot8:update(slot7)
		elseif Activity134Config.instance:getTaskConfig(slot7.id) then
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

function slot0.deleteInfo(slot0, slot1)
	for slot6, slot7 in pairs(slot1) do
		if slot0.serverTaskModel:getById(slot7) then
			-- Nothing
		end
	end

	for slot6, slot7 in pairs({
		[slot7] = slot8
	}) do
		slot0.serverTaskModel:remove(slot7)
	end

	if next(slot2) then
		slot0:sortList()
	end

	return slot3
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

function slot0.getBonusFillWidth(slot0)
	if slot0:getClueCount() <= 0 then
		return 0
	end

	slot2 = 0
	slot3 = 0
	slot4 = 0
	slot5 = 0
	slot6 = slot0:getStoryTotalCount()

	for slot10, slot11 in ipairs(slot0.storyMoList) do
		if slot11.needTokensQuantity < slot1 then
			slot2 = slot11.index

			break
		end
	end

	if slot0:getMaxClueCount() < slot1 then
		slot2 = slot6
	end

	if slot2 == 0 then
		slot4 = -30
		slot5 = slot0.storyMoList[1].needTokensQuantity
	elseif slot6 <= slot2 then
		slot5 = slot0.storyMoList[slot6].needTokensQuantity
	else
		slot4 = slot0.storyMoList[slot2].needTokensQuantity
		slot5 = slot0.storyMoList[slot2 + 1].needTokensQuantity
	end

	return 970 + 310 * (slot2 - 1 + (slot5 == slot4 and 0 or (slot1 - slot4) / (slot5 - slot4)))
end

slot0.instance = slot0.New()

return slot0
