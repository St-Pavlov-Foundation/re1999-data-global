module("modules.logic.settings.controller.SettingVoiceHttpGetter", package.seeall)

slot0 = class("SettingVoiceHttpGetter")
slot1 = 5

function slot0.start(slot0, slot1, slot2)
	slot0._langShortcuts, slot0._langVersions = slot0:_getLangVersions()

	if #slot0._langShortcuts == 0 then
		slot0._result = {}

		slot1(slot2)

		return
	end

	slot0._onGetFinish = slot1
	slot0._onGetFinishObj = slot2

	slot0:_httpGet()
end

function slot0.stop(slot0)
	if slot0._requestId then
		SLFramework.SLWebRequest.Instance:Stop(slot0._requestId)

		slot0._requestId = nil

		UIBlockMgr.instance:endBlock(UIBlockKey.VoiceHttpGetter)
	end
end

function slot0._httpGet(slot0)
	UIBlockMgr.instance:startBlock(UIBlockKey.VoiceHttpGetter)

	slot1 = slot0:_getUrl()

	logNormal("SettingVoiceHttpGetter url: " .. slot1)

	slot0._requestId = SLFramework.SLWebRequest.Instance:Get(slot1, slot0._onWebResponse, slot0, uv0)
end

function slot0._onWebResponse(slot0, slot1, slot2, slot3)
	if slot1 then
		LoginModel.instance:resetFailCount()
		UIBlockMgr.instance:endBlock(UIBlockKey.VoiceHttpGetter)

		if slot2 and slot2 ~= "" then
			logNormal("获取语音包返回:" .. slot2)

			slot0._result = cjson.decode(slot2)
		else
			logNormal("获取语音包返回空串")
		end

		slot0._onGetFinish = nil
		slot0._onGetFinishObj = nil

		slot0._onGetFinish(slot0._onGetFinishObj, true)
	else
		LoginModel.instance:inverseUseBackup()
		LoginModel.instance:incFailCount()

		if LoginModel.instance:isFailNeedAlert() then
			LoginModel.instance:resetFailAlertCount()
			UIBlockMgr.instance:endBlock(UIBlockKey.VoiceHttpGetter)

			slot0._useBackupUrl = not slot0._useBackupUrl

			MessageBoxController.instance:showMsgBoxAndSetBtn(MessageBoxIdDefine.CheckVersionFail, MsgBoxEnum.BoxType.Yes_No, booterLang("retry"), "retry", nil, , slot0._httpGet, nil, , slot0, nil, , slot3)
		else
			slot0:_httpGet()
		end
	end
end

function slot0.getHttpResult(slot0)
	return slot0._result
end

function slot0.getLangSize(slot0, slot1)
	if not slot0._result then
		return 0
	end

	if not slot0._result[slot1] or not slot2.res then
		return 0
	end

	for slot7, slot8 in ipairs(slot2.res) do
		slot3 = 0 + slot8.length
	end

	return slot3
end

function slot0._getUrl(slot0)
	slot1 = table.concat(slot0._langShortcuts, ",")
	slot2 = table.concat(slot0._langVersions, ",")
	slot3 = {}
	slot4, slot5 = GameUrlConfig.getOptionalUpdateUrl()
	slot6 = LoginModel.instance:getUseBackup() and slot5 or slot4
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
	slot4 = HotUpdateVoiceMgr.instance:getSupportVoiceLangs()

	table.insert(slot4, "res-HD")

	for slot9 = 1, #slot4 do
		if slot4[slot9] ~= GameConfig:GetDefaultVoiceShortcut() and string.nilorempty(slot1:GetLocalVersion(slot10)) then
			table.insert(slot2, slot10)

			if string.nilorempty(slot1.VoiceBranch) or not tonumber(slot14) then
				slot14 = 1

				logError("随包的语音分支错误：" .. slot1.VoiceBranch)
			end

			table.insert(slot3, slot14 .. ".0")
		end
	end

	return slot2, slot3
end

return slot0
