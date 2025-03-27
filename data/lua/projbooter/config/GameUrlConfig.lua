module("projbooter.config.GameUrlConfig", package.seeall)

slot0 = _M
slot0.ServerType = {
	Develop = 1,
	OutDevelop = 2,
	OutRelease = 4,
	OutExperience = 5,
	OutPreview = 3
}

function slot0.getLoginUrls(slot0)
	slot1 = UrlConfig.getConfig()
	slot3, slot4 = nil

	if type(VersionValidator.instance:isInReviewing(true) and (slot0 and slot1.loginReviewBackup or slot1.loginReview) or slot0 and slot1.loginBackup or slot1.login) == "table" then
		if not slot4[tostring(SDKMgr.instance:getChannelId())] then
			for slot9, slot10 in pairs(slot4) do
				logError(string.format("httpLoginUrl not exist, bak=%s, channelId=%s\nuse %s:%s", slot0 and "true" or "false", slot5, slot9, slot10 or "nil"))

				break
			end
		end
	else
		slot3 = slot4
	end

	return slot3, slot3 .. "/login0.jsp", slot3 .. "/login.jsp", slot3 .. "/loadzone.jsp", slot3 .. "/startgame.jsp"
end

function slot0.getHotUpdateUrl()
	slot0 = UrlConfig.getConfig()

	return slot0.hotUpdate, slot0.hotUpdateBackup
end

function slot0.getOptionalUpdateUrl()
	slot0 = UrlConfig.getConfig()

	return slot0.optionalUpdate, slot0.optionalUpdateBackup
end

function slot0.getMassHotUpdateUrl()
	slot0 = UrlConfig.getConfig()

	return slot0.massHotUpdate, slot0.massHotUpdateBackup
end

function slot0.getNoticeUrl()
	return UrlConfig.getConfig().notice
end

function slot0.getLogReportUrl()
	return UrlConfig.getConfig().logReport
end

return slot0
