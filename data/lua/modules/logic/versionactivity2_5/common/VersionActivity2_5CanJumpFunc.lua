module("modules.logic.versionactivity2_5.common.VersionActivity2_5CanJumpFunc", package.seeall)

slot0 = class("VersionActivity2_5CanJumpFunc")

function slot0.canJumpTo12502(slot0, slot1)
	slot2, slot3, slot4 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_5Enum.ActivityId.EnterView)

	if slot2 ~= ActivityEnum.ActivityStatus.Normal then
		return false, slot3, slot4
	end

	slot6, slot7, slot8 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_5Enum.ActivityId.Dungeon)

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

function slot0.canJumpTo11602(slot0, slot1)
	slot2, slot3, slot4 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_5Enum.ActivityId.EnterView)

	if slot2 ~= ActivityEnum.ActivityStatus.Normal then
		return false, slot3, slot4
	end

	slot6, slot7, slot8 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_5Enum.ActivityId.Reactivity)

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

		slot13 = nil

		if not string.nilorempty(slot10.elementList) then
			slot13 = string.splitToNumber(slot14, "#")
		end

		if slot13 then
			for slot18, slot19 in ipairs(slot13) do
				if not DungeonMapModel.instance:elementIsFinished(slot19) then
					return false, ToastEnum.WarmUpGotoOrder, JumpController.DefaultToastParam
				end
			end
		end
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

function slot0.canJumpTo12505(slot0, slot1)
	slot2, slot3, slot4 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_5Enum.ActivityId.EnterView)

	if slot2 ~= ActivityEnum.ActivityStatus.Normal then
		return false, slot3, slot4
	end

	slot6, slot7, slot8 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_5Enum.ActivityId.Challenge)

	if slot6 ~= ActivityEnum.ActivityStatus.Normal then
		return false, slot7, slot8
	end

	if not Act183Config.instance:getEpisodeCo(slot1[3]) then
		return false, ToastEnum.EpisodeNotExist, JumpController.DefaultToastParam
	end

	if (Act183Model.instance:getActInfo():getGroupEpisodeMo(slot10.groupId) and slot13:getStatus()) == Act183Enum.GroupStatus.Locked then
		return false, ToastEnum.Act183GroupNotOpen, JumpController.DefaultToastParam
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

return slot0
