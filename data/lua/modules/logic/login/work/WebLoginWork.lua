module("modules.logic.login.work.WebLoginWork", package.seeall)

local var_0_0 = class("WebLoginWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = LoginController.instance:get_httpWebLoginUrl(arg_1_0.context.useBackupUrl)
	local var_1_1 = {}

	table.insert(var_1_1, string.format("slSessionId=%s", LoginModel.instance.channelSessionId))
	table.insert(var_1_1, string.format("clientVersion=%s", "0.0.0"))
	table.insert(var_1_1, string.format("sysType=%s", BootNativeUtil.isAndroid() and "1" or "0"))
	table.insert(var_1_1, string.format("accountId=%s", LoginModel.instance.channelUserId))
	table.insert(var_1_1, string.format("channelId=%s", LoginModel.instance.channelId))
	table.insert(var_1_1, string.format("subChannelId=%s", SDKMgr.instance:getSubChannelId()))

	local var_1_2 = var_1_0 .. "?" .. table.concat(var_1_1, "&")

	arg_1_0._url = var_1_2
	arg_1_0._httpWebLoginRequestId = SLFramework.SLWebRequest.Instance:Get(var_1_2, arg_1_0._onHttpWebLoginUrlResponse, arg_1_0)

	logNormal(var_1_2)
end

function var_0_0._onHttpWebLoginUrlResponse(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._httpWebLoginRequestId = nil

	local var_2_0 = arg_2_0._url

	if arg_2_1 and arg_2_2 and arg_2_2 ~= "" then
		local var_2_1 = cjson.decode(arg_2_2)

		if var_2_1 and var_2_1.resultCode and var_2_1.resultCode == 0 then
			LoginModel.instance.userName = var_2_1.userName
			LoginModel.instance.sessionId = var_2_1.sessionId

			local var_2_2 = var_2_1.zoneInfo

			if var_2_2 then
				arg_2_0.context.serverMO = {
					id = var_2_2.id,
					name = var_2_2.name,
					prefix = var_2_2.prefix,
					state = var_2_2.state
				}
			else
				logNormal("没有服务器，zone不存在")
			end

			arg_2_0.context.webLoginSuccess = true

			arg_2_0:onDone(true)

			if string.nilorempty(LoginModel.instance.userName) or string.nilorempty(LoginModel.instance.sessionId) then
				logError(string.format("WebLoginWork response error userName:%s, sessionId:%s msg:%s url:%s", var_2_1.userName, var_2_1.sessionId, arg_2_2, var_2_0))
			end
		else
			arg_2_0.context.resultCode = var_2_1 and var_2_1.resultCode

			logNormal(string.format("http web login 出错了 resultCode = %d", var_2_1.resultCode or "nil"))
			arg_2_0:onDone(false)
		end
	else
		logNormal("http web 登录失败")
		arg_2_0:onDone(false)
	end
end

function var_0_0.clearWork(arg_3_0)
	arg_3_0._url = nil

	if arg_3_0._httpWebLoginRequestId then
		SLFramework.SLWebRequest.Instance:Stop(arg_3_0._httpWebLoginRequestId)

		arg_3_0._httpWebLoginRequestId = nil
	end
end

return var_0_0
