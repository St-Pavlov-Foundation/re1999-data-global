module("modules.logic.login.work.SimulateLoginWork", package.seeall)

local var_0_0 = class("SimulateLoginWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = LoginController.instance:get_getSessionIdUrl(arg_1_0.context.useBackupUrl)
	local var_1_1 = {}

	table.insert(var_1_1, string.format("account=%s", LoginModel.instance.channelUserId))
	table.insert(var_1_1, string.format("platformId=%s", "0"))

	local var_1_2 = var_1_0 .. "?" .. table.concat(var_1_1, "&")

	arg_1_0._getSimulatedSessionRequestId = SLFramework.SLWebRequest.Instance:Get(var_1_2, arg_1_0._onGetSimulatedSessionIdResponse, arg_1_0)
end

function var_0_0._onGetSimulatedSessionIdResponse(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._getSimulatedSessionRequestId = nil

	logNormal("get simulated session id response: " .. (arg_2_2 or "nil"))

	if arg_2_1 and arg_2_2 and arg_2_2 ~= "" then
		local var_2_0 = cjson.decode(arg_2_2)

		if var_2_0 and var_2_0.resultCode and var_2_0.resultCode == 0 then
			LoginModel.instance.channelSessionId = var_2_0.slSessionId

			logNormal(string.format("模拟登录的sessoinId拿到了 platformId = %d sessionId = %s", var_2_0.platformId, var_2_0.slSessionId))
			arg_2_0:onDone(true)
		else
			logNormal(string.format("出错了 resultCode = %d", var_2_0.resultCode or "nil"))
			arg_2_0:onDone(false)
		end
	else
		logError("获取session失败")
		arg_2_0:onDone(false)
	end
end

function var_0_0.clearWork(arg_3_0)
	if arg_3_0._getSimulatedSessionRequestId then
		SLFramework.SLWebRequest.Instance:Stop(arg_3_0._getSimulatedSessionRequestId)

		arg_3_0._getSimulatedSessionRequestId = nil
	end
end

return var_0_0
