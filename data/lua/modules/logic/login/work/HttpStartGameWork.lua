module("modules.logic.login.work.HttpStartGameWork", package.seeall)

local var_0_0 = class("HttpStartGameWork", BaseWork)
local var_0_1 = 5
local var_0_2
local var_0_3
local var_0_4

function var_0_0.onStart(arg_1_0, arg_1_1)
	if var_0_2 and Time.time - var_0_2 < var_0_1 then
		TaskDispatcher.runDelay(arg_1_0._delayRespondInCd, arg_1_0, 0.1)
	else
		var_0_2 = Time.time

		local var_1_0 = LoginController.instance:get_startGameUrl(arg_1_0.context.useBackupUrl)
		local var_1_1 = {}

		table.insert(var_1_1, string.format("sessionId=%s", LoginModel.instance.sessionId))
		table.insert(var_1_1, string.format("zoneId=%s", arg_1_0.context.lastServerMO.id))

		local var_1_2 = var_1_0 .. "?" .. table.concat(var_1_1, "&")

		arg_1_0._url = var_1_2
		arg_1_0._httpStartGameRequestId = SLFramework.SLWebRequest.Instance:Get(var_1_2, arg_1_0._onHttpStartGameResponse, arg_1_0)

		logNormal(var_1_2)
	end
end

function var_0_0._delayRespondInCd(arg_2_0)
	arg_2_0:_onHttpStartGameResponse(var_0_3, var_0_4)
end

function var_0_0._onHttpStartGameResponse(arg_3_0, arg_3_1, arg_3_2)
	var_0_3 = arg_3_1
	var_0_4 = arg_3_2
	arg_3_0._httpStartGameRequestId = nil

	local var_3_0 = arg_3_0._url

	logNormal("http start game response: " .. (arg_3_2 or "nil"))

	if arg_3_1 and arg_3_2 and arg_3_2 ~= "" then
		local var_3_1 = cjson.decode(arg_3_2)

		if var_3_1 and var_3_1.resultCode and var_3_1.resultCode == 0 then
			if var_3_1.state == 1 then
				LoginModel.instance.serverIp = var_3_1.ip
				LoginModel.instance.serverPort = var_3_1.port

				if not string.nilorempty(var_3_1.bakIp) then
					LoginModel.instance.serverBakIp = var_3_1.bakIp
					LoginModel.instance.serverBakPort = var_3_1.bakPort
				end

				LoginModel.instance.serverName = arg_3_0.context.lastServerMO.name
				LoginModel.instance.serverId = arg_3_0.context.lastServerMO.id

				logNormal("<color=#00FF00>http 登录成功</color>")
				arg_3_0:onDone(true)

				if not LoginModel.instance.serverIp or not LoginModel.instance.serverPort then
					logError(string.format("HttpStartGameWork response error serverIp:%s, serverPort:%s msg:%s url:%s", var_3_1.ip, var_3_1.port, arg_3_2, var_3_0))
				end
			else
				if var_3_1.state == 0 then
					arg_3_0.context.dontReconnect = true

					local var_3_2 = GameChannelConfig.isLongCheng() or GameChannelConfig.isEfun()
					local var_3_3 = false

					if (not var_3_2 or false) and SDKMgr.instance:isShowStopServiceBaffle() then
						SDKMgr.instance:stopService()
					elseif string.nilorempty(var_3_1.tips) then
						GameFacade.showMessageBox(MessageBoxIdDefine.ServerNotConnect, MsgBoxEnum.BoxType.Yes)
					else
						MessageBoxController.instance:showMsgBoxByStr(var_3_1.tips, MsgBoxEnum.BoxType.Yes)
					end

					logWarn("服务器未开启")
				else
					logWarn("服务器爆满")
				end

				arg_3_0:onDone(false)
			end
		else
			arg_3_0.context.resultCode = var_3_1 and var_3_1.resultCode

			logNormal(string.format("http start game 出错了 resultCode = %d", var_3_1.resultCode or "nil"))
			arg_3_0:onDone(false)
		end
	else
		logNormal("http start game 失败")
		arg_3_0:onDone(false)
	end
end

function var_0_0.clearWork(arg_4_0)
	arg_4_0._url = nil

	TaskDispatcher.cancelTask(arg_4_0._delayRespondInCd, arg_4_0)

	if arg_4_0._httpStartGameRequestId then
		SLFramework.SLWebRequest.Instance:Stop(arg_4_0._httpStartGameRequestId)

		arg_4_0._httpStartGameRequestId = nil
	end
end

return var_0_0
