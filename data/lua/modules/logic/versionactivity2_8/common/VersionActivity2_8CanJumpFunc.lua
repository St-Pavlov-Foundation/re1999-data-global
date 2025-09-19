module("modules.logic.versionactivity2_8.common.VersionActivity2_8CanJumpFunc", package.seeall)

local var_0_0 = class("VersionActivity2_8CanJumpFunc")

function var_0_0.canJumpTo12810(arg_1_0, arg_1_1)
	local var_1_0, var_1_1, var_1_2 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_8Enum.ActivityId.EnterView)

	if var_1_0 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_1_1, var_1_2
	end

	local var_1_3 = VersionActivity2_8Enum.ActivityId.NuoDiKa
	local var_1_4, var_1_5, var_1_6 = ActivityHelper.getActivityStatusAndToast(var_1_3)

	if var_1_4 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_1_5, var_1_6
	end

	local var_1_7 = arg_1_1[3]

	if var_1_7 then
		local var_1_8 = NuoDiKaConfig.instance:getEpisodeCo(var_1_3, var_1_7)

		if not var_1_8 then
			return false, ToastEnum.EpisodeNotExist, JumpController.DefaultToastParam
		end

		if var_1_7 ~= 0 and var_1_8.preEpisode and var_1_8.preEpisode ~= 0 and not NuoDiKaModel.instance:isEpisodePass(var_1_8.preEpisode) then
			return false, ToastEnum.Act194EpisodeLock, JumpController.DefaultToastParam
		end
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

function var_0_0.canJumpTo12811(arg_2_0, arg_2_1)
	local var_2_0, var_2_1, var_2_2 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_8Enum.ActivityId.EnterView)

	if var_2_0 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_2_1, var_2_2
	end

	local var_2_3 = VersionActivity2_8Enum.ActivityId.MoLiDeEr
	local var_2_4, var_2_5, var_2_6 = ActivityHelper.getActivityStatusAndToast(var_2_3)

	if var_2_4 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_2_5, var_2_6
	end

	local var_2_7 = arg_2_1[3]

	if var_2_7 then
		local var_2_8 = MoLiDeErConfig.instance:getEpisodeConfig(var_2_3, var_2_7)

		if not var_2_8 then
			logError("not found episode : " .. var_2_7)

			return false, ToastEnum.EpisodeNotExist, JumpController.DefaultToastParam
		end

		if var_2_7 ~= 0 and var_2_8.preEpisodeId and var_2_8.preEpisodeId ~= 0 and not MoLiDeErModel.instance:isEpisodeFinish(var_2_3, var_2_8.preEpisodeId) then
			return false, ToastEnum.Act194EpisodeLock, JumpController.DefaultToastParam
		end
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

return var_0_0
