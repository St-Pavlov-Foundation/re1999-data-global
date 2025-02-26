module("modules.logic.versionactivity1_4.acttask.model.VersionActivity1_4TaskListModel", package.seeall)

slot0 = class("VersionActivity1_4TaskListModel", ListScrollModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.sortTaskMoList(slot0, slot1, slot2)
	slot0.actId = slot1
	slot4 = {}
	slot5 = {}
	slot6 = {}
	slot0.allTaskFinish = true

	for slot10, slot11 in ipairs(TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityDungeon, slot1)) do
		if slot11.config.page == slot2 then
			slot12 = true

			if not string.nilorempty(slot11.config.prepose) then
				for slot17, slot18 in ipairs(string.split(slot11.config.prepose, "#")) do
					if not TaskModel.instance:isTaskFinish(slot11.type, tonumber(slot18)) then
						slot12 = false

						break
					end
				end
			end

			if slot12 then
				if slot11.config.maxFinishCount <= slot11.finishCount then
					table.insert(slot6, slot11)
				elseif slot11.hasFinished then
					table.insert(slot4, slot11)
				else
					table.insert(slot5, slot11)
				end
			end
		end

		if slot11.finishCount < slot11.config.maxFinishCount then
			slot0.allTaskFinish = false
		end
	end

	table.sort(slot4, uv0._sortFunc)
	table.sort(slot5, uv0._sortFunc)
	table.sort(slot6, uv0._sortFunc)

	slot0.taskMoList = {}

	tabletool.addValues(slot0.taskMoList, slot4)
	tabletool.addValues(slot0.taskMoList, slot5)
	tabletool.addValues(slot0.taskMoList, slot6)
	slot0:refreshList()
end

function slot0.checkTaskRedByPage(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityDungeon, slot1)) do
		if slot8.config.page == slot2 then
			slot9 = true

			if not string.nilorempty(slot8.config.prepose) then
				for slot14, slot15 in ipairs(string.split(slot8.config.prepose, "#")) do
					if not TaskModel.instance:isTaskFinish(slot8.type, tonumber(slot15)) then
						slot9 = false

						break
					end
				end
			end

			if slot9 and slot8.finishCount < slot8.config.maxFinishCount and slot8.hasFinished then
				return true
			end
		end
	end

	return false
end

function slot0._sortFunc(slot0, slot1)
	return slot0.id < slot1.id
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
	for slot5, slot6 in ipairs(slot0.taskMoList) do
		if slot6.config.maxFinishCount <= slot6.finishCount then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.getKeyRewardMo(slot0)
end

function slot0.getActId(slot0)
	return slot0.actId
end

slot0.instance = slot0.New()

return slot0
