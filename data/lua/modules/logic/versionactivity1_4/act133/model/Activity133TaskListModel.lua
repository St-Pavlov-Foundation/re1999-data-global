module("modules.logic.versionactivity1_4.act133.model.Activity133TaskListModel", package.seeall)

slot0 = class("Activity133TaskListModel", ListScrollModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.sortTaskMoList(slot0)
	slot2 = {}
	slot3 = {}
	slot4 = {}

	for slot8, slot9 in pairs(Activity133Model.instance:getTasksInfo()) do
		if slot9.config.maxProgress <= slot9.finishCount then
			table.insert(slot4, slot9)
		elseif slot9.hasFinished then
			table.insert(slot2, slot9)
		else
			table.insert(slot3, slot9)
		end
	end

	table.sort(slot2, uv0._sortFunc)
	table.sort(slot3, uv0._sortFunc)
	table.sort(slot4, uv0._sortFunc)

	slot0.taskMoList = {}

	tabletool.addValues(slot0.taskMoList, slot2)
	tabletool.addValues(slot0.taskMoList, slot3)
	tabletool.addValues(slot0.taskMoList, slot4)
	slot0:refreshList()
end

function slot0._sortFunc(slot0, slot1)
	if (slot0.finishCount > 0 and 3 or slot0.config.maxProgress <= slot0.progress and 1 or 2) ~= (slot1.finishCount > 0 and 3 or slot1.config.maxProgress <= slot1.progress and 1 or 2) then
		return slot2 < slot3
	else
		return slot0.config.id < slot1.config.id
	end
end

function slot0.refreshList(slot0)
	if slot0:getFinishTaskCount() > 1 then
		slot2 = tabletool.copy(slot0.taskMoList)

		table.insert(slot2, 1, {
			getAll = true
		})
		slot0:setList(slot2)
	else
		slot0:setList(slot0.taskMoList)
	end
end

function slot0.getFinishTaskCount(slot0)
	for slot5, slot6 in ipairs(slot0.taskMoList) do
		if slot6.hasFinished and slot6.finishCount < slot6.config.maxProgress then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.getFinishTaskActivityCount(slot0)
	for slot5, slot6 in ipairs(slot0.taskMoList) do
		if slot6.hasFinished and slot6.finishCount < slot6.config.maxProgress then
			slot1 = 0 + slot6.config.activity
		end
	end

	return slot1
end

function slot0.getGetRewardTaskCount(slot0)
	for slot5, slot6 in ipairs(slot0.taskMoList) do
		if slot6.config.maxProgress <= slot6.finishCount then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.getKeyRewardMo(slot0)
	if slot0.taskMoList then
		for slot4, slot5 in ipairs(slot0.taskMoList) do
			if slot5.config.isKeyReward == 1 and slot5.finishCount < slot5.config.maxProgress then
				return slot5
			end
		end
	end
end

slot0.instance = slot0.New()

return slot0
