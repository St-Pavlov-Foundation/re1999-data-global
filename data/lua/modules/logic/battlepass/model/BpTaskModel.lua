module("modules.logic.battlepass.model.BpTaskModel", package.seeall)

slot0 = class("BpTaskModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0.serverTaskModel = BaseModel.New()
	slot0.showQuickFinishTask = false
	slot0.haveTurnBackTask = false
end

function slot0.reInit(slot0)
	slot0.haveTurnBackTask = false
	slot0.showQuickFinishTask = false

	slot0.serverTaskModel:clear()
end

function slot0.onGetInfo(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		if BpConfig.instance:getTaskCO(slot7.id) then
			slot9 = TaskMo.New()

			slot9:init(slot7, slot8)
			table.insert(slot2, slot9)
		else
			logError("Bp task config not find:" .. tostring(slot7.id))
		end
	end

	slot0.serverTaskModel:setList(slot2)
	slot0:sortList()
	slot0:_checkRedDot()
end

function slot0.sortList(slot0)
	slot0.serverTaskModel:sort(function (slot0, slot1)
		if (slot0.finishCount > 0 and 3 or slot0.config.maxProgress <= slot0.progress and 1 or 2) ~= (slot1.finishCount > 0 and 3 or slot1.config.maxProgress <= slot1.progress and 1 or 2) then
			return slot2 < slot3
		else
			if slot0.config.sortId ~= slot1.config.sortId then
				return slot0.config.sortId < slot1.config.sortId
			end

			return slot0.config.id < slot1.config.id
		end
	end)
	slot0:onModelUpdate()
end

function slot0._checkRedDot(slot0)
	slot1 = BpModel.instance:isWeeklyScoreFull()
	slot2 = 0

	for slot6, slot7 in ipairs(slot0.serverTaskModel:getList()) do
		if slot7.config.bpId == BpModel.instance.id then
			if slot7.config.maxProgress <= slot7.progress and slot7.finishCount == 0 then
				if slot7.config.loopType == 5 then
					slot8 = 3
				end

				if not slot1 or slot1 and slot8 == 3 then
					slot2 = slot2 + 1
				end
			end

			if slot7.config.turnbackTask then
				slot0.haveTurnBackTask = true
			end
		end
	end

	slot0.showQuickFinishTask = slot2 >= 1
end

function slot0.getHaveRedDot(slot0, slot1)
	if slot1 == 3 then
		return RedDotModel.instance:isDotShow(RedDotEnum.DotNode.BattlePassTask, 3) or RedDotModel.instance:isDotShow(RedDotEnum.DotNode.BattlePassTask, 5)
	else
		return RedDotModel.instance:isDotShow(RedDotEnum.DotNode.BattlePassTask, slot1)
	end
end

function slot0.updateInfo(slot0, slot1)
	slot2 = nil

	for slot6, slot7 in ipairs(slot1) do
		if slot7.type == TaskEnum.TaskType.BattlePass then
			if slot0.serverTaskModel:getById(slot7.id) then
				slot8:update(slot7)
			elseif BpConfig.instance:getTaskCO(slot7.id) then
				slot8 = TaskMo.New()

				slot8:init(slot7, slot9)
				slot0.serverTaskModel:addAtLast(slot8)
			else
				logError("Bp task config not find:" .. tostring(slot7.id))
			end

			slot2 = true
		end
	end

	if slot2 then
		slot0:sortList()
		slot0:_checkRedDot()
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
		slot0:_checkRedDot()
	end

	return slot3
end

function slot0.refreshListView(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(slot0.serverTaskModel:getList()) do
		if slot8.config.loopType == 5 then
			slot9 = 3
		end

		if slot8.config.bpId == BpModel.instance.id and slot9 == slot1 then
			slot11 = true

			if BpConfig.instance.taskPreposeIds[slot8.config.id] then
				for slot15 in pairs(slot10[slot8.config.id]) do
					if slot0.serverTaskModel:getById(slot15) and slot16.finishCount == 0 then
						slot11 = false

						break
					end
				end
			end

			if slot11 then
				table.insert(slot2, slot8)
			end
		end
	end

	slot0:setList(slot2)
end

slot0.instance = slot0.New()

return slot0
