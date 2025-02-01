module("modules.logic.versionactivity1_8.common.VersionActivity1_8CanJumpFunc", package.seeall)

slot0 = class("VersionActivity1_8CanJumpFunc")

function slot0.canJumpTo11804(slot0, slot1)
	slot2, slot3, slot4 = ActivityHelper.getActivityStatusAndToast(VersionActivity1_8Enum.ActivityId.EnterView)

	if slot2 ~= ActivityEnum.ActivityStatus.Normal then
		return false, slot3, slot4
	end

	slot6, slot7, slot8 = ActivityHelper.getActivityStatusAndToast(VersionActivity1_8Enum.ActivityId.Dungeon)

	if slot6 ~= ActivityEnum.ActivityStatus.Normal then
		return false, slot7, slot8
	end

	if slot1[3] then
		if not DungeonConfig.instance:getEpisodeCO(slot9) then
			logError("not found episode : " .. slot9)

			return false, ToastEnum.EpisodeNotExist, JumpController.DefaultToastParam
		end

		if ActivityConfig.instance:getActivityDungeonConfig(slot5) and slot11.hardChapterId and slot10.chapterId == slot11.hardChapterId and not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(slot5) then
			return false, ToastEnum.ActivityHardDugeonLockedWithOpenTime, JumpController.DefaultToastParam
		end

		if not DungeonModel.instance:getEpisodeInfo(slot9) then
			return false, ToastEnum.WarmUpGotoOrder, JumpController.DefaultToastParam
		end
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

function slot0.canJumpTo11815(slot0, slot1)
	slot2, slot3, slot4 = ActivityHelper.getActivityStatusAndToast(VersionActivity1_8Enum.ActivityId.DungeonReturnToWork)

	if slot2 ~= ActivityEnum.ActivityStatus.Normal then
		return false, slot3, slot4
	end

	slot5 = slot1 and slot1[3] == 2

	if not Activity157Model.instance:getIsUnlockEntrance() then
		return false, ToastEnum.V1a8Activity157NotUnlock
	end

	if slot5 and not Activity157Model.instance:getIsUnlockFactoryBlueprint() then
		return false, ToastEnum.V1a8Activity157LockedFactoryEntrance
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

return slot0
