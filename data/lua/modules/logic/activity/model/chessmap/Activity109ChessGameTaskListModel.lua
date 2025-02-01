module("modules.logic.activity.model.chessmap.Activity109ChessGameTaskListModel", package.seeall)

slot0 = class("Activity109ChessGameTaskListModel", ListScrollModel)

function slot0.init(slot0, slot1)
	slot3 = Activity106Config.instance:getTaskByActId(slot1)
	slot4 = {}

	if TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity109) ~= nil then
		for slot8, slot9 in ipairs(slot3) do
			slot10 = Activity109ChessGameTaskMO.New()

			slot10:init(slot2[slot9.id])
			table.insert(slot4, slot10)
		end

		table.sort(slot4, uv0.sortMO)
	end

	slot0:setList(slot4)
end

function slot0.sortMO(slot0, slot1)
	if slot0:alreadyGotReward() ~= slot1:alreadyGotReward() then
		return slot3
	else
		return slot0.id < slot1.id
	end
end

function slot0.createMO(slot0, slot1, slot2)
	return {
		config = slot2.config,
		originTaskMO = slot2
	}
end

slot0.instance = slot0.New()

return slot0
