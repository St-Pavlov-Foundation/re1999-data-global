module("modules.logic.achievement.model.mo.AchievementTileMO", package.seeall)

slot0 = pureTable("AchievementTileMO")

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
	return slot0.groupId and slot0.groupId ~= 0 and AchievementEnum.AchievementType.Group or AchievementEnum.AchievementType.Single
end

function slot0.isAchievementMatch(slot0, slot1, slot2)
	slot3 = false

	if slot1 == AchievementEnum.AchievementType.Single then
		if slot0.achievementCfgs then
			for slot7, slot8 in ipairs(slot0.achievementCfgs) do
				if slot8.id == slot2 then
					slot3 = true

					break
				end
			end
		end
	else
		slot3 = slot2 == slot0.groupId
	end

	return slot3
end

return slot0
