module("projbooter.config.GameUrlConfig", package.seeall)

local var_0_0 = _M

var_0_0.ServerType = {
	Develop = 1,
	OutDevelop = 2,
	OutRelease = 4,
	OutExperience = 5,
	OutPreview = 3
}

function var_0_0.getLoginUrls(arg_1_0)
	local var_1_0 = UrlConfig.getConfig()
	local var_1_1 = VersionValidator.instance:isInReviewing(true)
	local var_1_2
	local var_1_3

	if var_1_1 then
		var_1_3 = arg_1_0 and var_1_0.loginReviewBackup or var_1_0.loginReview
	else
		var_1_3 = arg_1_0 and var_1_0.loginBackup or var_1_0.login
	end

	if type(var_1_3) == "table" then
		local var_1_4 = tostring(SDKMgr.instance:getChannelId())

		var_1_2 = var_1_3[var_1_4]

		if not var_1_2 then
			for iter_1_0, iter_1_1 in pairs(var_1_3) do
				var_1_2 = iter_1_1

				logError(string.format("httpLoginUrl not exist, bak=%s, channelId=%s\nuse %s:%s", arg_1_0 and "true" or "false", var_1_4, iter_1_0, var_1_2 or "nil"))

				break
			end
		end
	else
		var_1_2 = var_1_3
	end

	local var_1_5 = var_1_2 .. "/login0.jsp"
	local var_1_6 = var_1_2 .. "/login.jsp"
	local var_1_7 = var_1_2 .. "/loadzone.jsp"
	local var_1_8 = var_1_2 .. "/startgame.jsp"

	return var_1_2, var_1_5, var_1_6, var_1_7, var_1_8
end

function var_0_0.getHotUpdateUrl()
	local var_2_0 = UrlConfig.getConfig()

	return var_2_0.hotUpdate, var_2_0.hotUpdateBackup
end

function var_0_0.getOptionalUpdateUrl()
	local var_3_0 = UrlConfig.getConfig()

	return var_3_0.optionalUpdate, var_3_0.optionalUpdateBackup
end

function var_0_0.getMassHotUpdateUrl()
	local var_4_0 = UrlConfig.getConfig()

	return var_4_0.massHotUpdate, var_4_0.massHotUpdateBackup
end

function var_0_0.getNoticeUrl()
	return UrlConfig.getConfig().notice
end

function var_0_0.getLogReportUrl()
	return UrlConfig.getConfig().logReport
end

return var_0_0
