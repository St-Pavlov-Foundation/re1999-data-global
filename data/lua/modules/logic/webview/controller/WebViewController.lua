local var_0_0 = string.format
local var_0_1 = table.insert
local var_0_2 = table.concat

module("modules.logic.webview.controller.WebViewController", package.seeall)

local var_0_3 = class("WebViewController")

function var_0_3.openWebView(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7, arg_1_8, arg_1_9, arg_1_10)
	if SLFramework.FrameworkSettings.IsEditor or BootNativeUtil.isWindows() then
		if arg_1_2 then
			arg_1_1 = arg_1_0:getRecordUserUrl(arg_1_1)
		end

		GameUtil.openURL(arg_1_1)

		return
	end

	if string.nilorempty(arg_1_1) then
		logError("url 不能为空")

		return
	end

	ViewMgr.instance:openView(ViewName.WebView, {
		url = arg_1_1,
		needRecordUser = arg_1_2,
		callback = arg_1_3,
		callbackObj = arg_1_4,
		left = arg_1_5,
		top = arg_1_6,
		right = arg_1_7,
		bottom = arg_1_8,
		autoTop = arg_1_9,
		autoBottom = arg_1_10
	})
end

function var_0_3.getRecordUserUrl(arg_2_0, arg_2_1)
	if string.nilorempty(arg_2_1) then
		return arg_2_1
	end

	local var_2_0 = {}
	local var_2_1 = GameChannelConfig.isEfun()
	local var_2_2 = GameChannelConfig.isLongCheng()

	if SLFramework.FrameworkSettings.IsEditor and isDebugBuild then
		var_2_1 = var_2_1 or SettingsModel.instance:isTwRegion()
		var_2_2 = var_2_2 or SettingsModel.instance:isKrRegion()
	end

	if var_2_1 then
		local var_2_3 = SDKMgr.instance:getUserInfoExtraParams()
		local var_2_4 = PayModel.instance:getGameRoleInfo()

		var_0_1(var_2_0, arg_2_1)
		var_0_1(var_2_0, var_0_0("userId=%s", var_2_3.userId))
		var_0_1(var_2_0, var_0_0("sign=%s", var_2_3.sign))
		var_0_1(var_2_0, var_0_0("timestamp=%s", var_2_3.timestamp))
		var_0_1(var_2_0, "gameCode=twcfwl")
		var_0_1(var_2_0, var_0_0("serverCode=%s", var_2_4.serverId))
		var_0_1(var_2_0, var_0_0("roleId=%s", var_2_4.roleId))
		var_0_1(var_2_0, var_0_0("serverName=%s", arg_2_0:urlEncode(var_2_4.serverName)))
		var_0_1(var_2_0, var_0_0("roleName=%s", arg_2_0:urlEncode(var_2_4.roleName)))
		var_0_1(var_2_0, "language=zh-TW")
	elseif var_2_2 then
		local var_2_5 = SDKMgr.instance:getUserInfoExtraParams()
		local var_2_6 = var_2_5 and var_2_5.ko_jwt or "nil"

		var_0_1(var_2_0, arg_2_1 .. "?" .. var_0_0("jwt=%s", var_2_6))
	else
		var_0_1(var_2_0, arg_2_1 .. "?" .. var_0_0("timestamp=%s", ServerTime.now() * 1000))
		var_0_1(var_2_0, var_0_0("gameId=%s", SDKMgr.instance:getGameId()))
		var_0_1(var_2_0, var_0_0("gameRoleId=%s", PlayerModel.instance:getMyUserId()))
		var_0_1(var_2_0, var_0_0("channelUserId=%s", LoginModel.instance.channelUserId))
		var_0_1(var_2_0, var_0_0("deviceModel=%s", arg_2_0:urlEncode(UnityEngine.SystemInfo.deviceModel)))
		var_0_1(var_2_0, var_0_0("deviceId=%s", SDKMgr.instance:getDeviceInfo().deviceId))
		var_0_1(var_2_0, var_0_0("os=%s", arg_2_0:urlEncode(UnityEngine.SystemInfo.operatingSystem)))
		var_0_1(var_2_0, var_0_0("token=%s", SDKMgr.instance:getGameSdkToken()))
		var_0_1(var_2_0, var_0_0("channelId=%s", SDKMgr.instance:getChannelId()))
		var_0_1(var_2_0, var_0_0("isEmulator=%s", SDKMgr.instance:isEmulator() and 1 or 0))
	end

	local var_2_7 = var_0_2(var_2_0, "&")

	logNormal(var_2_7)

	return var_2_7
end

function var_0_3.urlEncode(arg_3_0, arg_3_1)
	arg_3_1 = string.gsub(arg_3_1, "([^%w%.%- ])", function(arg_4_0)
		return string.format("%%%02X", string.byte(arg_4_0))
	end)

	return (string.gsub(arg_3_1, " ", "+"))
end

