module("modules.logic.versionactivity1_4.act133.model.Activity133Model", package.seeall)

slot0 = class("Activity133Model", BaseModel)

function slot0.ctor(slot0)
	slot0.super:ctor()

	slot0.serverTaskModel = BaseModel.New()
end

function slot0.setActivityInfo(slot0, slot1)
	slot0.actId = slot1.activityId
	slot0.hasGetBonusIds = slot1.hasGetBonusIds

	slot0:setTasksInfo(slot1.tasks)
end

function slot0.getTasksInfo(slot0)
	return slot0.serverTaskModel:getList()
end

function slot0.setTasksInfo(slot0, slot1)
	slot2 = nil

	for slot6, slot7 in ipairs(slot1) do
		if slot0.serverTaskModel:getById(slot7.id) then
			slot8:update(slot7)
		elseif Activity133Config.instance:getTaskCo(slot7.id) then
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

	if next(slot2) and true or false then
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

function slot0.checkBonusReceived(slot0, slot1)
	for slot5, slot6 in pairs(slot0.hasGetBonusIds) do
		if slot6 == slot1 then
			return true
		end
	end

	return false
end

function slot0.getFixedNum(slot0)
	if slot0.hasGetBonusIds then
		return #slot0.hasGetBonusIds
	end

	return 0
end

function slot0.setSelectID(slot0, slot1)
	if not slot0._selectid then
		slot0._selectid = slot1
	end

	slot0._selectid = slot1
end

function slot0.getSelectID(slot0)
	return slot0._selectid
end

slot0.instance = slot0.New()

return slot0
