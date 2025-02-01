module("modules.logic.versionactivity1_5.act142.model.Activity142TaskListModel", package.seeall)

slot0 = class("Activity142TaskListModel", ListScrollModel)

function slot1(slot0)
	if slot0.id == Activity142Enum.TASK_ALL_RECEIVE_ITEM_EMPTY_ID then
		return 1
	elseif slot0:haveRewardToGet() then
		return 2
	elseif slot0:alreadyGotReward() then
		return 100
	end

	return 50
end

function slot2(slot0, slot1)
	if uv0(slot0) ~= uv0(slot1) then
		return slot2 < slot3
	elseif slot0.id ~= slot1.id then
		return slot0.id < slot1.id
	end
end

function slot0.init(slot0, slot1)
	slot3 = {}
	slot4 = 0

	if TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity142) then
		for slot9, slot10 in ipairs(Activity142Config.instance:getTaskByActId(slot1)) do
			slot12 = Activity142TaskMO.New()

			slot12:init(slot10, slot2[slot10.id])

			if slot12:haveRewardToGet() then
				slot4 = slot4 + 1
			end

			table.insert(slot3, slot12)
		end
	end

	if slot4 > 1 then
		slot5 = Activity142TaskMO.New()
		slot5.id = Activity142Enum.TASK_ALL_RECEIVE_ITEM_EMPTY_ID
		slot5.activityId = slot1

		table.insert(slot3, slot5)
	end

	table.sort(slot3, uv0)
	slot0:setList(slot3)
end

slot0.instance = slot0.New()

return slot0
