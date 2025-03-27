module("projbooter.hotupdate.HotUpdateOptionPackageMgr", package.seeall)

slot0 = class("HotUpdateOptionPackageMgr")
slot0.EnableEditorDebug = false
slot1 = "HotUpdateOptionPackageMgr_OptionPackageNamesKey"

function slot0.init(slot0)
	slot0._optionalUpdateInst = SLFramework.GameUpdate.OptionalUpdate.Instance

	slot0._optionalUpdateInst:Init()

	slot0._downloader = OptionPackageDownloader.New()
	slot0._httpWorker = OptionPackageHttpWorker.New()
end

function slot0.getSupportVoiceLangs(slot0)
	if not tabletool.indexOf(HotUpdateVoiceMgr.instance:getSupportVoiceLangs(), GameConfig:GetDefaultVoiceShortcut()) then
		table.insert(slot1, 1, slot2)
	end

	logNormal("\n语言：" .. slot2 .. "\n排序：" .. table.concat(slot1, ","))

	return slot1
end

function slot0.getHotUpdateLangPacks(slot0)
	if not slot0:getPackageNameList() or #slot1 < 1 then
		return nil, 
	end

	slot2 = {
		"res",
		"media"
	}

	tabletool.addValues(slot2, slot0:getHotUpdateVoiceLangs())

	return slot0:formatLangPackList(slot2, slot1)
end

function slot0.getHotUpdateVoiceLangs(slot0)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0:getSupportVoiceLangs()) do
		if slot0:isNeedDownloadVoiceLang(slot7) then
			table.insert(slot2, 1, slot7)
		end
	end

	return slot2
end

function slot0.isNeedDownloadVoiceLang(slot0, slot1)
	if HotUpdateVoiceMgr.ForceSelect and HotUpdateVoiceMgr.ForceSelect[slot1] then
		return true
	end

	if not string.nilorempty(slot0._optionalUpdateInst:GetLocalVersion(slot1)) then
		return true
	end

	if GameConfig:GetDefaultVoiceShortcut() == slot1 then
		return true
	end

	return false
end

function slot0.getPackageNameList(slot0)
	if not string.nilorempty(UnityEngine.PlayerPrefs.GetString(uv0, "")) then
		return string.split(slot1, "#")
	end

	return {}
end

function slot0.savePackageNameList(slot0, slot1)
	slot2 = ""

	if slot1 and #slot1 > 0 then
		slot2 = table.concat(slot1, "#")
	end

	UnityEngine.PlayerPrefs.SetString(uv0, slot2)
	UnityEngine.PlayerPrefs.Save()
end

function slot0.showDownload(slot0, slot1, slot2, slot3)
	if not slot3 or not slot3:getHttpGetterList() or #slot4 < 1 then
		slot1(slot2)

		return
	end

	slot0._adppter = slot3

	slot0._adppter:setDownloder(slot0._downloader, slot0)

	if VersionValidator.instance:isInReviewing() then
		slot1(slot2)
	elseif GameResMgr.IsFromEditorDir and not uv0.EnableEditorDebug then
		slot1(slot2)
	else
		slot0._httpWorker:start(slot4, slot1, slot2)
	end
end

function slot0.startDownload(slot0, slot1, slot2)
	if VersionValidator.instance:isInReviewing() and not uv0.EnableEditorDebug then
		slot1(slot2)
	elseif GameResMgr.IsFromEditorDir and not uv0.EnableEditorDebug then
		slot1(slot2)
	elseif BootNativeUtil.isIOS() and HotUpdateMgr.instance:hasHotUpdate() then
		logNormal("热更新紧接着语音更新，延迟开始")
		Timer.New(function ()
			logNormal("独立资源包更新开始")
			uv0._downloader:start(uv0:getHttpResult(), uv1, uv2, uv0._adppter)
		end, 1.5):Start()
	else
		slot0._downloader:start(slot0:getHttpResult(), slot1, slot2, slot0._adppter)
	end
end

function slot0.getHttpResult(slot0)
	return slot0._httpWorker:getHttpResult()
end

function slot0.getNeedDownloadSize(slot0)
	if not slot0:getHttpResult() then
		return 0
	end

	slot2 = 0

	for slot6, slot7 in pairs(slot1) do
		if slot7.res then
			slot9 = {}
			slot10 = {}
			slot11 = {}
			slot12 = {}

			for slot16, slot17 in ipairs(slot8) do
				table.insert(slot9, slot17.name)
				table.insert(slot10, slot17.hash)
				table.insert(slot11, slot17.order)
				table.insert(slot12, slot17.length)

				slot2 = slot2 + slot17.length
			end

			slot0._optionalUpdateInst:InitBreakPointInfo(slot9, slot10, slot11, slot12)

			slot2 = slot2 - tonumber(slot0._optionalUpdateInst:GetRecvSize())
		end
	end

	return slot2
end

function slot0.formatLangPackList(slot0, slot1, slot2)
	slot3 = {}

	if not slot2 or #slot2 < 1 then
		tabletool.addValues(slot3, slot1)

		return slot3
	end

	for slot7, slot8 in ipairs(slot2) do
		for slot12, slot13 in ipairs(slot1) do
			table.insert(slot3, slot0:formatLangPackName(slot13, slot8))
		end
	end

	return slot3
end

function slot0.formatLangPackName(slot0, slot1, slot2)
	if string.nilorempty(slot2) then
		return slot1
	end

	return string.format("%s-%s", slot1, slot2)
end

function slot0.stop(slot0)
	slot0._downloader:cancelDownload()
end

slot0.instance = slot0.New()

return slot0
