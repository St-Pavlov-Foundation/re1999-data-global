module("modules.logic.achievement.model.AchievementEntryModel", package.seeall)

slot0 = class("AchievementEntryModel", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.initData(slot0)
	slot0.infoDict = AchievementConfig.instance:getCategoryAchievementMap()

	slot0:initCategory()
end

function slot0.initCategory(slot0)
	slot0._category2TotalDict = {}
	slot0._category2FinishedDict = {}
	slot0._totalAchievementGotCount = 0
	slot0._level2AchievementDict = {}

	for slot5, slot6 in ipairs(AchievementConfig.instance:getOnlineAchievements()) do
		slot8 = slot6.category

		if AchievementModel.instance:getAchievementLevel(slot6.id) > 0 then
			if slot0._category2FinishedDict[slot8] == nil then
				slot0._category2FinishedDict[slot8] = 1
			else
				slot0._category2FinishedDict[slot8] = slot0._category2FinishedDict[slot8] + 1
			end

			slot0._totalAchievementGotCount = slot0._totalAchievementGotCount + 1
		end

		slot0._level2AchievementDict[slot7] = slot0._level2AchievementDict[slot7] or 0
		slot0._level2AchievementDict[slot7] = slot0._level2AchievementDict[slot7] + 1

		if slot0._category2TotalDict[slot8] == nil then
			slot0._category2TotalDict[slot8] = 1
		else
			slot0._category2TotalDict[slot8] = slot0._category2TotalDict[slot8] + 1
		end
	end
end

function slot0.getFinishCount(slot0, slot1)
	return slot0._category2FinishedDict[slot1] or 0, slot0._category2TotalDict[slot1] or 0
end

function slot0.getLevelCount(slot0, slot1)
	if slot0._level2AchievementDict then
		return slot0._level2AchievementDict[slot1] or 0
	end
end

function slot0.getTotalFinishedCount(slot0)
	return slot0._totalAchievementGotCount or 0
end

function slot0.categoryHasNew(slot0, slot1)
	if slot0.infoDict[slot1] then
		for slot6, slot7 in ipairs(slot2) do
			if AchievementModel.instance:achievementHasNew(slot7.id) then
				return true
			end
		end
	end
end

slot0.instance = slot0.New()

return slot0
