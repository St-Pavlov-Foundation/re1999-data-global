module("modules.logic.login.work.HttpStartGameWork", package.seeall)

slot0 = class("HttpStartGameWork", BaseWork)
slot1 = 5
slot2, slot3, slot4 = nil

function slot0.onStart(slot0, slot1)
	if uv0 and Time.time - uv0 < uv1 then
		TaskDispatcher.runDelay(slot0._delayRespondInCd, slot0, 0.1)
	else
		uv0 = Time.time
		slot3 = {}

		table.insert(slot3, string.format("sessionId=%s", LoginModel.instance.sessionId))
		table.insert(slot3, string.format("zoneId=%s", slot0.context.lastServerMO.id))

		slot2 = LoginController.instance:get_startGameUrl(slot0.context.useBackupUrl) .. "?" .. table.concat(slot3, "&")
		slot0._url = slot2
		slot0._httpStartGameRequestId = SLFramework.SLWebRequest.Instance:Get(slot2, slot0._onHttpStartGameResponse, slot0)

		logNormal(slot2)
	end
end

function slot0._delayRespondInCd(slot0)
	slot0:_onHttpStartGameResponse(uv0, uv1)
end

function slot0._onHttpStartGameResponse(slot0, slot1, slot2)
	uv0 = slot1
	uv1 = slot2
	slot0._httpStartGameRequestId = nil
	slot3 = slot0._url

	logNormal("http start game response: " .. (slot2 or "nil"))

	if slot1 and slot2 and slot2 ~= "" then
		if cjson.decode(slot2) and slot4.resultCode and slot4.resultCode == 0 then
			if slot4.state == 1 then
				LoginModel.instance.serverIp = slot4.ip
				LoginModel.instance.serverPort = slot4.port

				if not string.nilorempty(slot4.bakIp) then
					LoginModel.instance.serverBakIp = slot4.bakIp
					LoginModel.instance.serverBakPort = slot4.bakPort
				end

				LoginModel.instance.serverName = slot0.context.lastServerMO.name
				LoginModel.instance.serverId = slot0.context.lastServerMO.id

				logNormal("<color=#00FF00>http 登录成功</color>")
				slot0:onDone(true)

				if not LoginModel.instance.serverIp or not LoginModel.instance.serverPort then
					logError(string.format("HttpStartGameWork response error serverIp:%s, serverPort:%s msg:%s url:%s", slot4.ip, slot4.port, slot2, slot3))
				end
			else
				if slot4.state == 0 then
					slot0.context.dontReconnect = true
					slot6 = false

					if (not (GameChannelConfig.isLongCheng() or GameChannelConfig.isEfun()) or false) and SDKMgr.instance:isShowStopServiceBaffle() then
						SDKMgr.instance:stopService()
					elseif string.nilorempty(slot4.tips) then
						GameFacade.showMessageBox(MessageBoxIdDefine.ServerNotConnect, MsgBoxEnum.BoxType.Yes)
					else
						MessageBoxController.instance:showMsgBoxByStr(slot4.tips, MsgBoxEnum.BoxType.Yes)
					end

					logWarn("服务器未开启")
				else
					logWarn("服务器爆满")
				end

				slot0:onDone(false)
			end
		else
			slot0.context.resultCode = slot4 and slot4.resultCode

			logNormal(string.format("http start game 出错了 resultCode = %d", slot4.resultCode or "nil"))
			slot0:onDone(false)
		end
	else
		logNormal("http start game 失败")
		slot0:onDone(false)
	end
end

function slot0.clearWork(slot0)
	slot0._url = nil

	TaskDispatcher.cancelTask(slot0._delayRespondInCd, slot0)

	if slot0._httpStartGameRequestId then
		SLFramework.SLWebRequest.Instance:Stop(slot0._httpStartGameRequestId)

		slot0._httpStartGameRequestId = nil
	end
end

return slot0
