module("modules.logic.turnback.invitation.model.TurnBackInvitationModel", package.seeall)

slot0 = class("TurnBackInvitationModel", BaseModel)
slot0.LOGIN_URL_HEAD = "https://re.bluepoch.com/event/invite/20240919/"
slot0.HELP_ID = 0

function slot0.onInit(slot0)
	slot0._dict = {}
end

function slot0.reInit(slot0)
	slot0._dict = {}
end

function slot0.setActivityInfo(slot0, slot1)
	if slot0:getInvitationInfo(slot1.activityId) == nil then
		slot0._dict[slot2] = TurnBackInvitationInfoMo.New()
	end

	slot3:init(slot1)
end

function slot0.getInvitationInfo(slot0, slot1)
	return slot0._dict[slot1]
end

function slot0.getHelpId(slot0)
	return slot0.HELP_ID
end

function slot0.getSelfBindId(slot0, slot1)
	if slot0:getInvitationInfo(slot1) == nil or slot2.inviteCode == nil then
		return nil
	end

	return slot2.inviteCode
end

function slot0.haveBind(slot0, slot1)
	if slot0:getInvitationInfo(slot1) == nil or slot2.isTurnBack == nil then
		return false
	end

	return slot2.isTurnBack
end

function slot0.setBindState(slot0, slot1, slot2)
	if slot0:haveBind(slot1) then
		logError("Have bind friend ID")

		return
	end

	slot0:getInvitationInfo(slot1).isTurnBack = slot2
end

function slot0.isActOpen(slot0, slot1)
	if ActivityModel.instance:isActOnLine(slot1) == false then
		return slot2
	end

	return ActivityModel.instance:getActStartTime(slot1) <= ServerTime.now() * 1000 and slot5 < ActivityModel.instance:getActEndTime(slot1)
end

function slot0.getLoginUrl(slot0)
	if TurnBackInvitationConfig.instance:getUrlByChannelId(slot0:getCurChannel()) == nil then
		logError(string.format("TurnBackInvitationModel getUrl Fail channelId: %s", slot1))

		return nil
	end

	if slot1 == TurnbackEnum.ChannelType.eFun then
		return slot0:getEFunLoginUrl(slot2)
	elseif slot1 == TurnbackEnum.ChannelType.KO then
		return slot0:getKOLoginUrl(slot2)
	else
		return slot0:getGlobalLoginUrl(slot2)
	end
end

function slot0.getGlobalLoginUrl(slot0, slot1)
	slot2 = {
		slot1 .. "?" .. string.format("timestamp=%s", ServerTime.now() * 1000)
	}

	table.insert(slot2, string.format("gameId=%s", SDKMgr.instance:getGameId()))
	table.insert(slot2, string.format("gameRoleId=%s", PlayerModel.instance:getMyUserId()))
	table.insert(slot2, string.format("channelUserId=%s", LoginModel.instance.channelUserId))
	table.insert(slot2, string.format("deviceModel=%s", WebViewController.instance:urlEncode(UnityEngine.SystemInfo.deviceModel)))
	table.insert(slot2, string.format("deviceId=%s", SDKMgr.instance:getDeviceInfo().deviceId))
	table.insert(slot2, string.format("os=%s", WebViewController.instance:urlEncode(UnityEngine.SystemInfo.operatingSystem)))
	table.insert(slot2, string.format("token=%s", SDKMgr.instance:getGameSdkToken()))
	table.insert(slot2, string.format("channelId=%s", SDKMgr.instance:getChannelId()))
	table.insert(slot2, string.format("isEmulator=%s", slot0:getCurrentDeviceType()))
	table.insert(slot2, string.format("language=%s", WebViewController.instance:urlEncode(LangSettings.instance:getCurLangKeyByShortCut())))

	return table.concat(slot2, "&")
end

function slot0.getEFunLoginUrl(slot0, slot1)
	slot2 = SDKMgr.instance:getUserInfoExtraParams()
	slot3 = {
		slot1 .. "&" .. string.format("userId=%s", slot2.userId)
	}

	table.insert(slot3, string.format("sign=%s", slot2.sign))
	table.insert(slot3, string.format("timestamp=%s", slot2.timestamp))
	table.insert(slot3, string.format("gameCode=twcfwl"))

	slot4 = PayModel.instance:getGameRoleInfo()

	table.insert(slot3, string.format("serverCode=%s", slot4.serverId))
	table.insert(slot3, string.format("roleId=%s", slot4.roleId))
	table.insert(slot3, string.format("serverName=%s", WebViewController.instance:urlEncode(slot4.serverName)))
	table.insert(slot3, string.format("roleName=%s", WebViewController.instance:urlEncode(slot4.roleName)))
	table.insert(slot3, string.format("language=zh-TW"))

	return table.concat(slot3, "&")
end

function slot0.getKOLoginUrl(slot0, slot1)
	return table.concat({
		slot1 .. "?" .. string.format("jwt=%s", SDKMgr.instance:getUserInfoExtraParams().ko_jwt)
	}, "&")
end

function slot0.getCurrentDeviceType(slot0)
	if SDKMgr.instance:isEmulator() then
		return WebViewEnum.DeviceType.Emulator
	elseif SLFramework.FrameworkSettings.IsEditor or BootNativeUtil.isWindows() then
		return WebViewEnum.DeviceType.PC
	else
		return WebViewEnum.DeviceType.Normal
	end
end

function slot0.getCurChannel(slot0)
	if GameChannelConfig.isEfun() then
		return TurnbackEnum.ChannelType.eFun
	elseif GameChannelConfig.isLongCheng() then
		return TurnbackEnum.ChannelType.KO
	else
		return TurnbackEnum.ChannelType.Global
	end
end

slot0.instance = slot0.New()

return slot0
