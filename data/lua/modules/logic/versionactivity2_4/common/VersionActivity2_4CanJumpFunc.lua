module("modules.logic.versionactivity2_4.common.VersionActivity2_4CanJumpFunc", package.seeall)

local var_0_0 = class("VersionActivity2_4CanJumpFunc")

function var_0_0.canJumpTo12402(arg_1_0, arg_1_1)
	local var_1_0, var_1_1, var_1_2 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_4Enum.ActivityId.EnterView)

	if var_1_0 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_1_1, var_1_2
	end

	local var_1_3 = VersionActivity2_4Enum.ActivityId.Dungeon
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

function var_0_0.canJumpTo11804(arg_2_0, arg_2_1)
	local var_2_0, var_2_1, var_2_2 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_4Enum.ActivityId.EnterView)

	if var_2_0 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_2_1, var_2_2
	end

	local var_2_3 = VersionActivity2_4Enum.ActivityId.Reactivity
	local var_2_4, var_2_5, var_2_6 = ActivityHelper.getActivityStatusAndToast(var_2_3)

	if var_2_4 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_2_5, var_2_6
	end

	local var_2_7 = arg_2_1[3]

	if var_2_7 then
		local var_2_8 = DungeonConfig.instance:getEpisodeCO(var_2_7)

		if not var_2_8 then
			logError("not found episode : " .. var_2_7)

			return false, ToastEnum.EpisodeNotExist, JumpController.DefaultToastParam
		end

		local var_2_9 = ActivityConfig.instance:getActivityDungeonConfig(var_2_3)

		if var_2_9 and var_2_9.hardChapterId and var_2_8.chapterId == var_2_9.hardChapterId and not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(var_2_3) then
			return false, ToastEnum.ActivityHardDugeonLockedWithOpenTime, JumpController.DefaultToastParam
		end

		if not DungeonModel.instance:getEpisodeInfo(var_2_7) then
			return false, ToastEnum.WarmUpGotoOrder, JumpController.DefaultToastParam
		end

		local var_2_10
		local var_2_11 = var_2_8.elementList

		if not string.nilorempty(var_2_11) then
			var_2_10 = string.splitToNumber(var_2_11, "#")
		end

		if var_2_10 then
			for iter_2_0, iter_2_1 in ipairs(var_2_10) do
				if not DungeonMapModel.instance:elementIsFinished(iter_2_1) then
					return false, ToastEnum.WarmUpGotoOrder, JumpController.DefaultToastParam
				end
			end
		end
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

function var_0_0.canJumpTo11815(arg_3_0, arg_3_1)
	local var_3_0, var_3_1, var_3_2 = ActivityHelper.getActivityStatusAndToast(VersionActivity1_8Enum.ActivityId.DungeonReturnToWork)

	if var_3_0 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_3_1, var_3_2
	end

	local var_3_3 = arg_3_1 and arg_3_1[3] == 2

	if not Activity157Model.instance:getIsUnlockEntrance() then
		return false, ToastEnum.V1a8Activity157NotUnlock
	end

	if var_3_3 and not Activity157Model.instance:getIsUnlockFactoryBlueprint() then
		return false, ToastEnum.V1a8Activity157LockedFactoryEntrance
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

return var_0_0
