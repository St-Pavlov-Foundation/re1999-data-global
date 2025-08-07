module("modules.logic.turnback.invitation.model.TurnBackInvitationModel", package.seeall)

local var_0_0 = class("TurnBackInvitationModel", BaseModel)

var_0_0.LOGIN_URL_HEAD = "https://re.bluepoch.com/event/invite/20240919/"
var_0_0.HELP_ID = 0

function var_0_0.onInit(arg_1_0)
	arg_1_0._dict = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._dict = {}
end

function var_0_0.setActivityInfo(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.activityId
	local var_3_1 = arg_3_0:getInvitationInfo(var_3_0)

	if var_3_1 == nil then
		var_3_1 = TurnBackInvitationInfoMo.New()
		arg_3_0._dict[var_3_0] = var_3_1
	end

	var_3_1:init(arg_3_1)
end

function var_0_0.getInvitationInfo(arg_4_0, arg_4_1)
	return arg_4_0._dict[arg_4_1]
end

function var_0_0.getHelpId(arg_5_0)
	return arg_5_0.HELP_ID
end

function var_0_0.getSelfBindId(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getInvitationInfo(arg_6_1)

	if var_6_0 == nil or var_6_0.inviteCode == nil then
		return nil
	end

	return var_6_0.inviteCode
end

function var_0_0.haveBind(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getInvitationInfo(arg_7_1)

	if var_7_0 == nil or var_7_0.isTurnBack == nil then
		return false
	end

	return var_7_0.isTurnBack
end

function var_0_0.setBindState(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0:haveBind(arg_8_1) then
		logError("Have bind friend ID")

		return
	end

	arg_8_0:getInvitationInfo(arg_8_1).isTurnBack = arg_8_2
end

function var_0_0.isActOpen(arg_9_0, arg_9_1)
	local var_9_0 = ActivityModel.instance:isActOnLine(arg_9_1)

	if var_9_0 == false then
		return var_9_0
	end

	local var_9_1 = ActivityModel.instance:getActStartTime(arg_9_1)
	local var_9_2 = ActivityModel.instance:getActEndTime(arg_9_1)
	local var_9_3 = ServerTime.now() * 1000

	return var_9_1 <= var_9_3 and var_9_3 < var_9_2
end

function var_0_0.getLoginUrl(arg_10_0)
	local var_10_0 = GameChannelConfig.getServerType()
	local var_10_1 = var_10_0 == GameChannelConfig.ServerType.OutRelease or var_10_0 == GameChannelConfig.ServerType.OutPreview
	local var_10_2 = arg_10_0:getCurChannel()
	local var_10_3

	if var_10_1 then
		var_10_3 = TurnBackInvitationConfig.instance:getUrlByChannelId(var_10_2)
	else
		var_10_3 = TurnBackInvitationConfig.instance:getTestUrlByChannelId(var_10_2)
	end

	if var_10_3 == nil then
		logError(string.format("TurnBackInvitationModel getUrl Fail channelId: %s", var_10_2))

		return nil
	end

	if var_10_2 == TurnbackEnum.ChannelType.eFun then
		return arg_10_0:getEFunLoginUrl(var_10_3)
	elseif var_10_2 == TurnbackEnum.ChannelType.KO then
		return arg_10_0:getKOLoginUrl(var_10_3)
	else
		return arg_10_0:getGlobalLoginUrl(var_10_3)
	end
end

function var_0_0.getGlobalLoginUrl(arg_11_0, arg_11_1)
	local var_11_0 = {
		arg_11_1 .. "?" .. string.format("timestamp=%s", ServerTime.now() * 1000)
	}

	table.insert(var_11_0, string.format("gameId=%s", SDKMgr.instance:getGameId()))
	table.insert(var_11_0, string.format("gameRoleId=%s", PlayerModel.instance:getMyUserId()))
	table.insert(var_11_0, string.format("channelUserId=%s", LoginModel.instance.channelUserId))

	local var_11_1 = string.format("deviceModel=%s", WebViewController.instance:urlEncode(UnityEngine.SystemInfo.deviceModel))

	table.insert(var_11_0, var_11_1)
	table.insert(var_11_0, string.format("deviceId=%s", SDKMgr.instance:getDeviceInfo().deviceId))

	local var_11_2 = string.format("os=%s", WebViewController.instance:urlEncode(UnityEngine.SystemInfo.operatingSystem))

	table.insert(var_11_0, var_11_2)
	table.insert(var_11_0, string.format("token=%s", SDKMgr.instance:getGameSdkToken()))
	table.insert(var_11_0, string.format("channelId=%s", SDKMgr.instance:getChannelId()))
	table.insert(var_11_0, string.format("isEmulator=%s", arg_11_0:getCurrentDeviceType()))

	local var_11_3 = WebViewController.instance:urlEncode(LangSettings.instance:getCurLangKeyByShortCut())

	table.insert(var_11_0, string.format("language=%s", var_11_3))

	return table.concat(var_11_0, "&")
end

function var_0_0.getEFunLoginUrl(arg_12_0, arg_12_1)
	local var_12_0 = SDKMgr.instance:getUserInfoExtraParams()
	local var_12_1 = {
		arg_12_1 .. "&" .. string.format("userId=%s", var_12_0.userId)
	}

	table.insert(var_12_1, string.format("sign=%s", var_12_0.sign))
	table.insert(var_12_1, string.format("timestamp=%s", var_12_0.timestamp))
	table.insert(var_12_1, string.format("gameCode=twcfwl"))

	local var_12_2 = PayModel.instance:getGameRoleInfo()

	table.insert(var_12_1, string.format("serverCode=%s", var_12_2.serverId))
	table.insert(var_12_1, string.format("roleId=%s", var_12_2.roleId))

	local var_12_3 = string.format("serverName=%s", WebViewController.instance:urlEncode(var_12_2.serverName))

	table.insert(var_12_1, var_12_3)

	local var_12_4 = string.format("roleName=%s", WebViewController.instance:urlEncode(var_12_2.roleName))

	table.insert(var_12_1, var_12_4)
	table.insert(var_12_1, string.format("language=zh-TW"))

	return table.concat(var_12_1, "&")
end

function var_0_0.getKOLoginUrl(arg_13_0, arg_13_1)
	local var_13_0 = SDKMgr.instance:getUserInfoExtraParams()
	local var_13_1 = {
		arg_13_1 .. "?" .. string.format("jwt=%s", var_13_0.ko_jwt)
	}

	return table.concat(var_13_1, "&")
end

function var_0_0.getCurrentDeviceType(arg_14_0)
	if SDKMgr.instance:isEmulator() then
		return WebViewEnum.DeviceType.Emulator
	elseif SLFramework.FrameworkSettings.IsEditor or BootNativeUtil.isWindows() then
		return WebViewEnum.DeviceType.PC
	else
		return WebViewEnum.DeviceType.Normal
	end
end

function var_0_0.getCurChannel(arg_15_0)
	if GameChannelConfig.isEfun() then
		return TurnbackEnum.ChannelType.eFun
	elseif GameChannelConfig.isLongCheng() then
		return TurnbackEnum.ChannelType.KO
	else
		return TurnbackEnum.ChannelType.Global
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
