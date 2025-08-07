module("modules.logic.sp01.enter.controller.VersionActivity2_9CanJumpFunc", package.seeall)

local var_0_0 = class("VersionActivity2_9CanJumpFunc")

function var_0_0.canJumpTo12102(arg_1_0, arg_1_1)
	local var_1_0 = VersionActivity3_0Enum.ActivityId.Reactivity
	local var_1_1, var_1_2, var_1_3 = ActivityHelper.getActivityStatusAndToast(var_1_0)

	if var_1_1 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_1_2, var_1_3
	end

	local var_1_4 = arg_1_1[3]

	if var_1_4 then
		local var_1_5 = DungeonConfig.instance:getEpisodeCO(var_1_4)

		if not var_1_5 then
			logError("not found episode : " .. var_1_4)

			return false, ToastEnum.EpisodeNotExist, JumpController.DefaultToastParam
		end

		local var_1_6 = ActivityConfig.instance:getActivityDungeonConfig(var_1_0)

		if var_1_6 and var_1_6.hardChapterId and var_1_5.chapterId == var_1_6.hardChapterId and not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(var_1_0) then
			return false, ToastEnum.ActivityHardDugeonLockedWithOpenTime, JumpController.DefaultToastParam
		end

		if not DungeonModel.instance:getEpisodeInfo(var_1_4) then
			return false, ToastEnum.WarmUpGotoOrder, JumpController.DefaultToastParam
		end
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

function var_0_0.canJumpTo12104(arg_2_0, arg_2_1)
	local var_2_0, var_2_1, var_2_2 = ActivityHelper.getActivityStatusAndToast(VersionActivity3_0Enum.ActivityId.StoryDeduction)

	if var_2_0 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_2_1, var_2_2
	end

	if not Activity165Model.instance:hasUnlockStory() then
		return false, ToastEnum.Act165StoryLock, JumpController.DefaultToastParam
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

function var_0_0.canJumpTo130502(arg_3_0, arg_3_1)
	local var_3_0, var_3_1, var_3_2 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_9Enum.ActivityId.EnterView)

	if var_3_0 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_3_1, var_3_2
	end

	local var_3_3 = VersionActivity2_9Enum.ActivityId.Dungeon
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

function var_0_0.canJumpTo130507(arg_4_0, arg_4_1)
	local var_4_0, var_4_1, var_4_2 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_9Enum.ActivityId.EnterView)

	if var_4_0 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_4_1, var_4_2
	end

	local var_4_3 = VersionActivity2_9Enum.ActivityId.Dungeon2
	local var_4_4, var_4_5, var_4_6 = ActivityHelper.getActivityStatusAndToast(var_4_3)

	if var_4_4 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_4_5, var_4_6
	end

	local var_4_7 = arg_4_1[3]

	if var_4_7 then
		local var_4_8 = DungeonConfig.instance:getEpisodeCO(var_4_7)

		if not var_4_8 then
			logError("not found episode : " .. var_4_7)

			return false, ToastEnum.EpisodeNotExist, JumpController.DefaultToastParam
		end

		local var_4_9 = ActivityConfig.instance:getActivityDungeonConfig(var_4_3)

		if var_4_9 and var_4_9.hardChapterId and var_4_8.chapterId == var_4_9.hardChapterId and not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(var_4_3) then
			return false, ToastEnum.ActivityHardDugeonLockedWithOpenTime, JumpController.DefaultToastParam
		end

		if not DungeonModel.instance:getEpisodeInfo(var_4_7) then
			return false, ToastEnum.WarmUpGotoOrder, JumpController.DefaultToastParam
		end
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

return var_0_0
