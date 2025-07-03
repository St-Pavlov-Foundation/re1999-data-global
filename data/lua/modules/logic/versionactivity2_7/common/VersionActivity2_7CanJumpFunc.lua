module("modules.logic.versionactivity2_7.common.VersionActivity2_7CanJumpFunc", package.seeall)

local var_0_0 = class("VersionActivity2_7CanJumpFunc")

function var_0_0.canJumpTo12003(arg_1_0, arg_1_1)
	local var_1_0, var_1_1, var_1_2 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_7Enum.ActivityId.EnterView)

	if var_1_0 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_1_1, var_1_2
	end

	local var_1_3 = VersionActivity2_7Enum.ActivityId.Reactivity
	local var_1_4, var_1_5, var_1_6 = ActivityHelper.getActivityStatusAndToast(var_1_3)

	if var_1_4 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_1_5, var_1_6
	end

	local var_1_7 = arg_1_1[3]

	if var_1_7 then
		local var_1_8 = DungeonConfig.instance:getEpisodeCO(var_1_7)

		if not var_1_8 then
			logError("not found episode : " .. var_1_7)

			return false, ToastEnum.EpisodeNotExist, JumpController.DefaultToastParam
		end

		local var_1_9 = ActivityConfig.instance:getActivityDungeonConfig(var_1_3)

		if var_1_9 and var_1_9.hardChapterId and var_1_8.chapterId == var_1_9.hardChapterId and not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(var_1_3) then
			return false, ToastEnum.ActivityHardDugeonLockedWithOpenTime, JumpController.DefaultToastParam
		end

		if not DungeonModel.instance:getEpisodeInfo(var_1_7) then
			return false, ToastEnum.WarmUpGotoOrder, JumpController.DefaultToastParam
		end
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

function var_0_0.canJumpTo12005(arg_2_0, arg_2_1)
	local var_2_0, var_2_1, var_2_2 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_7Enum.ActivityId.DungeonGraffiti)

	if var_2_0 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_2_1, var_2_2
	end

	if not VersionActivity2_0DungeonModel.instance:getGraffitiEntranceUnlockState() then
		return false, ToastEnum.GraffitiLock
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

function var_0_0.canJumpTo12706(arg_3_0, arg_3_1)
	local var_3_0, var_3_1, var_3_2 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_7Enum.ActivityId.EnterView)

	if var_3_0 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_3_1, var_3_2
	end

	local var_3_3 = VersionActivity2_7Enum.ActivityId.Dungeon
	local var_3_4, var_3_5, var_3_6 = ActivityHelper.getActivityStatusAndToast(var_3_3)

	if var_3_4 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_3_5, var_3_6
	end

	local var_3_7 = arg_3_1[3]

	if var_3_7 then
		local var_3_8 = DungeonConfig.instance:getEpisodeCO(var_3_7)

		if not var_3_8 then
			logError("not found episode : " .. var_3_7)

			return false, ToastEnum.EpisodeNotExist, JumpController.DefaultToastParam
		end

		local var_3_9 = ActivityConfig.instance:getActivityDungeonConfig(var_3_3)

		if var_3_9 and var_3_9.hardChapterId and var_3_8.chapterId == var_3_9.hardChapterId and not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(var_3_3) then
			return false, ToastEnum.ActivityHardDugeonLockedWithOpenTime, JumpController.DefaultToastParam
		end

		if not DungeonModel.instance:getEpisodeInfo(var_3_7) then
			return false, ToastEnum.WarmUpGotoOrder, JumpController.DefaultToastParam
		end
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

return var_0_0
