module("modules.logic.settings.model.SettingsVoicePackageItemMo", package.seeall)

slot0 = pureTable("SettingsVoicePackageItemMo")

function slot0.ctor(slot0)
	slot0.size = 0
	slot0.localSize = 0
	slot0.lang = ""
	slot0.nameLangId = ""
	slot0.localVersion = 0
	slot0.latestVersion = 0
	slot0.download_url = ""
	slot0.download_url_bak = ""
	slot0.downloadResList = {
		names = {},
		hashs = {},
		orders = {},
		lengths = {}
	}
end

function slot0.setLang(slot0, slot1, slot2)
	slot0.lang = slot1
	slot0.nameLangId = "langtype_" .. slot1
	slot0.localVersion = slot2
end

function slot0.setLangInfo(slot0, slot1)
	slot0.latestVersion = slot1.latest_ver and (string.splitToNumber(slot2, ".")[2] or 0) or 0
	slot0.download_url = slot1.download_url
	slot0.download_url_bak = slot1.download_url_bak

	if slot1.res then
		slot4 = {}
		slot5 = {}
		slot6 = {}
		slot7 = {}

		for slot11, slot12 in ipairs(slot1.res) do
			table.insert(slot4, slot12.name)
			table.insert(slot5, slot12.hash)
			table.insert(slot6, slot12.order)
			table.insert(slot7, slot12.length)

			slot3 = 0 + slot12.length
		end

		slot0.downloadResList.names = slot4
		slot0.downloadResList.hashs = slot5
		slot0.downloadResList.orders = slot6
		slot0.downloadResList.lengths = slot7
		slot0.size = slot3
	end
end

function slot0.setLocalSize(slot0, slot1)
	slot0.localSize = slot1
end

function slot0.getStatus(slot0)
	if GameResMgr.IsFromEditorDir then
		return SettingsVoicePackageController.AlreadyLatest
	end

	if slot0.lang == GameConfig:GetDefaultVoiceShortcut() then
		return SettingsVoicePackageController.AlreadyLatest
	end

	if slot0.localVersion and slot0.localVersion > 0 then
		return SettingsVoicePackageController.AlreadyLatest
	end

	return SettingsVoicePackageController.instance:getPackItemState(slot0.lang, slot0.latestVersion)
end

function slot0.hasLocalFile(slot0)
	if slot0.lang == GameConfig:GetDefaultVoiceShortcut() then
		return SettingsVoicePackageController.AlreadyLatest
	end

	if slot0.localVersion and slot0.localVersion > 0 then
		return SettingsVoicePackageController.AlreadyLatest
	end

	return false
end

function slot0.needDownload(slot0)
	if GameResMgr.IsFromEditorDir then
		return false
	end

	if slot0.lang == GameConfig:GetDefaultVoiceShortcut() then
		return false
	end

	if slot0.localVersion and slot0.localVersion > 0 then
		return false
	end

	return slot0:getStatus() ~= SettingsVoicePackageController.AlreadyLatest
end

function slot0.getLeftSizeMBorGB(slot0)
	slot4 = "GB"

	if math.max(0, slot0.size - slot0.localSize) / 1073741824 < 0.1 then
		slot4 = "MB"

		if slot1 / 1048576 < 0.01 then
			slot3 = 0.01
		end
	end

	return slot3, math.max(0.01, slot0.size / slot2), slot4
end

function slot0.getLeftSizeMBNum(slot0)
	if math.max(0, slot0.size - slot0.localSize) / 1048576 < 0.01 then
		slot3 = 0.01
	end

	return slot3
end

function slot0.isCurVoice(slot0)
	return slot0.lang == GameConfig:GetCurVoiceShortcut()
end

return slot0
