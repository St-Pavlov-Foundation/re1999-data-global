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
end

function var_0_0._httpGet(arg_7_0)
	local var_7_0 = arg_7_0:_getUrl()

	logNormal("OptionPackageHttpGetter url: " .. var_7_0)

	if var_0_4 and var_0_4[arg_7_0._sourceType] then
		var_7_0 = var_0_4[arg_7_0._sourceType]

		logNormal("OptionPackageHttpGetter url: " .. var_7_0)
	end

	arg_7_0._requestId = SLFramework.SLWebRequest.Instance:Get(var_7_0, arg_7_0._onWebResponse, arg_7_0, var_0_1)
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
	elseif arg_8_0._retryCount >= var_0_2 then
		arg_8_0._useBackupUrl = not arg_8_0._useBackupUrl
		arg_8_0._retryCount = 0

		arg_8_0:_runCallblck(false)
	else
		arg_8_0._retryCount = arg_8_0._retryCount + 1

		arg_8_0:_httpGet()
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

function var_0_0.getLangSize(arg_11_0, arg_11_1)
	if not arg_11_0._result then
		return 0
	end

	local var_11_0 = arg_11_0._result[arg_11_1]

	if not var_11_0 or not var_11_0.res then
		return 0
	end

	local var_11_1 = 0

	for iter_11_0, iter_11_1 in ipairs(var_11_0.res) do
		var_11_1 = var_11_1 + iter_11_1.length
	end

	return var_11_1
end

function var_0_0._getUrl(arg_12_0)
	local var_12_0 = table.concat(arg_12_0._langShortcuts, ",")
	local var_12_1 = table.concat(arg_12_0._langVersions, ",")
	local var_12_2 = {}
	local var_12_3, var_12_4 = GameUrlConfig.getOptionalUpdateUrl()
	local var_12_5 = arg_12_0._useBackupUrl and var_12_4 or var_12_3
	local var_12_6 = SLFramework.FrameworkSettings.CurPlatform

	if SLFramework.FrameworkSettings.IsEditor then
		var_12_6 = 0
	end

	local var_12_7 = GameChannelConfig.getServerType()

	table.insert(var_12_2, string.format("os_type=%s", var_12_6))
	table.insert(var_12_2, string.format("lang=%s", var_12_0))
	table.insert(var_12_2, string.format("version=%s", var_12_1))
	table.insert(var_12_2, string.format("env_type=%s", var_12_7))
	table.insert(var_12_2, string.format("channel_id=%s", SDKMgr.instance:getChannelId()))

	local var_12_8 = SDKMgr.instance:getGameId()
	local var_12_9 = string.format("/resource/%d/check", var_12_8)

	return var_12_5 .. var_12_9 .. "?" .. table.concat(var_12_2, "&")
end

function var_0_0._getLangVersions(arg_13_0)
	local var_13_0 = SLFramework.GameUpdate.OptionalUpdate.Instance
	local var_13_1 = {}
	local var_13_2 = {}
	local var_13_3 = arg_13_0._langPackList
	local var_13_4 = arg_13_0:_getBranchVersion()

	for iter_13_0 = 1, #var_13_3 do
		local var_13_5 = var_13_3[iter_13_0]
		local var_13_6 = var_13_0:GetLocalVersion(var_13_5)
		local var_13_7 = var_13_4 .. "." .. (string.nilorempty(var_13_6) and "0" or var_13_6)

		table.insert(var_13_1, var_13_5)
		table.insert(var_13_2, var_13_7)
	end

	return var_13_1, var_13_2
end

function var_0_0._getBranchVersion(arg_14_0)
	local var_14_0 = SLFramework.GameUpdate.OptionalUpdate.Instance
	local var_14_1 = var_14_0.VoiceBranch

	if string.nilorempty(var_14_1) or not tonumber(var_14_1) then
		var_14_1 = 1

		logError("随包的语音分支错误：" .. var_14_0.VoiceBranch)
	end

	return var_14_1
end

return var_0_0
