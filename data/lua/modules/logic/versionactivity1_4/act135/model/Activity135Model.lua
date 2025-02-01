module("modules.logic.versionactivity1_4.act135.model.Activity135Model", package.seeall)

slot0 = class("Activity135Model", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.getActivityShowReward(slot0, slot1)
	if not Activity135Config.instance:getEpisodeCos(slot1) then
		return
	end

	slot3 = {}

	for slot8, slot9 in pairs(slot2) do
		if ActivityHelper.getActivityStatus(slot9.activityId, true) == ActivityEnum.ActivityStatus.Normal and DungeonConfig.instance:getBonusCO(slot9.firstBounsId) and GameUtil.splitString2(slot10.fixBonus, true) then
			for slot15, slot16 in ipairs(slot11) do
				slot16.activityId = slot9.activityId
				slot16.isLimitFirstReward = true
			end

			tabletool.addValues(slot3, slot11)
		end
	end

	return slot3, {
		[slot9.activityId] = true
	}
end

slot0.instance = slot0.New()

return slot0
