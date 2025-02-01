module("projbooter.hotupdate.HotUpdateVoiceMgr", package.seeall)

slot0 = class("HotUpdateVoiceMgr")
slot0.EnableEditorDebug = false
slot1 = 50001
slot0.IsGuoFu = false
slot0.LangEn = "en"
slot0.LangZh = "zh"
slot0.LangSortOrderDefault = {
	jp = 3,
	kr = 4,
	zh = 2,
	en = 1
}
slot0.LangSortOrderDict = {
	en = {
		jp = 2,
		kr = 4,
		zh = 3,
		en = 1
	},
	tw = {
		jp = 2,
		kr = 4,
		zh = 3,
		en = 1
	},
	jp = {
		jp = 1,
		kr = 4,
		zh = 3,
		en = 2
	},
	kr = {
		kr = 1,
		jp = 4,
		zh = 3,
		en = 2
	}
}
slot0.ForceSelect = {
	[slot0.LangEn] = true,
	[slot0.LangZh] = true
}

function slot0.init(slot0)
	slot0._optionalUpdateInst = SLFramework.GameUpdate.OptionalUpdate.Instance

	slot0._optionalUpdateInst:Init()

	slot0._httpGetter = VoiceHttpGetter.New()
	slot0._downloader = VoiceDownloader.New()
	uv0.IsGuoFu = tonumber(SDKMgr.instance:getGameId()) == uv1

	if not uv0.IsGuoFu then
		uv0.ForceSelect = {}
	end
end

slot2, slot3 = nil
slot4 = {}

function slot0.getSupportVoiceLangs(slot0)
	slot3 = {}
	uv0 = GameConfig:GetDefaultVoiceShortcut()
	uv1 = uv2.LangSortOrderDict[GameConfig:GetDefaultLangShortcut()] or uv2.LangSortOrderDefault

	for slot8 = 0, GameConfig:GetSupportedVoiceShortcuts().Length - 1 do
		slot9 = slot1[slot8]

		table.insert(slot3, slot9)

		uv3[slot9] = slot8 + 1
	end

	table.sort(slot3, uv2._sortLang)

	slot1 = nil

	return slot3
end

function slot0._sortLang(slot0, slot1)
	if slot0 == uv0 then
		return true
	elseif slot1 == uv0 then
		return false
	else
		if (uv1[slot0] or 999) ~= (uv1[slot1] or 999) then
			return slot2 < slot3
		end

		return uv2[slot0] < uv2[slot1]
	end
end

function slot0.showDownload(slot0, slot1, slot2)
	if VersionValidator.instance:isInReviewing() then
		slot1(slot2)
	elseif GameResMgr.IsFromEditorDir and not uv0.EnableEditorDebug then
		slot1(slot2)
	else
		slot0._httpGetter:start(slot1, slot2)
	end
end

function slot0.startDownload(slot0, slot1, slot2)
	if VersionValidator.instance:isInReviewing() then
		slot1(slot2)
	elseif GameResMgr.IsFromEditorDir and not uv0.EnableEditorDebug then
		slot1(slot2)
	elseif BootNativeUtil.isIOS() and HotUpdateMgr.instance:hasHotUpdate() then
		logNormal("热更新紧接着语音更新，延迟开始")
		Timer.New(function ()
			logNormal("语音更新开始")
			uv0._downloader:start(uv1, uv2)
		end, 1.5):Start()
	else
		slot0._downloader:start(slot1, slot2)
	end
end

function slot0.getHttpResult(slot0)
	return slot0._httpGetter:getHttpResult()
end

function slot0.getLangSize(slot0, slot1)
	if not slot0:getHttpResult() then
		return 0
	end

	if not slot2[slot1] or not slot3.res then
		return 0
	end

	for slot8, slot9 in ipairs(slot3.res) do
		slot4 = 0 + slot9.length
	end

	return slot4
end

function slot0.getTotalSize(slot0)
	if not slot0:getHttpResult() then
		return 0
	end

	slot3 = 0

	for slot8, slot9 in pairs(slot1) do
		slot10 = false

		if slot9.res and ((not BootVoiceView.instance:isFirstDownloadDone() or not string.nilorempty(slot0._optionalUpdateInst:GetLocalVersion(slot8))) and tabletool.indexOf(BootVoiceView.instance:getDownloadChoices(), slot8)) then
			for slot14, slot15 in ipairs(slot9.res) do
				slot3 = slot3 + slot15.length
			end
		end
	end

	return slot3
end

function slot0.getNeedDownloadSize(slot0)
	if not slot0:getHttpResult() then
		return 0
	end

	slot2 = slot0:getTotalSize()

	for slot6, slot7 in pairs(slot1) do
		if slot0:getDownloadList(slot6) then
			slot9 = {}
			slot10 = {}
			slot11 = {}
			slot12 = {}

			for slot16, slot17 in ipairs(slot8) do
				table.insert(slot9, slot17.name)
				table.insert(slot10, slot17.hash)
				table.insert(slot11, slot17.order)
				table.insert(slot12, slot17.length)
			end

			slot0._optionalUpdateInst:InitBreakPointInfo(slot9, slot10, slot11, slot12)

			slot2 = slot2 - tonumber(slot0._optionalUpdateInst:GetRecvSize())
		end
	end

	return slot2
end

function slot0.getDownloadUrl(slot0, slot1)
	if not slot0:getHttpResult() then
		return
	end

	if slot2[slot1] then
		return slot3.download_url, slot3.download_url_bak
	end
end

function slot0.getDownloadList(slot0, slot1)
	if not slot0:getHttpResult() then
		return
	end

	if #slot2[slot1].res > 0 then
		slot4 = {}

		for slot8, slot9 in ipairs(slot3.res) do
			table.insert(slot4, {
				latest_ver = slot3.latest_ver,
				name = slot9.name,
				hash = slot9.hash,
				order = slot9.order,
				length = slot9.length
			})
		end

		table.sort(slot4, uv0._sortByOrder)

		return slot4
	end
end

function slot0.stop(slot0)
	slot0._downloader:cancelDownload()
end

function slot0.getAllLangDownloadList(slot0)
	slot1 = BootVoiceView.instance:isFirstDownloadDone()
	slot2 = BootVoiceView.instance:getDownloadChoices()

	if not slot0:getHttpResult() then
		return {}
	end

	slot4 = {}

	for slot9, slot10 in pairs(slot3) do
		slot11 = false

		if #slot10.res > 0 and (slot1 and (not string.nilorempty(slot0._optionalUpdateInst:GetLocalVersion(slot9)) or GameConfig:GetCurVoiceShortcut() == slot9) or tabletool.indexOf(slot2, slot9)) then
			slot12 = {}

			for slot16, slot17 in ipairs(slot10.res) do
				table.insert(slot12, {
					latest_ver = slot10.latest_ver,
					name = slot17.name,
					hash = slot17.hash,
					order = slot17.order,
					length = slot17.length
				})
			end

			table.sort(slot12, uv0._sortByOrder)

			slot4[slot9] = slot12
		end
	end

	return slot4
end

function slot0._sortByOrder(slot0, slot1)
	return slot0.order < slot1.order
end

slot0.instance = slot0.New()

return slot0
