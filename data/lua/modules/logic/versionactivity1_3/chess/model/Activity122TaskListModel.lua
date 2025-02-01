module("modules.logic.versionactivity1_3.chess.model.Activity122TaskListModel", package.seeall)

slot0 = class("Activity122TaskListModel", ListScrollModel)
slot1 = -100

function slot0.init(slot0, slot1)
	slot3 = {}
	slot4 = 0

	if TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity122) ~= nil then
		for slot9, slot10 in ipairs(Activity122Config.instance:getTaskByActId(slot1)) do
			slot11 = Activity122TaskMO.New()

			slot11:init(slot10, slot2[slot10.id])

			if slot11:haveRewardToGet() then
				slot4 = slot4 + 1
			end

			table.insert(slot3, slot11)
		end
	end

	if slot4 > 1 then
		slot5 = Activity122TaskMO.New()
		slot5.id = uv0
		slot5.activityId = slot1

		table.insert(slot3, slot5)
	end

	table.sort(slot3, uv1.sortMO)
	slot0:setList(slot3)
end

function slot0.sortMO(slot0, slot1)
	if uv0.getSortIndex(slot0) ~= uv0.getSortIndex(slot1) then
		return slot2 < slot3
	elseif slot0.id ~= slot1.id then
		return slot0.id < slot1.id
	end
end

function slot0.getSortIndex(slot0)
	if slot0.id == uv0 then
		return 1
	elseif slot0:haveRewardToGet() then
		return 2
	elseif slot0:alreadyGotReward() then
		return 100
	end

	return 50
end

function slot0.createMO(slot0, slot1, slot2)
	return {
		config = slot2.config,
		originTaskMO = slot2
	}
end

slot0.instance = slot0.New()

return slot0
