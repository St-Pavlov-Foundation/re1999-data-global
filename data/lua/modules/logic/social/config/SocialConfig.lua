module("modules.logic.social.config.SocialConfig", package.seeall)

slot0 = class("SocialConfig", BaseConfig)

function slot0.ctor(slot0)
end

function slot0.reqConfigNames(slot0)
	return {
		"chat_check"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
end

function slot0.getSocialMessageFields(slot0)
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

function slot0.getMessageUnreadKey(slot0)
	return string.format("%s&userId=%s", PlayerPrefsKey.SocialMessageUnread, PlayerModel.instance:getPlayinfo().userId)
end

function slot0.getSocialMessagesKey(slot0, slot1, slot2)
	return string.format("%s&userId=%s&channelType=%s&id=%s", PlayerPrefsKey.SocialMessage, PlayerModel.instance:getPlayinfo().userId, slot1, slot2)
end

function slot0.getStatusText(slot0, slot1)
	if tonumber(slot1) == 0 then
		return luaLang("social_online")
	elseif math.floor((ServerTime.now() - slot1 / 1000) / TimeUtil.OneDaySecond) >= 1 then
		return string.format(luaLang("time_lastday"), slot3)
	else
		return string.format(luaLang("time_lasthour"), math.max(1, math.floor(slot2 / TimeUtil.OneHourSecond)))
	end
end

function slot0.getRequestTimeText(slot0, slot1)
	if tonumber(slot1) / 1000 == 0 then
		return string.format("<color=#008c00>%s</color>", luaLang("social_recent"))
	elseif ServerTime.now() - slot1 < TimeUtil.OneHourSecond then
		return string.format("<color=#008c00>%s</color>", luaLang("social_recent"))
	elseif slot3 < TimeUtil.OneDaySecond then
		return string.format(luaLang("time_lasthour"), math.max(math.floor(slot3 / TimeUtil.OneHourSecond), 1))
	else
		return string.format(luaLang("time_lastday"), math.floor(slot3 / TimeUtil.OneDaySecond))
	end
end

function slot0.getMaxFriendsCount(slot0)
	return CommonConfig.instance:getConstNum(ConstEnum.SocialMaxFriendsCount)
end

function slot0.getMaxRequestCount(slot0)
	return CommonConfig.instance:getConstNum(ConstEnum.SocialMaxRequestCount)
end

function slot0.getMaxBlackListCount(slot0)
	return CommonConfig.instance:getConstNum(ConstEnum.SocialMaxBlackListCount)
end

function slot0.isMsgViolation(slot0, slot1)
	for slot5, slot6 in ipairs(lua_chat_check.configList) do
		if string.find(slot1, slot6.value, 1, true) then
			return true
		end
	end

	return false
end

slot0.instance = slot0.New()

return slot0
