module("modules.logic.social.config.SocialConfig", package.seeall)

local var_0_0 = class("SocialConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"chat_check"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	return
end

function var_0_0.getSocialMessageFields(arg_4_0)
	return {
		portrait = 5,
		recipientId = 9,
		senderId = 3,
		msgType = 10,
		sendTime = 7,
		channelType = 2,
		content = 6,
		extData = 11,
		senderName = 4,
		msgId = 1,
		level = 8
	}
end

function var_0_0.getMessageUnreadKey(arg_5_0)
	local var_5_0 = PlayerModel.instance:getPlayinfo()

	return (string.format("%s&userId=%s", PlayerPrefsKey.SocialMessageUnread, var_5_0.userId))
end

function var_0_0.getSocialMessagesKey(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = PlayerModel.instance:getPlayinfo()

	return (string.format("%s&userId=%s&channelType=%s&id=%s", PlayerPrefsKey.SocialMessage, var_6_0.userId, arg_6_1, arg_6_2))
end

function var_0_0.getStatusText(arg_7_0, arg_7_1)
	arg_7_1 = tonumber(arg_7_1)

	if arg_7_1 == 0 then
		return luaLang("social_online")
	else
		local var_7_0 = ServerTime.now() - arg_7_1 / 1000
		local var_7_1 = math.floor(var_7_0 / TimeUtil.OneDaySecond)

		if var_7_1 >= 1 then
			return string.format(luaLang("time_lastday"), var_7_1)
		else
			local var_7_2 = math.max(1, math.floor(var_7_0 / TimeUtil.OneHourSecond))

			return string.format(luaLang("time_lasthour"), var_7_2)
		end
	end
end

function var_0_0.getRequestTimeText(arg_8_0, arg_8_1)
	arg_8_1 = tonumber(arg_8_1)
	arg_8_1 = arg_8_1 / 1000

	if arg_8_1 == 0 then
		return string.format("<color=#008c00>%s</color>", luaLang("social_recent"))
	else
		local var_8_0 = ServerTime.now() - arg_8_1

		if var_8_0 < TimeUtil.OneHourSecond then
			return string.format("<color=#008c00>%s</color>", luaLang("social_recent"))
		elseif var_8_0 < TimeUtil.OneDaySecond then
			local var_8_1 = var_8_0 / TimeUtil.OneHourSecond

			return string.format(luaLang("time_lasthour"), math.max(math.floor(var_8_1), 1))
		else
			local var_8_2 = var_8_0 / TimeUtil.OneDaySecond

			return string.format(luaLang("time_lastday"), math.floor(var_8_2))
		end
	end
end

function var_0_0.getMaxFriendsCount(arg_9_0)
	return CommonConfig.instance:getConstNum(ConstEnum.SocialMaxFriendsCount)
end

function var_0_0.getMaxRequestCount(arg_10_0)
	return CommonConfig.instance:getConstNum(ConstEnum.SocialMaxRequestCount)
end

function var_0_0.getMaxBlackListCount(arg_11_0)
	return CommonConfig.instance:getConstNum(ConstEnum.SocialMaxBlackListCount)
end

function var_0_0.isMsgViolation(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(lua_chat_check.configList) do
		if string.find(arg_12_1, iter_12_1.value, 1, true) then
			return true
		end
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
