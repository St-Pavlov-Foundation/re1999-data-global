module("modules.logic.achievement.model.PlayerViewAchievementModel", package.seeall)

slot0 = class("PlayerViewAchievementModel", BaseModel)

function slot0.decodeShowAchievement(slot0, slot1)
	slot2, slot3 = AchievementUtils.decodeShowStr(slot1)

	for slot8, slot9 in pairs(slot2) do
		if AchievementConfig.instance:getTask(slot9) then
			table.insert({}, slot10.id)
		end
	end

	slot5 = {}

	for slot9, slot10 in pairs(slot3) do
		if AchievementConfig.instance:getTask(slot10) and AchievementConfig.instance:getAchievement(slot11.achievementId).groupId ~= 0 then
			slot5[slot12.groupId] = slot5[slot12.groupId] or {}

			table.insert(slot5[slot12.groupId], slot11.id)
		end
	end

	return slot4, slot5
end

function slot0.getShowAchievements(slot0, slot1)
	slot2, slot3 = slot0:decodeShowAchievement(slot1)
	slot4 = slot3 and tabletool.len(slot3) > 0

	return slot4, slot4 and slot3 or slot2
end

slot0.instance = slot0.New()

return slot0
