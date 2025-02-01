module("modules.logic.versionactivity2_2.eliminate.model.EliminateTaskListModel", package.seeall)

slot0 = class("EliminateTaskListModel", ListScrollModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
	slot0._allTaskMoList = {}
end

function slot0.initTask(slot0)
	slot1 = EliminateOutsideModel.instance:getTotalStar()
	slot0._allTaskMoList = {}

	for slot5, slot6 in ipairs(lua_eliminate_reward.configList) do
		if not slot0._allTaskMoList[slot5] then
			slot7 = TaskMo.New()
			slot7.id = slot6.id
			slot7.progress = slot1
			slot7.config = {
				maxFinishCount = 1,
				id = slot6.id,
				desc = slot6.desc,
				bonus = slot6.bonus,
				maxProgress = slot6.star
			}
			slot0._allTaskMoList[slot5] = slot7
		end

		slot7.hasFinished = slot6.star <= slot1
		slot7.finishCount = EliminateOutsideModel.instance:gainedTask(slot6.id) and 1 or 0
	end
end

function slot0.sortTaskMoList(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}

	for slot7, slot8 in ipairs(slot0._allTaskMoList) do
		if slot8.config.maxFinishCount <= slot8.finishCount then
			table.insert(slot3, slot8)
		elseif slot8.hasFinished then
			table.insert(slot1, slot8)
		else
			table.insert(slot2, slot8)
		end
	end

	table.sort(slot1, uv0._sortFunc)
	table.sort(slot2, uv0._sortFunc)
	table.sort(slot3, uv0._sortFunc)

	slot0.taskMoList = {}

	tabletool.addValues(slot0.taskMoList, slot1)
	tabletool.addValues(slot0.taskMoList, slot2)
	tabletool.addValues(slot0.taskMoList, slot3)
end

function slot0._sortFunc(slot0, slot1)
	return slot0.id < slot1.id
end

function slot0.refreshList(slot0)
	if slot0:getFinishTaskCount() > 1 then
		slot2 = tabletool.copy(slot0.taskMoList)

		table.insert(slot2, 1, {
			id = 0,
			getAll = true
		})
		slot0:setList(slot2)
	else
		slot0:setList(slot0.taskMoList)
	end
end

function slot0.getFinishTaskCount(slot0)
	for slot5, slot6 in ipairs(slot0.taskMoList) do
		if slot6.hasFinished and slot6.finishCount < slot6.config.maxFinishCount then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.getFinishTaskActivityCount(slot0)
	for slot5, slot6 in ipairs(slot0.taskMoList) do
		if slot6.hasFinished and slot6.finishCount < slot6.config.maxFinishCount then
			slot1 = 0 + slot6.config.activity
		end
	end

	return slot1
end

function slot0.getGetRewardTaskCount(slot0)
	slot1 = 0

	if not slot0.taskMoList then
		return 0
	end

	for slot5, slot6 in ipairs(slot0.taskMoList) do
		if slot6.config.maxFinishCount <= slot6.finishCount then
			slot1 = slot1 + 1
		end
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0
