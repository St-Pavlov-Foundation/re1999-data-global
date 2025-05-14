module("projbooter.hotupdate.VoiceHttpGetter", package.seeall)

local var_0_0 = class("VoiceHttpGetter")
local var_0_1 = 5

function var_0_0.start(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._langShortcuts, arg_1_0._langVersions = arg_1_0:_getLangVersions()

	if #arg_1_0._langShortcuts == 0 then
		arg_1_1(arg_1_2)

		return
	end

	arg_1_0._onGetFinish = arg_1_1
	arg_1_0._onGetFinishObj = arg_1_2

	arg_1_0:_httpGet()
end

function var_0_0._httpGet(arg_2_0)
	local var_2_0 = arg_2_0:_getUrl()

	logNormal("OptionalUpdate url: " .. var_2_0)

	local var_2_1 = UnityEngine.Networking.UnityWebRequest.Get(var_2_0)
	local var_2_2 = SLFramework.GameUpdate.HotUpdateInfoMgr.SLInfoBase64

	var_2_1:SetRequestHeader("x-sl-info", var_2_2)
	SLFramework.SLWebRequest.Instance:SendRequest(var_2_1, arg_2_0._onWebResponse, arg_2_0, var_0_1)
end

function var_0_0._onWebResponse(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_1 then
		if arg_3_2 and arg_3_2 ~= "" then
			logNormal("获取语音包返回:" .. arg_3_2)

			arg_3_0._result = cjson.decode(arg_3_2)
		else
			logNormal("获取语音包返回空串")
		end

		BootLoadingView.instance:setProgressMsg("")
		HotUpdateMgr.instance:hideConnectTips()

		local var_3_0, var_3_1 = GameUrlConfig.getOptionalUpdateUrl()
		local var_3_2 = HotUpdateMgr.instance:getUseBackup() and var_3_1 or var_3_0

		SDKDataTrackMgr.instance:trackDomainFailCount("scene_voice_srcrequest", var_3_2, HotUpdateMgr.instance:getFailCount())
		HotUpdateMgr.instance:resetFailCount()

		local var_3_3 = arg_3_0._onGetFinish
		local var_3_4 = arg_3_0._onGetFinishObj

		arg_3_0._onGetFinish = nil
		arg_3_0._onGetFinishObj = nil

		if BootVoiceView.instance:isNeverOpen() then
			BootVoiceView.instance:showChoose(var_3_3, var_3_4)
		else
			var_3_3(var_3_4)
		end
	else
		HotUpdateMgr.instance:inverseUseBackup()
		HotUpdateMgr.instance:incFailCount()

		if HotUpdateMgr.instance:isFailNeedAlert() then
			HotUpdateMgr.instance:resetFailAlertCount()

			local var_3_5 = {
				title = booterLang("version_validate"),
				content = booterLang("version_validate_voice_fail") .. (arg_3_3 or "null"),
				leftMsg = booterLang("exit"),
				leftCb = arg_3_0._quitGame,
				leftCbObj = arg_3_0,
				rightMsg = booterLang("retry"),
				rightCb = arg_3_0._httpGet,
				rightCbObj = arg_3_0
			}

			BootMsgBox.instance:show(var_3_5)
			BootLoadingView.instance:setProgressMsg("")
			HotUpdateMgr.instance:hideConnectTips()
		else
			arg_3_0:_httpGet()
			HotUpdateMgr.instance:showConnectTips()
		end
	end
end

function var_0_0._quitGame(arg_4_0)
	logNormal("可选语音重试超过了 " .. HotUpdateMgr.FailAlertCount .. " 次，点击了退出按钮！")
	ProjBooter.instance:quitGame()
end

function var_0_0.getHttpResult(arg_5_0)
	return arg_5_0._result
end

function var_0_0._getUrl(arg_6_0)
	local var_6_0 = table.concat(arg_6_0._langShortcuts, ",")
	local var_6_1 = table.concat(arg_6_0._langVersions, ",")
	local var_6_2 = {}
	local var_6_3, var_6_4 = GameUrlConfig.getOptionalUpdateUrl()
	local var_6_5 = HotUpdateMgr.instance:getUseBackup() and var_6_4 or var_6_3
	local var_6_6 = SLFramework.FrameworkSettings.CurPlatform

	if SLFramework.FrameworkSettings.IsEditor then
		var_6_6 = 0
	end

	local var_6_7 = GameChannelConfig.getServerType()

	table.insert(var_6_2, string.format("os_type=%s", var_6_6))
	table.insert(var_6_2, string.format("lang=%s", var_6_0))
	table.insert(var_6_2, string.format("version=%s", var_6_1))
	table.insert(var_6_2, string.format("env_type=%s", var_6_7))
	table.insert(var_6_2, string.format("channel_id=%s", SDKMgr.instance:getChannelId()))

	local var_6_8 = SDKMgr.instance:getGameId()
	local var_6_9 = string.format("/resource/%d/check", var_6_8)

	return var_6_5 .. var_6_9 .. "?" .. table.concat(var_6_2, "&")
end

function var_0_0._getLangVersions(arg_7_0)
	local var_7_0 = SLFramework.GameUpdate.OptionalUpdate.Instance
	local var_7_1 = {}
	local var_7_2 = {}
	local var_7_3 = HotUpdateVoiceMgr.instance:getSupportVoiceLangs()

	table.insert(var_7_3, "res-HD")

	local var_7_4 = GameConfig:GetDefaultVoiceShortcut()
	local var_7_5 = GameConfig:GetCurVoiceShortcut()

	for iter_7_0 = 1, #var_7_3 do
		local var_7_6 = var_7_3[iter_7_0]
		local var_7_7 = var_7_6 ~= var_7_4
		local var_7_8 = var_7_5 == var_7_6
		local var_7_9 = var_7_0:GetLocalVersion(var_7_6)
		local var_7_10 = not string.nilorempty(var_7_9)
		local var_7_11 = not BootVoiceView.instance:isFirstDownloadDone()

		if var_7_7 and (var_7_10 or var_7_11 or var_7_8) then
			table.insert(var_7_1, var_7_6)

			local var_7_12 = var_7_0.VoiceBranch

			if string.nilorempty(var_7_12) or not tonumber(var_7_12) then
				var_7_12 = 1

				logError("随包的语音分支错误：" .. var_7_0.VoiceBranch)
			end

			local var_7_13 = var_7_12 .. "." .. (string.nilorempty(var_7_9) and "0" or var_7_9)

			table.insert(var_7_2, var_7_13)
		end
	end

	return var_7_1, var_7_2
end

return var_0_0
