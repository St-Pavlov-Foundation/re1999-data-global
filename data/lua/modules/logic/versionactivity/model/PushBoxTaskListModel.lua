module("modules.logic.versionactivity.model.PushBoxTaskListModel", package.seeall)

slot0 = class("PushBoxTaskListModel", ListScrollModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.initData(slot0, slot1)
	slot0.data = {}

	for slot5, slot6 in ipairs(slot1) do
		table.insert(slot0.data, {
			id = slot6.taskId,
			config = slot6
		})
	end
end

function slot0.sortData(slot0)
	table.sort(slot0.data, uv0.sortList)
end

function slot0.sortList(slot0, slot1)
	if PushBoxModel.instance:getTaskData(slot0.config.taskId).hasGetBonus and not PushBoxModel.instance:getTaskData(slot1.config.taskId).hasGetBonus then
		return false
	elseif not slot2.hasGetBonus and slot3.hasGetBonus then
		return true
	elseif slot0.config.maxProgress <= slot2.progress and not (slot1.config.maxProgress <= slot3.progress) then
		return true
	elseif not slot4 and slot5 then
		return false
	else
		return slot0.config.sort < slot1.config.sort
	end
end

function slot0.refreshData(slot0)
	slot0:setList(slot0.data)
end

function slot0.clearData(slot0)
	slot0:clear()

	slot0.data = nil
end

slot0.instance = slot0.New()

return slot0
