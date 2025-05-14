module("modules.logic.login.view.ServerListView", package.seeall)

local var_0_0 = class("ServerListView", BaseView)

function var_0_0.onInitView(arg_1_0)
	return
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.onOpen(arg_3_0)
	local var_3_0 = arg_3_0.viewParam.useBackupUrl
	local var_3_1 = LoginController.instance:get_getServerListUrl(var_3_0)
	local var_3_2 = {}

	table.insert(var_3_2, string.format("sessionId=%s", LoginModel.instance.sessionId))
	table.insert(var_3_2, string.format("zoneId=%s", 0))

	local var_3_3 = var_3_1 .. "?" .. table.concat(var_3_2, "&")

	arg_3_0._webRequestId = SLFramework.SLWebRequest.Instance:Get(var_3_3, arg_3_0._onGetServerListResponse, arg_3_0)
end

function var_0_0.onClose(arg_4_0)
	if arg_4_0._webRequestId then
		SLFramework.SLWebRequest.Instance:Stop(arg_4_0._webRequestId)

		arg_4_0._webRequestId = nil
	end
end

function var_0_0._onGetServerListResponse(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._webRequestId = nil

	logNormal("get server list response: " .. (arg_5_2 or "nil"))

	if arg_5_1 and arg_5_2 and arg_5_2 ~= "" then
		local var_5_0 = cjson.decode(arg_5_2)

		if var_5_0 and var_5_0.resultCode and var_5_0.resultCode == 0 then
			if var_5_0.zoneInfos then
				ServerListModel.instance:setServerList(var_5_0.zoneInfos)
			end
		else
			logNormal(string.format("get server list 出错了 resultCode = %d", var_5_0.resultCode))
		end
	else
		logError("get server list 失败")
	end
end

return var_0_0
