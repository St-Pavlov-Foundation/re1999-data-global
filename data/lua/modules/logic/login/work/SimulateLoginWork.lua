module("modules.logic.login.work.SimulateLoginWork", package.seeall)

slot0 = class("SimulateLoginWork", BaseWork)

function slot0.onStart(slot0, slot1)
	slot3 = {}

	table.insert(slot3, string.format("account=%s", LoginModel.instance.channelUserId))
	table.insert(slot3, string.format("platformId=%s", "0"))

	slot0._getSimulatedSessionRequestId = SLFramework.SLWebRequest.Instance:Get(LoginController.instance:get_getSessionIdUrl(slot0.context.useBackupUrl) .. "?" .. table.concat(slot3, "&"), slot0._onGetSimulatedSessionIdResponse, slot0)
end

function slot0._onGetSimulatedSessionIdResponse(slot0, slot1, slot2)
	slot0._getSimulatedSessionRequestId = nil

	logNormal("get simulated session id response: " .. (slot2 or "nil"))

	if slot1 and slot2 and slot2 ~= "" then
		if cjson.decode(slot2) and slot3.resultCode and slot3.resultCode == 0 then
			LoginModel.instance.channelSessionId = slot3.slSessionId

			logNormal(string.format("模拟登录的sessoinId拿到了 platformId = %d sessionId = %s", slot3.platformId, slot3.slSessionId))
			slot0:onDone(true)
		else
			logNormal(string.format("出错了 resultCode = %d", slot3.resultCode or "nil"))
			slot0:onDone(false)
		end
	else
		logError("获取session失败")
		slot0:onDone(false)
	end
end

function slot0.clearWork(slot0)
	if slot0._getSimulatedSessionRequestId then
		SLFramework.SLWebRequest.Instance:Stop(slot0._getSimulatedSessionRequestId)

		slot0._getSimulatedSessionRequestId = nil
	end
end

return slot0
