module("modules.logic.versionactivity1_8.weila.model.ActWeilaTaskListModel", package.seeall)

slot0 = class("ActWeilaTaskListModel", ListScrollModel)

function slot0.init(slot0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.RoleActivity
	}, slot0.refreshData, slot0)
end

function slot0.refreshData(slot0)
	slot2 = {}

	for slot7, slot8 in ipairs(TaskModel.instance:getTaskMoList(TaskEnum.TaskType.RoleActivity, VersionActivity1_8Enum.ActivityId.Weila)) do
		if slot8.hasFinished then
			slot3 = 0 + 1
		end

		table.insert(slot2, slot8)
	end

	if slot3 > 1 then
		table.insert(slot2, TaskMo.New())
	end

	table.sort(slot2, uv0.sortMO)

	slot0._hasRankDiff = false

	slot0:setList(slot2)
end

function slot0.sortMO(slot0, slot1)
	if uv0.getSortIndex(slot0) ~= uv0.getSortIndex(slot1) then
		return slot2 < slot3
	elseif slot0.id ~= slot1.id then
		return slot0.id < slot1.id
	end
end

function slot0.getSortIndex(slot0)
	if slot0.id == 0 then
		return 1
	elseif slot0.finishCount > 0 or slot0.preFinish then
		return 100
	elseif slot0.hasFinished then
		return 2
	end

	return 50
end

function slot0.getRankDiff(slot0, slot1)
	if slot0._hasRankDiff and slot1 then
		slot3 = slot0:getIndex(slot1)

		if tabletool.indexOf(slot0._idIdxList, slot1.id) and slot3 then
			slot0._idIdxList[slot2] = -2

			return slot3 - slot2
		end
	end

	return 0
end

function slot0.refreshRankDiff(slot0)
	slot0._idIdxList = {}

	for slot5, slot6 in ipairs(slot0:getList()) do
		table.insert(slot0._idIdxList, slot6.id)
	end
end

function slot0.preFinish(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = false
	slot0._hasRankDiff = false

	slot0:refreshRankDiff()

	slot3 = 0
	slot4 = slot0:getList()

	if slot1.id == 0 then
		for slot8, slot9 in ipairs(slot4) do
			if slot9.hasFinished and slot9.id ~= 0 then
				slot9.preFinish = true
				slot2 = true
				slot3 = slot3 + 1
			end
		end
	elseif slot1.hasFinished then
		slot1.preFinish = true
		slot2 = true
		slot3 = slot3 + 1
	end

	if slot2 then
		if slot0:getById(0) and slot0:getGotRewardCount() < slot3 + 1 then
			tabletool.removeValue(slot4, slot5)
		end

		slot0._hasRankDiff = true

		table.sort(slot4, uv0.sortMO)
		slot0:setList(slot4)

		slot0._hasRankDiff = false
	end
end

function slot0.getGotRewardCount(slot0, slot1)
	for slot7, slot8 in ipairs(slot1 or slot0:getList()) do
		if slot8.hasFinished then
			slot3 = 0 + 1
		end
	end

	return slot3
end

slot0.instance = slot0.New()

return slot0
