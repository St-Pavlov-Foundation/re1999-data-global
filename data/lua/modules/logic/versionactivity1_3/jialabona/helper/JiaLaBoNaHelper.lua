module("modules.logic.versionactivity1_3.jialabona.helper.JiaLaBoNaHelper", package.seeall)

return {
	getLimitTimeStr = function ()
		if ActivityModel.instance:getActMO(VersionActivity1_3Enum.ActivityId.Act306) then
			return string.format(luaLang("activity_warmup_remain_time"), slot0:getRemainTimeStr2ByEndTime())
		end

		return ""
	end,
	isOpenDay = function (slot0)
		slot1 = VersionActivity1_3Enum.ActivityId.Act306
		slot3 = Activity120Config.instance:getEpisodeCo(slot1, slot0)

		if ActivityModel.instance:getActMO(slot1) and slot3 then
			slot7 = math.max(slot2:getRealStartTimeStamp() + (slot3.openDay - 1) * 24 * 60 * 60 - ServerTime.now(), 0)

			if slot3.preEpisode ~= 0 and not Activity120Model.instance:isEpisodeClear(slot3.preEpisode) or slot7 > 0 then
				return false, slot7
			end
		else
			if not slot3 then
				logNormal(string.format("can not find v1a3 activity episodeCfg. actId:%s episodeId:%s", slot1, slot0))
			end

			return false, -1
		end

		return true
	end,
	isOpenChapterDay = function (slot0)
		if not uv0.getFristEpisodeCoByChapterId(slot0) then
			return false, -1
		end

		return uv0.isOpenDay(slot1.id)
	end,
	getFristEpisodeCoByChapterId = function (slot0)
		return Activity120Config.instance:getChapterEpisodeList(VersionActivity1_3Enum.ActivityId.Act306, slot0) and slot2[1]
	end,
	showToastByEpsodeId = function (slot0, slot1)
		if not Activity120Config.instance:getEpisodeCo(VersionActivity1_3Enum.ActivityId.Act306, slot0) then
			logNormal(string.format("can not find v1a3 activity episodeCfg. actId:%s episodeId:%s", VersionActivity1_3Enum.ActivityId.Act306, slot0))

			return
		end

		slot4, slot5 = uv0.isOpenDay(slot3.id)

		if not slot4 then
			if slot3.preEpisode ~= 0 or not Activity120Model.instance:isEpisodeClear(slot3.preEpisode) then
				GameFacade.showToast(ToastEnum.Va3Act120PreEpisodeNotOpen, Activity120Config.instance:getEpisodeCo(slot3.activityId, slot3.preEpisode) and slot6.name or slot3.preEpisode)
			else
				GameFacade.showToast(slot1 and ToastEnum.Va3Act120ChapterNotOpenTime or ToastEnum.Va3Act120EpisodeNotOpenTime)
			end
		end
	end
}
