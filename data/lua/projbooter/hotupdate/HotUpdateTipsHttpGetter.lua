module("projbooter.hotupdate.HotUpdateTipsHttpGetter", package.seeall)

local var_0_0 = class("HotUpdateTipsHttpGetter")
local var_0_1 = 5
local var_0_2 = 2
local var_0_3 = {
	"zh-CN",
	"zh-TW",
	nil,
	"en",
	nil,
	nil,
	nil,
	"ko-KR",
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	"ja-JP",
	[32] = "de",
	[128] = "th",
	[64] = "fr"
}

local function var_0_4(arg_1_0)
	return cjson.decode(arg_1_0)
end

function var_0_0.ctor(arg_2_0)
	return
end

function var_0_0.start(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._onGetFinish = arg_3_1
	arg_3_0._onGetFinishObj = arg_3_2
	arg_3_0._retryCount = 0
	arg_3_0._useBackupUrl = false

	arg_3_0:_httpGet()
end

function var_0_0.stop(arg_4_0)
	if arg_4_0._requestId then
		SLFramework.SLWebRequest.Instance:Stop(arg_4_0._requestId)

		arg_4_0._requestId = nil
	end

	arg_4_0:_stopRetryTimer()
end

function var_0_0._httpGet(arg_5_0)
	local var_5_0 = arg_5_0:_getUrl()

	logNormal(var_5_0)

	local var_5_1 = UnityEngine.Networking.UnityWebRequest.Get(var_5_0)
	local var_5_2 = SLFramework.GameUpdate.HotUpdateInfoMgr.SLInfoBase64

	var_5_1:SetRequestHeader("x-sl-info", var_5_2)

	arg_5_0._requestId = SLFramework.SLWebRequest.Instance:SendRequest(var_5_1, arg_5_0._onWebResponse, arg_5_0, var_0_1)

	arg_5_0:_stopRetryTimer()
end

function var_0_0._onWebResponse(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_1 then
		if arg_6_2 and arg_6_2 ~= "" then
			logNormal("获取更新提示语返回:" .. arg_6_2)

			local var_6_0, var_6_1 = xpcall(var_0_4, __G__TRACKBACK__, arg_6_2)

			arg_6_0._result = nil

			if var_6_0 then
				arg_6_0._result = var_6_1
			end
		else
			logNormal("获取更新提示语返回")
		end

		arg_6_0:_runCallblck(true)
		arg_6_0:_stopRetryTimer()
	else
		arg_6_0:_stopRetryTimer()

		arg_6_0._retryTimer = Timer.New(function()
			arg_6_0._retryTimer = nil

			if arg_6_0._retryCount >= var_0_2 then
				arg_6_0._useBackupUrl = not arg_6_0._useBackupUrl
				arg_6_0._retryCount = 0

				arg_6_0:_runCallblck(false)
			else
				arg_6_0._retryCount = arg_6_0._retryCount + 1

				arg_6_0:_httpGet()
			end
		end, 1)

		arg_6_0._retryTimer:Start()
	end
end

function var_0_0._stopRetryTimer(arg_8_0)
	if arg_8_0._retryTimer then
		local var_8_0 = arg_8_0._retryTimer

		arg_8_0._retryTimer = nil

		var_8_0:Stop()
	end
end

function var_0_0._runCallblck(arg_9_0, arg_9_1)
	if arg_9_0._onGetFinish == nil then
		return
	end

	local var_9_0 = arg_9_0._onGetFinish
	local var_9_1 = arg_9_0._onGetFinishObj

	arg_9_0._onGetFinish = nil
	arg_9_0._onGetFinishObj = nil

	var_9_0(var_9_1, arg_9_1, arg_9_0)
end

function var_0_0.getHttpResult(arg_10_0)
	return arg_10_0._result
end

function var_0_0.getTipsStr(arg_11_0)
	local var_11_0 = arg_11_0._result

	if var_11_0 and var_11_0.code == 200 and var_11_0.data and var_11_0.data.prompt then
		return var_11_0.data.prompt
	end

	return nil
end

function var_0_0._getUrl(arg_12_0)
	local var_12_0 = {}
	local var_12_1, var_12_2 = GameUrlConfig.getHotUpdateUrl()
	local var_12_3 = arg_12_0._useBackupUrl and var_12_2 or var_12_1
	local var_12_4 = SLFramework.FrameworkSettings.CurPlatform

	if SLFramework.FrameworkSettings.IsEditor then
		var_12_4 = 0
	end

	local var_12_5 = GameConfig:GetDefaultLangType()
	local var_12_6 = GameChannelConfig.getServerType()
	local var_12_7 = UnityEngine.Application.version

	table.insert(var_12_0, string.format("gameId=%s", SDKMgr.instance:getGameId()))
	table.insert(var_12_0, string.format("osType=%s", var_12_4))
	table.insert(var_12_0, string.format("currentVersion=%s", var_12_7))
	table.insert(var_12_0, string.format("channelId=%s", SDKMgr.instance:getChannelId()))
	table.insert(var_12_0, string.format("subChannelId=%s", SDKMgr.instance:getSubChannelId()))
	table.insert(var_12_0, string.format("serverType=%s", var_12_6))
	table.insert(var_12_0, string.format("lang=%s", var_0_3[var_12_5]))

	return var_12_3 .. "/prompt/get?" .. table.concat(var_12_0, "&")
end

return var_0_0
