module("modules.logic.versionactivity2_3.common.VersionActivity2_3CanJumpFunc", package.seeall)

local var_0_0 = class("VersionActivity2_3CanJumpFunc")

function var_0_0.canJumpTo12302(arg_1_0, arg_1_1)
	local var_1_0, var_1_1, var_1_2 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_3Enum.ActivityId.EnterView)

	if var_1_0 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_1_1, var_1_2
	end

	local var_1_3 = VersionActivity2_3Enum.ActivityId.Dungeon
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

return var_0_0