function var_0_3.getVideoUrl(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:getVideoUrlHead()
	local var_5_1 = string.format(var_5_0, arg_5_1)
	local var_5_2 = {
		var_5_1 .. string.format("gameId=%s", SDKMgr.instance:getGameId())
	}

	table.insert(var_5_2, string.format("accountId=%s", LoginModel.instance.channelUserId))
	table.insert(var_5_2, string.format("roleId=%s", PlayerModel.instance:getMyUserId()))
	table.insert(var_5_2, string.format("skinId=%s", arg_5_2))

	local var_5_3 = var_0_3.instance:urlEncode(LangSettings.instance:getCurLangKeyByShortCut(true))

	table.insert(var_5_2, string.format("language=%s", var_5_3))

	local var_5_4 = TurnBackInvitationModel.instance:getCurrentDeviceType()

	table.insert(var_5_2, string.format("deviceType=%s", var_5_4))

	return (table.concat(var_5_2, "&"))
end

function var_0_3.getVideoUrlHead(arg_6_0)
	local var_6_0 = SDKMgr.instance:getGameId()
	local var_6_1
	local var_6_2 = GameChannelConfig.getServerType()
	local var_6_3 = var_6_2 == GameChannelConfig.ServerType.OutRelease or var_6_2 == GameChannelConfig.ServerType.OutPreview

	if tostring(var_6_0) == "50001" then
		var_6_1 = var_6_3 and "https://re.bluepoch.com/event/skinvideo/%s?" or "https://re-test.sl916.com/event/skinvideo/%s?"
	else
		var_6_1 = var_6_3 and "https://reverse1999.bluepoch.com/event/skinvideo/%s?" or "https://re1999-hwtest.sl916.com/event/skinvideo/%s?"
	end

	return var_6_1
end

function var_0_3.getWebViewTopOffset(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_1 = arg_7_1 or UnityEngine.Screen.width
	arg_7_2 = arg_7_2 or UnityEngine.Screen.height
	arg_7_3 = arg_7_3 or WebViewEnum.DefaultMargin.Top

	local var_7_0 = 1080
	local var_7_1 = 1920 / var_7_0
	local var_7_2 = arg_7_1 / arg_7_2
	local var_7_3 = arg_7_1 / var_7_1
	local var_7_4 = 0
	local var_7_5 = 0
	local var_7_6 = 0.5

	if var_7_2 >= var_7_1 - 0.01 then
		local var_7_7 = arg_7_3 * (arg_7_2 / var_7_0)

		var_7_5 = math.max(0, (arg_7_2 - var_7_3) * var_7_6) + var_7_7
	elseif var_7_2 <= var_7_1 - 0.01 then
		local var_7_8 = arg_7_3 * (var_7_3 / var_7_0)

		var_7_5 = math.max(0, (arg_7_2 - var_7_3) * var_7_6) + var_7_8
	else
		var_7_5 = arg_7_3 * (var_7_3 / var_7_0)
	end

	return var_7_5
end

function var_0_3.getWebViewBottomOffset(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_1 = arg_8_1 or UnityEngine.Screen.width
	arg_8_2 = arg_8_2 or UnityEngine.Screen.height
	arg_8_3 = arg_8_3 or WebViewEnum.DefaultMargin.Bottom

	local var_8_0 = 1080
	local var_8_1 = 1920 / var_8_0
	local var_8_2 = arg_8_1 / arg_8_2
	local var_8_3 = arg_8_1 / var_8_1
	local var_8_4 = 0
	local var_8_5 = 0
	local var_8_6 = 0.5

	if var_8_2 >= var_8_1 - 0.01 then
		local var_8_7 = arg_8_3 * (arg_8_2 / var_8_0)

		var_8_5 = math.max(0, (arg_8_2 - var_8_3) * var_8_6) + var_8_7
	elseif var_8_2 <= var_8_1 - 0.01 then
		local var_8_8 = arg_8_3 * (var_8_3 / var_8_0)

		var_8_5 = math.max(0, (arg_8_2 - var_8_3) * var_8_6) + var_8_8
	else
		var_8_5 = arg_8_3 * (var_8_3 / var_8_0)
	end

	return var_8_5
end

function var_0_3.urlParse(arg_9_0)
	local var_9_0 = string.split(arg_9_0, "?")

	if var_9_0 and var_9_0[2] then
		local var_9_1 = {}

		for iter_9_0, iter_9_1 in string.gmatch(var_9_0[2], "([^&=]+)=([^&=]*)") do
			var_9_1[iter_9_0] = iter_9_1
		end

		return var_9_1
	end

	return nil
end

function var_0_3.simpleOpenWebView(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_0:getRecordUserUrl(arg_10_1)

	arg_10_0:openWebView(var_10_0, false, arg_10_2, arg_10_3)
end

function var_0_3.simpleOpenWebBrowser(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getRecordUserUrl(arg_11_1)

	GameUtil.openURL(var_11_0)
end

var_0_3.instance = var_0_3.New()

return var_0_3
