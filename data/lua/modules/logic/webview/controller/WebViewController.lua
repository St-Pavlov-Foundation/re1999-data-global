module("modules.logic.webview.controller.WebViewController", package.seeall)

slot0 = class("WebViewController")

function slot0.openWebView(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9, slot10)
	if SLFramework.FrameworkSettings.IsEditor or BootNativeUtil.isWindows() then
		if slot2 then
			slot1 = slot0:getRecordUserUrl(slot1)
		end

		UnityEngine.Application.OpenURL(slot1)

		return
	end

	if string.nilorempty(slot1) then
		logError("url 不能为空")

		return
	end

	ViewMgr.instance:openView(ViewName.WebView, {
		url = slot1,
		needRecordUser = slot2,
		callback = slot3,
		callbackObj = slot4,
		left = slot5,
		top = slot6,
		right = slot7,
		bottom = slot8,
		autoTop = slot9,
		autoBottom = slot10
	})
end

function slot0.getRecordUserUrl(slot0, slot1)
	if string.nilorempty(slot1) then
		return slot1
	end

	slot2 = {
		slot1 .. "?" .. string.format("timestamp=%s", ServerTime.now() * 1000)
	}

	table.insert(slot2, string.format("gameId=%s", SDKMgr.instance:getGameId()))
	table.insert(slot2, string.format("gameRoleId=%s", PlayerModel.instance:getMyUserId()))
	table.insert(slot2, string.format("channelUserId=%s", LoginModel.instance.channelUserId))
	table.insert(slot2, string.format("deviceModel=%s", slot0:urlEncode(UnityEngine.SystemInfo.deviceModel)))
	table.insert(slot2, string.format("deviceId=%s", SDKMgr.instance:getDeviceInfo().deviceId))
	table.insert(slot2, string.format("os=%s", slot0:urlEncode(UnityEngine.SystemInfo.operatingSystem)))
	table.insert(slot2, string.format("token=%s", SDKMgr.instance:getGameSdkToken()))
	table.insert(slot2, string.format("channelId=%s", SDKMgr.instance:getChannelId()))
	table.insert(slot2, string.format("isEmulator=%s", SDKMgr.instance:isEmulator() and 1 or 0))

	return table.concat(slot2, "&")
end

function slot0.urlEncode(slot0, slot1)
	return string.gsub(string.gsub(slot1, "([^%w%.%- ])", function (slot0)
		return string.format("%%%02X", string.byte(slot0))
	end), " ", "+")
end

function slot0.getVideoUrl(slot0, slot1, slot2)
	slot6 = {
		string.format((GameChannelConfig.getServerType() == GameChannelConfig.ServerType.OutRelease or slot3 == GameChannelConfig.ServerType.OutPreview) and "https://reverse1999.bluepoch.com/event/skinvideo/%s?" or "https://re1999-hwtest.sl916.com/event/skinvideo/%s?", slot1) .. string.format("gameId=%s", SDKMgr.instance:getGameId())
	}

	table.insert(slot6, string.format("accountId=%s", LoginModel.instance.channelUserId))
	table.insert(slot6, string.format("roleId=%s", PlayerModel.instance:getMyUserId()))
	table.insert(slot6, string.format("skinId=%s", slot2))
	table.insert(slot6, string.format("language=%s", uv0.instance:urlEncode(LangSettings.instance:getCurLangKeyByShortCut(true))))
	table.insert(slot6, string.format("deviceType=%s", TurnBackInvitationModel.instance:getCurrentDeviceType()))

	return table.concat(slot6, "&")
end

function slot0.getWebViewTopOffset(slot0, slot1, slot2, slot3)
	slot1 = slot1 or UnityEngine.Screen.width
	slot2 = slot2 or UnityEngine.Screen.height
	slot3 = slot3 or WebViewEnum.DefaultMargin.Top
	slot6 = 1920 / 1080
	slot8 = slot1 / slot6
	slot9 = 0
	slot10 = 0
	slot11 = 0.5

	return slot1 / slot2 >= slot6 - 0.01 and math.max(0, (slot2 - slot8) * slot11) + slot3 * slot2 / slot4 or slot7 <= slot6 - 0.01 and math.max(0, (slot2 - slot8) * slot11) + slot3 * slot8 / slot4 or slot3 * slot8 / slot4
end

function slot0.getWebViewBottomOffset(slot0, slot1, slot2, slot3)
	slot1 = slot1 or UnityEngine.Screen.width
	slot2 = slot2 or UnityEngine.Screen.height
	slot3 = slot3 or WebViewEnum.DefaultMargin.Bottom
	slot6 = 1920 / 1080
	slot8 = slot1 / slot6
	slot9 = 0
	slot10 = 0
	slot11 = 0.5

	return slot1 / slot2 >= slot6 - 0.01 and math.max(0, (slot2 - slot8) * slot11) + slot3 * slot2 / slot4 or slot7 <= slot6 - 0.01 and math.max(0, (slot2 - slot8) * slot11) + slot3 * slot8 / slot4 or slot3 * slot8 / slot4
end

slot0.instance = slot0.New()

return slot0
