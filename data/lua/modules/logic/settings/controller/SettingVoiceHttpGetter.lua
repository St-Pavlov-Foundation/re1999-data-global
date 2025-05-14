module("modules.logic.settings.controller.SettingVoiceHttpGetter", package.seeall)

local var_0_0 = class("SettingVoiceHttpGetter")
local var_0_1 = 5

function var_0_0.start(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._langShortcuts, arg_1_0._langVersions = arg_1_0:_getLangVersions()

	if #arg_1_0._langShortcuts == 0 then
		arg_1_0._result = {}

		arg_1_1(arg_1_2)

		return
	end

	arg_1_0._onGetFinish = arg_1_1
	arg_1_0._onGetFinishObj = arg_1_2

	arg_1_0:_httpGet()
end

function var_0_0.stop(arg_2_0)
	if arg_2_0._requestId then
		SLFramework.SLWebRequest.Instance:Stop(arg_2_0._requestId)

		arg_2_0._requestId = nil

		UIBlockMgr.instance:endBlock(UIBlockKey.VoiceHttpGetter)
	end
end

function var_0_0._httpGet(arg_3_0)
	UIBlockMgr.instance:startBlock(UIBlockKey.VoiceHttpGetter)

	local var_3_0 = arg_3_0:_getUrl()

	logNormal("SettingVoiceHttpGetter url: " .. var_3_0)

	arg_3_0._requestId = SLFramework.SLWebRequest.Instance:Get(var_3_0, arg_3_0._onWebResponse, arg_3_0, var_0_1)
end

function var_0_0._onWebResponse(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1 then
		LoginModel.instance:resetFailCount()
		UIBlockMgr.instance:endBlock(UIBlockKey.VoiceHttpGetter)

		if arg_4_2 and arg_4_2 ~= "" then
			logNormal("获取语音包返回:" .. arg_4_2)

			arg_4_0._result = cjson.decode(arg_4_2)
		else
			logNormal("获取语音包返回空串")
		end

		local var_4_0 = arg_4_0._onGetFinish
		local var_4_1 = arg_4_0._onGetFinishObj

		arg_4_0._onGetFinish = nil
		arg_4_0._onGetFinishObj = nil

		var_4_0(var_4_1, true)
	else
		LoginModel.instance:inverseUseBackup()
		LoginModel.instance:incFailCount()

		if LoginModel.instance:isFailNeedAlert() then
			LoginModel.instance:resetFailAlertCount()
			UIBlockMgr.instance:endBlock(UIBlockKey.VoiceHttpGetter)

			arg_4_0._useBackupUrl = not arg_4_0._useBackupUrl

			local var_4_2 = MessageBoxIdDefine.CheckVersionFail
			local var_4_3 = MsgBoxEnum.BoxType.Yes_No

			MessageBoxController.instance:showMsgBoxAndSetBtn(var_4_2, var_4_3, booterLang("retry"), "retry", nil, nil, arg_4_0._httpGet, nil, nil, arg_4_0, nil, nil, arg_4_3)
		else
			arg_4_0:_httpGet()
		end
	end
end

function var_0_0.getHttpResult(arg_5_0)
	return arg_5_0._result
end

function var_0_0.getLangSize(arg_6_0, arg_6_1)
	if not arg_6_0._result then
		return 0
	end

	local var_6_0 = arg_6_0._result[arg_6_1]

	if not var_6_0 or not var_6_0.res then
		return 0
	end

	local var_6_1 = 0

	for iter_6_0, iter_6_1 in ipairs(var_6_0.res) do
		var_6_1 = var_6_1 + iter_6_1.length
	end

	return var_6_1
end

function var_0_0._getUrl(arg_7_0)
	local var_7_0 = table.concat(arg_7_0._langShortcuts, ",")
	local var_7_1 = table.concat(arg_7_0._langVersions, ",")
	local var_7_2 = {}
	local var_7_3, var_7_4 = GameUrlConfig.getOptionalUpdateUrl()
	local var_7_5 = LoginModel.instance:getUseBackup() and var_7_4 or var_7_3
	local var_7_6 = SLFramework.FrameworkSettings.CurPlatform

	if SLFramework.FrameworkSettings.IsEditor then
		var_7_6 = 0
	end

	local var_7_7 = GameChannelConfig.getServerType()

	table.insert(var_7_2, string.format("os_type=%s", var_7_6))
	table.insert(var_7_2, string.format("lang=%s", var_7_0))
	table.insert(var_7_2, string.format("version=%s", var_7_1))
	table.insert(var_7_2, string.format("env_type=%s", var_7_7))
	table.insert(var_7_2, string.format("channel_id=%s", SDKMgr.instance:getChannelId()))

	local var_7_8 = SDKMgr.instance:getGameId()
	local var_7_9 = string.format("/resource/%d/check", var_7_8)

	return var_7_5 .. var_7_9 .. "?" .. table.concat(var_7_2, "&")
end

function var_0_0._getLangVersions(arg_8_0)
	local var_8_0 = SLFramework.GameUpdate.OptionalUpdate.Instance
	local var_8_1 = {}
	local var_8_2 = {}
	local var_8_3 = HotUpdateVoiceMgr.instance:getSupportVoiceLangs()

	table.insert(var_8_3, "res-HD")

	local var_8_4 = GameConfig:GetDefaultVoiceShortcut()

	for iter_8_0 = 1, #var_8_3 do
		local var_8_5 = var_8_3[iter_8_0]
		local var_8_6 = var_8_5 ~= var_8_4
		local var_8_7 = var_8_0:GetLocalVersion(var_8_5)
		local var_8_8 = string.nilorempty(var_8_7)

		if var_8_6 and var_8_8 then
			table.insert(var_8_1, var_8_5)

			local var_8_9 = var_8_0.VoiceBranch

			if string.nilorempty(var_8_9) or not tonumber(var_8_9) then
				var_8_9 = 1

				logError("随包的语音分支错误：" .. var_8_0.VoiceBranch)
			end

			local var_8_10 = var_8_9 .. ".0"

			table.insert(var_8_2, var_8_10)
		end
	end

	return var_8_1, var_8_2
end

return var_0_0
