module("modules.logic.login.view.ServerListView", package.seeall)

slot0 = class("ServerListView", BaseView)

function slot0.onInitView(slot0)
end

function slot0.addEvents(slot0)
end

function slot0.onOpen(slot0)
	slot3 = {}

	table.insert(slot3, string.format("sessionId=%s", LoginModel.instance.sessionId))
	table.insert(slot3, string.format("zoneId=%s", 0))

	slot0._webRequestId = SLFramework.SLWebRequest.Instance:Get(LoginController.instance:get_getServerListUrl(slot0.viewParam.useBackupUrl) .. "?" .. table.concat(slot3, "&"), slot0._onGetServerListResponse, slot0)
end

function slot0.onClose(slot0)
	if slot0._webRequestId then
		SLFramework.SLWebRequest.Instance:Stop(slot0._webRequestId)

		slot0._webRequestId = nil
	end
end

function slot0._onGetServerListResponse(slot0, slot1, slot2)
	slot0._webRequestId = nil

	logNormal("get server list response: " .. (slot2 or "nil"))

	if slot1 and slot2 and slot2 ~= "" then
		if cjson.decode(slot2) and slot3.resultCode and slot3.resultCode == 0 then
			if slot3.zoneInfos then
				ServerListModel.instance:setServerList(slot3.zoneInfos)
			end
		else
			logNormal(string.format("get server list 出错了 resultCode = %d", slot3.resultCode))
		end
	else
		logError("get server list 失败")
	end
end

return slot0
