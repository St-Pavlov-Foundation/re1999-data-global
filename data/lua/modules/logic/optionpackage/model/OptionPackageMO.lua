module("modules.logic.optionpackage.model.OptionPackageMO", package.seeall)

slot0 = pureTable("OptionPackageMO")

function slot0.init(slot0, slot1, slot2)
	slot0.packeName = slot1 or ""
	slot0.lang = slot2 or ""
	slot0.id = OptionPackageHelper.formatLangPackName(slot0.lang, slot0.packeName)
	slot0.langPack = OptionPackageHelper.formatLangPackName(slot0.lang, slot0.packeName)
	slot0.nameLangId = "langtype_" .. slot0.lang
	slot0.size = 0
	slot0.localSize = 0
	slot0.localVersion = 0
	slot0.latestVersion = 0
	slot0.download_url = ""
	slot0.download_url_bak = ""
	slot0.download_res = {}
	slot0.downloadResList = {
		names = {},
		hashs = {},
		orders = {},
		lengths = {}
	}
	slot0._landPackInfo = nil
end

function slot0.setLocalVersion(slot0, slot1)
	slot0.localVersion = slot1
end

function slot0.setPackInfo(slot0, slot1)
	slot0._landPackInfo = slot1
	slot0.latestVersion = slot1.latest_ver and (string.splitToNumber(slot2, ".")[2] or 0) or 0
	slot0.download_url = slot1.download_url
	slot0.download_url_bak = slot1.download_url_bak
	slot0.download_res = {}

	tabletool.addValues(slot0.download_res, slot1.res)

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

function slot0.getPackInfo(slot0)
	return slot0._landPackInfo
end

function slot0.setLocalSize(slot0, slot1)
	slot0.localSize = slot1
end

function slot0.isNeedDownload(slot0)
	return slot0:getStatus() ~= OptionPackageEnum.UpdateState.AlreadyLatest
end

function slot0.getStatus(slot0)
	if slot0.latestVersion <= 0 then
		return OptionPackageEnum.UpdateState.NotDownload
	end

	if slot0.latestVersion <= slot0.localVersion or not slot0.download_res or #slot0.download_res < 1 then
		return OptionPackageEnum.UpdateState.AlreadyLatest
	end

	return OptionPackageController.instance:getPackItemState(slot0.id, slot0.latestVersion)
end

function slot0.hasLocalVersion(slot0)
	if slot0.localVersion and slot0.localVersion > 0 then
		return true
	end

	return false
end

return slot0
