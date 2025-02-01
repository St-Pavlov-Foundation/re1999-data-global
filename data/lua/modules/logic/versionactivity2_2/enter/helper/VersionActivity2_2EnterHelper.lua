module("modules.logic.versionactivity2_2.enter.helper.VersionActivity2_2EnterHelper", package.seeall)

slot0 = class("VersionActivity2_2EnterHelper")

function slot0.GetIsShowReplayBtn(slot0)
	slot1 = false

	if slot0 then
		slot1 = ActivityConfig.instance:getActivityTabButtonState(slot0)
	end

	return slot1
end

function slot0.GetIsShowTabRemainTime(slot0)
	if not slot0 then
		return false
	end

	slot1, slot2, slot3 = ActivityConfig.instance:getActivityTabButtonState(slot0)

	return slot3
end

function slot0.GetIsShowAchievementBtn(slot0)
	if not slot0 then
		return false
	end

	slot1, slot2 = ActivityConfig.instance:getActivityTabButtonState(slot0)

	return slot2
end

function slot0.getItemTypeIdQuantity(slot0)
	if not slot0 then
		return
	end

	slot1 = string.splitToNumber(slot0, "#")

	return slot1[1], slot1[2], slot1[3]
end

function slot0.GetActivityPrefsKeyWithUser(slot0)
	return PlayerModel.instance:getPlayerPrefsKey(uv0.GetActivityPrefsKey(slot0))
end

function slot0.GetActivityPrefsKey(slot0)
	return VersionActivity2_2Enum.ActivityId.EnterView .. slot0
end

return slot0
