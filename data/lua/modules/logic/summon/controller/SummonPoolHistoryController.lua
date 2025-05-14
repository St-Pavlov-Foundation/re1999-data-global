module("modules.logic.summon.controller.SummonPoolHistoryController", package.seeall)

local var_0_0 = class("SummonPoolHistoryController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.onInitFinish(arg_3_0)
	return
end

function var_0_0.addConstEvents(arg_4_0)
	return
end

function var_0_0.updateSummonQueryToken(arg_5_0, arg_5_1)
	SummonPoolHistoryModel.instance:setToken(arg_5_1.token)
	arg_5_0:_requestWeb()
end

function var_0_0.request(arg_6_0)
	if LoginModel.instance.serverIp == nil or LoginModel.instance.serverPort == nil then
		logNormal("serverIp is nil, or serverPort is nil")

		return
	end

	if arg_6_0._httpWebRequestId then
		return
	end

	if SummonPoolHistoryModel.instance:isTokenValidity() then
		arg_6_0:_requestWeb()
	else
		SummonRpc.instance:sendSummonQueryTokenRequest()
	end
end

function var_0_0._requestWeb(arg_7_0)
	if arg_7_0._httpWebRequestId then
		return
	end

	local var_7_0
	local var_7_1 = UrlConfig.getConfig().login

	if type(var_7_1) == "table" then
		local var_7_2 = tostring(SDKMgr.instance:getChannelId()) or "100"

		var_7_0 = var_7_1[var_7_2]

		if not var_7_0 then
			for iter_7_0, iter_7_1 in pairs(var_7_1) do
				var_7_0 = iter_7_1

				logError(string.format("httpLoginUrl not exist, channelId=%s\nuse %s:%s", var_7_2, iter_7_0, var_7_0 or "nil"))

				break
			end
		end
	else
		var_7_0 = var_7_1
	end

	local var_7_3 = string.format("%s/query/summon", var_7_0)
	local var_7_4 = {}

	table.insert(var_7_4, string.format("userId=%s", PlayerModel.instance:getMyUserId()))
	table.insert(var_7_4, string.format("token=%s", SummonPoolHistoryModel.instance:getToken()))

	local var_7_5 = var_7_3 .. "?" .. table.concat(var_7_4, "&")

	arg_7_0._httpWebRequestId = SLFramework.SLWebRequest.Instance:Get(var_7_5, arg_7_0._onHttpWebHistoryDataResponse, arg_7_0)

	logNormal(var_7_5)
end

function var_0_0._onHttpWebHistoryDataResponse(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._httpWebRequestId = nil

	if not arg_8_1 or string.nilorempty(arg_8_2) then
		logNormal(string.format("获取卡池历史失败"))

		return
	end

	local var_8_0 = cjson.decode(arg_8_2)

	if var_8_0 and var_8_0.code and var_8_0.code == 200 then
		arg_8_0._lastGetTime = Time.time

		logNormal(string.format("获取卡池历史成功！！"))
		SummonPoolHistoryModel.instance:onGetInfo(var_8_0.data)
		SummonController.instance:dispatchEvent(SummonEvent.onGetSummonPoolHistoryData)
	elseif var_8_0 then
		logNormal(string.format("获取卡池历史出错了 code = %d", var_8_0.code))
	else
		logNormal(string.format("获取卡池历史出错了"))
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
