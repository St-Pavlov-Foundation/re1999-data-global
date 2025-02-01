module("modules.logic.versionactivity1_5.peaceulu.model.PeaceUluTaskModel", package.seeall)

slot0 = class("PeaceUluTaskModel", ListScrollModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.sortTaskMoList(slot0, slot1)
	slot3 = {}
	slot4 = {}
	slot5 = {}

	for slot9, slot10 in pairs(PeaceUluModel.instance:getTasksInfo()) do
		slot10.firstOpen = slot1
		slot10.isupdate = true

		if slot10.finishCount > 0 then
			table.insert(slot5, slot10)
		elseif slot10.hasFinished then
			table.insert(slot3, slot10)
		else
			table.insert(slot4, slot10)
		end
	end

	table.sort(slot3, uv0._sortFunc)
	table.sort(slot4, uv0._sortFunc)
	table.sort(slot5, uv0._sortFunc)

	slot0.serverTaskModel = {}

	tabletool.addValues(slot0.serverTaskModel, slot3)
	tabletool.addValues(slot0.serverTaskModel, slot4)
	tabletool.addValues(slot0.serverTaskModel, slot5)
	slot0:refreshList(slot1)
end

function slot0._sortFunc(slot0, slot1)
	if (slot0.finishCount > 0 and 3 or slot0.config.maxProgress <= slot0.progress and 1 or 2) ~= (slot1.finishCount > 0 and 3 or slot1.config.maxProgress <= slot1.progress and 1 or 2) then
		return slot2 < slot3
	elseif slot0.config.sort ~= slot1.config.sort then
		return slot0.config.sort < slot1.config.sort
	else
		return slot0.config.id < slot1.config.id
	end
end

function slot0.refreshList(slot0, slot1)
	slot2 = tabletool.copy(slot0.serverTaskModel)

	table.insert(slot2, 1, {
		isGame = true,
		isupdate = true,
		firstOpen = slot1
	})
	slot0:setList(slot2)
end

function slot0.getFinishTaskCount(slot0)
	for slot5, slot6 in ipairs(slot0.serverTaskModel) do
		if slot6.hasFinished and slot6.finishCount < slot6.config.maxProgress then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.getFinishTaskActivityCount(slot0)
	for slot5, slot6 in ipairs(slot0.serverTaskModel) do
		if slot6.hasFinished and slot6.finishCount < slot6.config.maxProgress then
			slot1 = 0 + slot6.config.activity
		end
	end

	return slot1
end

function slot0.getGetRewardTaskCount(slot0)
	for slot5, slot6 in ipairs(slot0.serverTaskModel) do
		if slot6.config.maxProgress <= slot6.finishCount then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.checkAllTaskFinished(slot0)
	for slot4, slot5 in ipairs(slot0.serverTaskModel) do
		if slot5.finishCount == 0 then
			return false
		end
	end

	return true
end

function slot0.getKeyRewardMo(slot0)
	if slot0.serverTaskModel then
		for slot4, slot5 in ipairs(slot0.serverTaskModel) do
			if slot5.config.isKeyReward == 1 and slot5.finishCount < slot5.config.maxProgress then
				return slot5
			end
		end
	end
end

slot0.instance = slot0.New()

return slot0
