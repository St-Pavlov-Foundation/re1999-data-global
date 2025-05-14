module("modules.logic.versionactivity1_3.jialabona.helper.JiaLaBoNaHelper", package.seeall)

local var_0_0 = {
	getLimitTimeStr = function()
		local var_1_0 = ActivityModel.instance:getActMO(VersionActivity1_3Enum.ActivityId.Act306)

		if var_1_0 then
			return string.format(luaLang("activity_warmup_remain_time"), var_1_0:getRemainTimeStr2ByEndTime())
		end

		return ""
	end,
	isOpenDay = function(arg_2_0)
		local var_2_0 = VersionActivity1_3Enum.ActivityId.Act306
		local var_2_1 = ActivityModel.instance:getActMO(var_2_0)
		local var_2_2 = Activity120Config.instance:getEpisodeCo(var_2_0, arg_2_0)

		if var_2_1 and var_2_2 then
			local var_2_3 = var_2_1:getRealStartTimeStamp() + (var_2_2.openDay - 1) * 24 * 60 * 60
			local var_2_4 = ServerTime.now()
			local var_2_5 = var_2_2.preEpisode == 0 or Activity120Model.instance:isEpisodeClear(var_2_2.preEpisode)
			local var_2_6 = math.max(var_2_3 - var_2_4, 0)

			if not var_2_5 or var_2_6 > 0 then
				return false, var_2_6
			end
		else
			if not var_2_2 then
				logNormal(string.format("can not find v1a3 activity episodeCfg. actId:%s episodeId:%s", var_2_0, arg_2_0))
			end

			return false, -1
		end

		return true
	end
}

function var_0_0.isOpenChapterDay(arg_3_0)
	local var_3_0 = var_0_0.getFristEpisodeCoByChapterId(arg_3_0)

	if not var_3_0 then
		return false, -1
	end

	return var_0_0.isOpenDay(var_3_0.id)
end

function var_0_0.getFristEpisodeCoByChapterId(arg_4_0)
	local var_4_0 = VersionActivity1_3Enum.ActivityId.Act306
	local var_4_1 = Activity120Config.instance:getChapterEpisodeList(var_4_0, arg_4_0)

	return var_4_1 and var_4_1[1]
end

function var_0_0.showToastByEpsodeId(arg_5_0, arg_5_1)
	local var_5_0 = VersionActivity1_3Enum.ActivityId.Act306
	local var_5_1 = Activity120Config.instance:getEpisodeCo(var_5_0, arg_5_0)

	if not var_5_1 then
		logNormal(string.format("can not find v1a3 activity episodeCfg. actId:%s episodeId:%s", VersionActivity1_3Enum.ActivityId.Act306, arg_5_0))

		return
	end

	local var_5_2, var_5_3 = var_0_0.isOpenDay(var_5_1.id)

	if not var_5_2 then
		if var_5_1.preEpisode ~= 0 or not Activity120Model.instance:isEpisodeClear(var_5_1.preEpisode) then
			local var_5_4 = Activity120Config.instance:getEpisodeCo(var_5_1.activityId, var_5_1.preEpisode)

			GameFacade.showToast(ToastEnum.Va3Act120PreEpisodeNotOpen, var_5_4 and var_5_4.name or var_5_1.preEpisode)
		else
			GameFacade.showToast(arg_5_1 and ToastEnum.Va3Act120ChapterNotOpenTime or ToastEnum.Va3Act120EpisodeNotOpenTime)
		end
	end
end

return var_0_0
