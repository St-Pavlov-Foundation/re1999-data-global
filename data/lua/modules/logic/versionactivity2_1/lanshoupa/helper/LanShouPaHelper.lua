module("modules.logic.versionactivity2_1.lanshoupa.helper.LanShouPaHelper", package.seeall)

return {
	getLimitTimeStr = function ()
		if not ActivityModel.instance:getActMO(VersionActivity2_1Enum.ActivityId.LanShouPa) then
			return ""
		end

		if slot0:getRealEndTimeStamp() - ServerTime.now() > 0 then
			return TimeUtil.SecondToActivityTimeFormat(slot1)
		end

		return ""
	end,
	isOpenDay = function (slot0)
		slot1 = VersionActivity2_1Enum.ActivityId.LanShouPa
		slot3 = Activity164Config.instance:getEpisodeCo(slot1, slot0)

		if ActivityModel.instance:getActMO(slot1) and slot3 then
			slot7 = math.max(slot2:getRealStartTimeStamp() + (slot3.openDay - 1) * 24 * 60 * 60 - ServerTime.now(), 0)

			if slot3.preEpisode ~= 0 and not Activity164Model.instance:isEpisodeClear(slot3.preEpisode) or slot7 > 0 then
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
		return Activity164Config.instance:getChapterEpisodeList(VersionActivity2_1Enum.ActivityId.LanShouPa, slot0) and slot2[1]
	end,
	showToastByEpsodeId = function (slot0, slot1)
		if not Activity164Config.instance:getEpisodeCo(VersionActivity2_1Enum.ActivityId.LanShouPa, slot0) then
			logNormal(string.format("can not find v1a3 activity episodeCfg. actId:%s episodeId:%s", VersionActivity2_1Enum.ActivityId.LanShouPa, slot0))

			return
		end

		slot4, slot5 = uv0.isOpenDay(slot3.id)

		if not slot4 then
			slot6 = slot3.preEpisode == 0 and Activity164Model.instance:isEpisodeClear(slot3.preEpisode) or Activity164Config.instance:getEpisodeCo(slot3.activityId, slot3.preEpisode)
		end
	end
}
