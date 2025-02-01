module("modules.logic.achievement.model.mo.AchievementSelectListMO", package.seeall)

slot0 = pureTable("AchievementSelectListMO")

function slot0.init(slot0, slot1, slot2)
	slot0.achievementCfgs = slot1
	slot0.groupId = slot2
end

function slot0.getLineHeight(slot0)
	if slot0.groupId == 0 then
		return 313
	else
		return 460
	end
end

function slot0.getAchievementType(slot0)
	return slot0.groupId and slot0.groupId ~= 0 and AchievementEnum.AchievementType.Single or AchievementEnum.AchievementType.Group
end

return slot0
