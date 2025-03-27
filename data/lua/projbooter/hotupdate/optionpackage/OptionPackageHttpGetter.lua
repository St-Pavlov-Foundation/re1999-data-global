module("projbooter.hotupdate.optionpackage.OptionPackageHttpGetter", package.seeall)

slot0 = class("OptionPackageHttpGetter")
slot1 = 5
slot2 = 3
slot3 = 0
slot4 = {}

function slot0.ctor(slot0, slot1, slot2)
	uv0 = uv0 + 1
	slot0._httpId = uv0
	slot0._sourceType = slot1 or 2
	slot0._langPackList = {}

	tabletool.addValues(slot0._langPackList, slot2)
end

function slot0.getHttpId(slot0)
	return slot0._httpId
end

function slot0.getSourceType(slot0)
	return slot0._sourceType
end

function slot0.getLangPackList(slot0)
	return slot0._langPackList
end

function slot0.start(slot0, slot1, slot2)
	slot0._langShortcuts, slot0._langVersions = slot0:_getLangVersions()
	slot0._onGetFinish = slot1
	slot0._onGetFinishObj = slot2
	slot0._retryCount = 0
	slot0._useBackupUrl = false

	slot0:_httpGet()
end

function slot0.stop(slot0)
	if slot0._requestId then
		SLFramework.SLWebRequest.Instance:Stop(slot0._requestId)

		slot0._requestId = nil
	end
end

function slot0._httpGet(slot0)
	logNormal("OptionPackageHttpGetter url: " .. slot0:_getUrl())

	if uv0 and uv0[slot0._sourceType] then
		logNormal("OptionPackageHttpGetter url: " .. uv0[slot0._sourceType])
	end

	slot0._requestId = SLFramework.SLWebRequest.Instance:Get(slot1, slot0._onWebResponse, slot0, uv1)
end

function slot0._onWebResponse(slot0, slot1, slot2, slot3)
	if slot1 then
		if slot2 and slot2 ~= "" then
			logNormal("获取可选资源返回:" .. slot2)

			slot0._result = cjson.decode(slot2)
		else
			logNormal("获取可选资源返回空串")
		end

		slot0:_runCallblck(true)
	elseif uv0 <= slot0._retryCount then
		slot0._useBackupUrl = not slot0._useBackupUrl
		slot0._retryCount = 0

		slot0:_runCallblck(false)
	else
		slot0._retryCount = slot0._retryCount + 1

		slot0:_httpGet()
	end
end

function slot0._runCallblck(slot0, slot1)
	if slot0._onGetFinish == nil then
		return
	end

	slot0._onGetFinish = nil
	slot0._onGetFinishObj = nil

	slot0._onGetFinish(slot0._onGetFinishObj, slot1, slot0)
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
	slot6 = slot0._useBackupUrl and slot5 or slot4
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
	slot2 = {}
	slot3 = {}

	for slot9 = 1, #slot0._langPackList do
		table.insert(slot2, slot10)
		table.insert(slot3, slot0:_getBranchVersion() .. "." .. (string.nilorempty(SLFramework.GameUpdate.OptionalUpdate.Instance:GetLocalVersion(slot4[slot9])) and "0" or slot11))
	end

	return slot2, slot3
end

function slot0._getBranchVersion(slot0)
	if string.nilorempty(SLFramework.GameUpdate.OptionalUpdate.Instance.VoiceBranch) or not tonumber(slot2) then
		slot2 = 1

		logError("随包的语音分支错误：" .. slot1.VoiceBranch)
	end

	return slot2
end

return slot0
