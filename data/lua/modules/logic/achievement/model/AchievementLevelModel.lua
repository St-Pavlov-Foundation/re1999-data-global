module("modules.logic.achievement.model.AchievementLevelModel", package.seeall)

slot0 = class("AchievementLevelModel", BaseModel)

function slot0.initData(slot0, slot1, slot2)
	slot0._achievementId = slot1
	slot0._achievementIds = slot2

	slot0:initAchievement()
end

function slot0.initAchievement(slot0)
	slot0._taskList = AchievementConfig.instance:getTasksByAchievementId(slot0._achievementId)
	slot0._selectIndex = slot0:initSelectIndex()
end

function slot0.initSelectIndex(slot0)
	if slot0._taskList then
		for slot4, slot5 in ipairs(slot0._taskList) do
			if AchievementModel.instance:getById(slot5.id) and not slot6.hasFinished then
				return slot4
			end
		end

		return #slot0._taskList
	end

	return 0
end

function slot0.setSelectTask(slot0, slot1)
	if AchievementConfig.instance:getTask(slot1) then
		slot0._selectIndex = tabletool.indexOf(slot0._taskList, slot2) or 0
	end
end

function slot0.getCurrentTask(slot0)
	if slot0._selectIndex ~= 0 then
		return slot0._taskList[slot0._selectIndex]
	end
end

function slot0.getTaskByIndex(slot0, slot1)
	return slot0._taskList[slot1]
end

function slot0.scrollTask(slot0, slot1)
	if tabletool.indexOf(slot0._achievementIds, slot0._achievementId) then
		if slot1 and slot0:hasNext() then
			slot0._achievementId = slot0._achievementIds[slot2 + 1]

			slot0:initAchievement()

			return true
		elseif not slot1 and slot0:hasPrev() then
			slot0._achievementId = slot0._achievementIds[slot2 - 1]

			slot0:initAchievement()

			return true
		end
	end

	return false
end

function slot0.hasNext(slot0)
	if tabletool.indexOf(slot0._achievementIds, slot0._achievementId) then
		return slot1 < #slot0._achievementIds
	end
end

function slot0.hasPrev(slot0)
	if tabletool.indexOf(slot0._achievementIds, slot0._achievementId) then
		return slot1 > 1
	end
end

function slot0.getCurPageIndex(slot0)
	return tabletool.indexOf(slot0._achievementIds, slot0._achievementId)
end

function slot0.getTotalPageCount(slot0)
	return slot0._achievementIds and #slot0._achievementIds or 0
end

function slot0.getAchievement(slot0)
	return slot0._achievementId
end

slot0.instance = slot0.New()

return slot0
