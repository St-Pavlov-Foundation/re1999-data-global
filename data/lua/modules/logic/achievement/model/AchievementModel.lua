module("modules.logic.achievement.model.AchievementModel", package.seeall)

slot0 = class("AchievementModel", BaseModel)

function slot0.onInit(slot0)
	slot0._levelMap = {}
end

function slot0.reInit(slot0)
	slot0:release()

	slot0._levelMap = {}
end

function slot0.release(slot0)
	slot0._record = nil
	slot0._achievementMap = nil
	slot0._levelMap = nil
	slot0._isInited = false
end

function slot0.initDatas(slot0, slot1)
	slot0:checkBuildAchievementMap()

	slot0._isInited = true
	slot2 = {}

	if slot1 then
		for slot6 = 1, #slot1 do
			if AchievementConfig.instance:getTask(slot1[slot6].id) then
				slot9 = AchiementTaskMO.New()

				slot9:init(slot8)
				slot9:updateByServerData(slot7)
				table.insert(slot2, slot9)
			end
		end
	end

	slot0:setList(slot2)
	slot0:updateLevelMap()
end

function slot0.updateDatas(slot0, slot1)
	slot0:checkBuildAchievementMap()

	if not slot1 then
		return
	end

	slot2 = {}

	for slot6 = 1, #slot1 do
		if slot0:getById(slot1[slot6].id) == nil then
			if AchievementConfig.instance:getTask(slot7.id) then
				slot8 = AchiementTaskMO.New()

				slot8:init(slot9)
				slot8:updateByServerData(slot7)
				slot0:addAtLast(slot8)
			end
		else
			slot8:updateByServerData(slot7)

			if slot8.hasFinished and not slot8.hasFinished then
				table.insert(slot2, slot8)
			end
		end
	end

	slot0:updateLevelMap()

	return slot2
end

function slot0.updateLevelMap(slot0)
	for slot4, slot5 in pairs(slot0._achievementMap) do
		slot6 = 0

		for slot10, slot11 in ipairs(slot5) do
			if slot0:getById(slot11.id) and slot12.hasFinished then
				slot6 = slot11.level
			end
		end

		slot0._levelMap[slot4] = slot6
	end
end

function slot0.checkBuildAchievementMap(slot0)
	slot0._achievementMap = {}

	for slot5, slot6 in ipairs(AchievementConfig.instance:getAllTasks()) do
		slot0._achievementMap[slot6.achievementId] = slot0._achievementMap[slot6.achievementId] or {}

		table.insert(slot0._achievementMap[slot6.achievementId], slot6)
	end

	for slot5, slot6 in pairs(slot0._achievementMap) do
		if not AchievementConfig.instance:getAchievement(slot5) then
			logError("achievementId in achievement_task not in config : [" .. tostring(slot5) .. "]")
		end

		table.sort(slot6, uv0.sortMapTask)
	end
end

function slot0.sortMapTask(slot0, slot1)
	return slot0.level < slot1.level
end

function slot0.getAchievementLevel(slot0, slot1)
	if slot0._levelMap then
		return slot0._levelMap[slot1] or 0
	end

	return 0
end

function slot0.getGroupLevel(slot0, slot1)
	slot2 = 0

	if AchievementConfig.instance:getAchievementsByGroupId(slot1) then
		for slot7, slot8 in pairs(slot3) do
			if slot2 < slot0:getAchievementLevel(slot8.id) then
				slot2 = slot9
			end
		end
	end

	return slot2
end

function slot0.cleanAchievementNew(slot0, slot1)
	if not slot1 then
		return false
	end

	for slot6 = 1, #slot1 do
		slot0:getById(slot1[slot6]).isNew = false
		slot2 = true
	end

	return slot2
end

function slot0.achievementHasNew(slot0, slot1)
	if slot0:getAchievementTaskCoList(slot1) then
		for slot6, slot7 in ipairs(slot2) do
			if slot0:getById(slot7.id) and slot8.isNew then
				return true
			end
		end
	end

	return false
end

function slot0.getAchievementTaskCoList(slot0, slot1)
	if slot0._achievementMap then
		return slot0._achievementMap[slot1]
	end
end

function slot0.getGroupUnlockTime(slot0, slot1)
	slot2 = nil

	if AchievementConfig.instance:getAchievementsByGroupId(slot1) then
		for slot7, slot8 in ipairs(slot3) do
			if slot0:getAchievementTaskCoList(slot8.id) then
				for slot13, slot14 in ipairs(slot9) do
					if slot0:getById(slot14.id) and slot15.hasFinished and (not slot2 or slot15.finishTime < slot2) then
						slot2 = slot15.finishTime
					end
				end
			end
		end
	end

	return slot2
end

function slot0.getAchievementUnlockTime(slot0, slot1)
	slot2 = nil

	if slot0:getAchievementTaskCoList(slot1) then
		for slot7, slot8 in ipairs(slot3) do
			if slot0:getById(slot8.id) and slot9.hasFinished and (not slot2 or slot9.finishTime < slot2) then
				slot2 = slot9.finishTime
			end
		end
	end

	return slot2
end

function slot0.achievementHasLocked(slot0, slot1)
	if slot0:getAchievementTaskCoList(slot1) then
		for slot6, slot7 in ipairs(slot2) do
			if slot0:getById(slot7.id) and slot8.hasFinished then
				return false
			end
		end
	end

	return true
end

function slot0.achievementGroupHasLocked(slot0, slot1)
	if AchievementConfig.instance:getAchievementsByGroupId(slot1) then
		for slot6, slot7 in pairs(slot2) do
			if not slot0:achievementHasLocked(slot7.id) then
				return false
			end
		end
	end

	return true
end

function slot0.isGroupFinished(slot0, slot1)
	slot3 = false

	if AchievementConfig.instance:getAchievementsByGroupId(slot1) then
		for slot7, slot8 in pairs(slot2) do
			if slot0:getAchievementTaskCoList(slot8.id) then
				slot10 = false

				for slot14, slot15 in pairs(slot9) do
					if not (slot0:getById(slot15.id) and slot16.hasFinished) then
						break
					end
				end

				slot3 = slot10

				if not slot10 then
					break
				end
			end
		end
	end

	return slot3
end

function slot0.isAchievementFinished(slot0, slot1)
	if slot0:getAchievementTaskCoList(slot1) then
		for slot6, slot7 in ipairs(slot2) do
			if not slot0:getById(slot7.id) or not slot8.hasFinished then
				return false
			end
		end

		return true
	end
end

function slot0.getGroupFinishTaskList(slot0, slot1)
	if AchievementConfig.instance:getAchievementsByGroupId(slot1) then
		slot3 = {}

		for slot7, slot8 in ipairs(slot2) do
			if AchievementConfig.instance:getTasksByAchievementId(slot8.id) then
				for slot13, slot14 in ipairs(slot9) do
					if slot0:getById(slot14.id) and slot15.hasFinished then
						table.insert(slot3, slot14)
					end
				end
			end
		end

		return slot3
	end
end

function slot0.isAchievementTaskFinished(slot0, slot1)
	return slot0:getById(slot1) and slot2.hasFinished
end

slot0.instance = slot0.New()

return slot0
