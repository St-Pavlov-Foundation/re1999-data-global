module("projbooter.hotupdate.VoiceHttpGetter", package.seeall)

slot0 = class("VoiceHttpGetter")
slot1 = 5

function slot0.start(slot0, slot1, slot2)
	slot0._langShortcuts, slot0._langVersions = slot0:_getLangVersions()

	if #slot0._langShortcuts == 0 then
		slot1(slot2)

		return
	end

	slot0._onGetFinish = slot1
	slot0._onGetFinishObj = slot2

	slot0:_httpGet()
end

function slot0._httpGet(slot0)
	slot1 = slot0:_getUrl()

	logNormal("OptionalUpdate url: " .. slot1)

	slot2 = UnityEngine.Networking.UnityWebRequest.Get(slot1)

	slot2:SetRequestHeader("x-sl-info", SLFramework.GameUpdate.HotUpdateInfoMgr.SLInfoBase64)
	SLFramework.SLWebRequest.Instance:SendRequest(slot2, slot0._onWebResponse, slot0, uv0)
end

function slot0._onWebResponse(slot0, slot1, slot2, slot3)
	if slot1 then
		if slot2 and slot2 ~= "" then
			logNormal("获取语音包返回:" .. slot2)

			slot0._result = cjson.decode(slot2)
		else
			logNormal("获取语音包返回空串")
		end

		BootLoadingView.instance:setProgressMsg("")
		HotUpdateMgr.instance:hideConnectTips()

		slot4, slot5 = GameUrlConfig.getOptionalUpdateUrl()

		SDKDataTrackMgr.instance:trackDomainFailCount("scene_voice_srcrequest", HotUpdateMgr.instance:getUseBackup() and slot5 or slot4, HotUpdateMgr.instance:getFailCount())
		HotUpdateMgr.instance:resetFailCount()

		slot0._onGetFinish = nil
		slot0._onGetFinishObj = nil

		if BootVoiceView.instance:isNeverOpen() then
			BootVoiceView.instance:showChoose(slot0._onGetFinish, slot0._onGetFinishObj)
		else
			slot7(slot8)
		end
	else
		HotUpdateMgr.instance:inverseUseBackup()
		HotUpdateMgr.instance:incFailCount()

		if HotUpdateMgr.instance:isFailNeedAlert() then
			HotUpdateMgr.instance:resetFailAlertCount()
			BootMsgBox.instance:show({
				title = booterLang("version_validate"),
				content = booterLang("version_validate_voice_fail") .. (slot3 or "null"),
				leftMsg = booterLang("exit"),
				leftCb = slot0._quitGame,
				leftCbObj = slot0,
				rightMsg = booterLang("retry"),
				rightCb = slot0._httpGet,
				rightCbObj = slot0
			})
			BootLoadingView.instance:setProgressMsg("")
			HotUpdateMgr.instance:hideConnectTips()
		else
			slot0:_httpGet()
			HotUpdateMgr.instance:showConnectTips()
		end
	end
end

function slot0._quitGame(slot0)
	logNormal("可选语音重试超过了 " .. HotUpdateMgr.FailAlertCount .. " 次，点击了退出按钮！")
	ProjBooter.instance:quitGame()
end

function slot0.getHttpResult(slot0)
	return slot0._result
end

function slot0._getUrl(slot0)
	slot1 = table.concat(slot0._langShortcuts, ",")
	slot2 = table.concat(slot0._langVersions, ",")
	slot3 = {}
	slot4, slot5 = GameUrlConfig.getOptionalUpdateUrl()
	slot6 = HotUpdateMgr.instance:getUseBackup() and slot5 or slot4
	slot7 = SLFramework.FrameworkSettings.CurPlatform

	if SLFramework.FrameworkSettings.IsEditor then
		slot7 = 0
	end

	table.insert(slot3, string.format("os_type=%s", slot7))
	table.insert(slot3, string.format("lang=%s", slot1))
	table.insert(slot3, string.format("version=%s", slot2))
	table.insert(slot3, string.format("env_type=%s", GameChannelConfig.getServerType()))
	table.insert(slot3, string.format("channel_id=%s", SDKMgr.instance:getChannelId()))

	return slot6 .. string.format("/resource/%d/check", SDKMgr.instance:getGameId()) .. "?" .. table.concat(slot3, "&")
end

function slot0._getLangVersions(slot0)
	slot1 = SLFramework.GameUpdate.OptionalUpdate.Instance
	slot2 = {}
	slot3 = {}

	for slot10 = 1, #HotUpdateVoiceMgr.instance:getSupportVoiceLangs() do
		if slot4[slot10] ~= GameConfig:GetDefaultVoiceShortcut() and (not string.nilorempty(slot1:GetLocalVersion(slot11)) or not BootVoiceView.instance:isFirstDownloadDone() or GameConfig:GetCurVoiceShortcut() == slot11) then
			table.insert(slot2, slot11)

			if string.nilorempty(slot1.VoiceBranch) or not tonumber(slot17) then
				slot17 = 1

				logError("随包的语音分支错误：" .. slot1.VoiceBranch)
			end

			table.insert(slot3, slot17 .. "." .. (string.nilorempty(slot14) and "0" or slot14))
		end
	end

	return slot2, slot3
end

return slot0
