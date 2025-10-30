module("projbooter.hotupdate.optionpackage.OptionPackageHttpGetter", package.seeall)

local var_0_0 = class("OptionPackageHttpGetter")
local var_0_1 = 5
local var_0_2 = 3
local var_0_3 = 0
local var_0_4 = {}

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_3 = var_0_3 + 1
	arg_1_0._httpId = var_0_3
	arg_1_0._sourceType = arg_1_1 or 2
	arg_1_0._langPackList = {}

	tabletool.addValues(arg_1_0._langPackList, arg_1_2)
end

function var_0_0.getHttpId(arg_2_0)
	return arg_2_0._httpId
end

function var_0_0.getSourceType(arg_3_0)
	return arg_3_0._sourceType
end

function var_0_0.getLangPackList(arg_4_0)
	return arg_4_0._langPackList
end

function var_0_0.start(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._langShortcuts, arg_5_0._langVersions = arg_5_0:_getLangVersions()
	arg_5_0._onGetFinish = arg_5_1
	arg_5_0._onGetFinishObj = arg_5_2
	arg_5_0._retryCount = 0
	arg_5_0._useBackupUrl = false

	arg_5_0:_httpGet()
end

function var_0_0.stop(arg_6_0)
	if arg_6_0._requestId then
		SLFramework.SLWebRequest.Instance:Stop(arg_6_0._requestId)

		arg_6_0._requestId = nil
	end

	arg_6_0:_stopRetryTimer()
end

function var_0_0._httpGet(arg_7_0)
	local var_7_0 = arg_7_0:_getUrl()

	logNormal("OptionPackageHttpGetter url: " .. var_7_0)

	if var_0_4 and var_0_4[arg_7_0._sourceType] then
		var_7_0 = var_0_4[arg_7_0._sourceType]

		logNormal("OptionPackageHttpGetter url: " .. var_7_0)
	end

	arg_7_0._requestId = SLFramework.SLWebRequest.Instance:Get(var_7_0, arg_7_0._onWebResponse, arg_7_0, var_0_1)

	arg_7_0:_stopRetryTimer()
end

function var_0_0._onWebResponse(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_1 then
		if arg_8_2 and arg_8_2 ~= "" then
			logNormal("获取可选资源返回:" .. arg_8_2)

			arg_8_0._result = cjson.decode(arg_8_2)
		else
			logNormal("获取可选资源返回空串")
		end

		arg_8_0:_runCallblck(true)
		arg_8_0:_stopRetryTimer()
	else
		arg_8_0:_stopRetryTimer()

		arg_8_0._retryTimer = Timer.New(function()
			arg_8_0._retryTimer = nil

			if arg_8_0._retryCount >= var_0_2 then
				arg_8_0._useBackupUrl = not arg_8_0._useBackupUrl
				arg_8_0._retryCount = 0

				arg_8_0:_runCallblck(false)
			else
				arg_8_0._retryCount = arg_8_0._retryCount + 1

				arg_8_0:_httpGet()
			end
		end, 1)

		arg_8_0._retryTimer:Start()
	end
end

function var_0_0._stopRetryTimer(arg_10_0)
	if arg_10_0._retryTimer then
		local var_10_0 = arg_10_0._retryTimer

		arg_10_0._retryTimer = nil

		var_10_0:Stop()
	end
end

function var_0_0._runCallblck(arg_11_0, arg_11_1)
	if arg_11_0._onGetFinish == nil then
		return
	end

	local var_11_0 = arg_11_0._onGetFinish
	local var_11_1 = arg_11_0._onGetFinishObj

	arg_11_0._onGetFinish = nil
	arg_11_0._onGetFinishObj = nil

	var_11_0(var_11_1, arg_11_1, arg_11_0)
end

function var_0_0.getHttpResult(arg_12_0)
	return arg_12_0._result
end

function var_0_0.getLangSize(arg_13_0, arg_13_1)
	if not arg_13_0._result then
		return 0
	end

	local var_13_0 = arg_13_0._result[arg_13_1]

	if not var_13_0 or not var_13_0.res then
		return 0
	end

	local var_13_1 = 0

	for iter_13_0, iter_13_1 in ipairs(var_13_0.res) do
		var_13_1 = var_13_1 + iter_13_1.length
	end

	return var_13_1
end

function var_0_0._getUrl(arg_14_0)
	local var_14_0 = table.concat(arg_14_0._langShortcuts, ",")
	local var_14_1 = table.concat(arg_14_0._langVersions, ",")
	local var_14_2 = {}
	local var_14_3, var_14_4 = GameUrlConfig.getOptionalUpdateUrl()
	local var_14_5 = arg_14_0._useBackupUrl and var_14_4 or var_14_3
	local var_14_6 = SLFramework.FrameworkSettings.CurPlatform

	if SLFramework.FrameworkSettings.IsEditor then
		var_14_6 = 0
	end

	local var_14_7 = GameChannelConfig.getServerType()

	table.insert(var_14_2, string.format("os_type=%s", var_14_6))
	table.insert(var_14_2, string.format("lang=%s", var_14_0))
	table.insert(var_14_2, string.format("version=%s", var_14_1))
	table.insert(var_14_2, string.format("env_type=%s", var_14_7))
	table.insert(var_14_2, string.format("channel_id=%s", SDKMgr.instance:getChannelId()))

	local var_14_8 = SDKMgr.instance:getGameId()
	local var_14_9 = string.format("/resource/%d/check", var_14_8)

	return var_14_5 .. var_14_9 .. "?" .. table.concat(var_14_2, "&")
end

function var_0_0._getLangVersions(arg_15_0)
	local var_15_0 = SLFramework.GameUpdate.OptionalUpdate.Instance
	local var_15_1 = {}
	local var_15_2 = {}
	local var_15_3 = arg_15_0._langPackList
	local var_15_4 = arg_15_0:_getBranchVersion()

	for iter_15_0 = 1, #var_15_3 do
		local var_15_5 = var_15_3[iter_15_0]
		local var_15_6 = var_15_0:GetLocalVersion(var_15_5)
		local var_15_7 = var_15_4 .. "." .. (string.nilorempty(var_15_6) and "0" or var_15_6)

		table.insert(var_15_1, var_15_5)
		table.insert(var_15_2, var_15_7)
	end

	return var_15_1, var_15_2
end

function var_0_0._getBranchVersion(arg_16_0)
	local var_16_0 = SLFramework.GameUpdate.OptionalUpdate.Instance
	local var_16_1 = var_16_0.VoiceBranch

	if string.nilorempty(var_16_1) or not tonumber(var_16_1) then
		var_16_1 = 1

		logError("随包的语音分支错误：" .. var_16_0.VoiceBranch)
	end

	return var_16_1
end

return var_0_0
