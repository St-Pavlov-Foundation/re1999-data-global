module("modules.logic.login.work.WebLoginWork", package.seeall)

slot0 = class("WebLoginWork", BaseWork)

function slot0.onStart(slot0, slot1)
	slot3 = {}

	table.insert(slot3, string.format("slSessionId=%s", LoginModel.instance.channelSessionId))
	table.insert(slot3, string.format("clientVersion=%s", "0.0.0"))
	table.insert(slot3, string.format("sysType=%s", BootNativeUtil.isAndroid() and "1" or "0"))
	table.insert(slot3, string.format("accountId=%s", LoginModel.instance.channelUserId))
	table.insert(slot3, string.format("channelId=%s", LoginModel.instance.channelId))
	table.insert(slot3, string.format("subChannelId=%s", SDKMgr.instance:getSubChannelId()))

	slot2 = LoginController.instance:get_httpWebLoginUrl(slot0.context.useBackupUrl) .. "?" .. table.concat(slot3, "&")
	slot0._url = slot2
	slot0._httpWebLoginRequestId = SLFramework.SLWebRequest.Instance:Get(slot2, slot0._onHttpWebLoginUrlResponse, slot0)

	logNormal(slot2)
end

function slot0._onHttpWebLoginUrlResponse(slot0, slot1, slot2)
	slot0._httpWebLoginRequestId = nil
	slot3 = slot0._url

	if slot1 and slot2 and slot2 ~= "" then
		if cjson.decode(slot2) and slot4.resultCode and slot4.resultCode == 0 then
			LoginModel.instance.userName = slot4.userName
			LoginModel.instance.sessionId = slot4.sessionId

			if slot4.zoneInfo then
				slot0.context.serverMO = {
					id = slot5.id,
					name = slot5.name,
					prefix = slot5.prefix,
					state = slot5.state
				}
			else
				logNormal("没有服务器，zone不存在")
			end

			slot0.context.webLoginSuccess = true

			slot0:onDone(true)

			if string.nilorempty(LoginModel.instance.userName) or string.nilorempty(LoginModel.instance.sessionId) then
				logError(string.format("WebLoginWork response error userName:%s, sessionId:%s msg:%s url:%s", slot4.userName, slot4.sessionId, slot2, slot3))
			end
		else
			slot0.context.resultCode = slot4 and slot4.resultCode

			logNormal(string.format("http web login 出错了 resultCode = %d", slot4.resultCode or "nil"))
			slot0:onDone(false)
		end
	else
		logNormal("http web 登录失败")
		slot0:onDone(false)
	end
end

function slot0.clearWork(slot0)
	slot0._url = nil

	if slot0._httpWebLoginRequestId then
		SLFramework.SLWebRequest.Instance:Stop(slot0._httpWebLoginRequestId)

		slot0._httpWebLoginRequestId = nil
	end
end

return slot0
