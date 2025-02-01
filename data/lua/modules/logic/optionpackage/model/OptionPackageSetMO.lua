module("modules.logic.optionpackage.model.OptionPackageSetMO", package.seeall)

slot0 = pureTable("OptionPackageSetMO")

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.id = slot1 or ""
	slot0.packName = slot1 or ""
	slot0._packMOModel = slot3
	slot0._lang2IdDict = {}
	slot0._needDownloadLangs = {}
	slot0._neddDownLoadDict = {}
	slot0._allPackLangs = {}

	tabletool.addValues(slot0._needDownloadLangs, OptionPackageEnum.NeedPackLangList)
	tabletool.addValues(slot0._allPackLangs, OptionPackageEnum.NeedPackLangList)
	tabletool.addValues(slot0._allPackLangs, slot2)

	for slot7, slot8 in ipairs(slot0._allPackLangs) do
		slot0._lang2IdDict[slot8] = OptionPackageHelper.formatLangPackName(slot8, slot0.packName)
	end

	for slot7, slot8 in ipairs(slot0._needDownloadLangs) do
		slot0._neddDownLoadDict[slot8] = true
	end
end

function slot0.getPackageMO(slot0, slot1)
	if slot0._packMOModel and slot0._lang2IdDict[slot1] then
		return slot0._packMOModel:getById(slot0._lang2IdDict[slot1])
	end
end

function slot0.hasLocalVersion(slot0)
	for slot4, slot5 in ipairs(slot0._allPackLangs) do
		if slot0:getPackageMO(slot5) and slot6:hasLocalVersion() then
			return true
		end
	end

	return false
end

function slot0.getDownloadSize(slot0, slot1)
	for slot7, slot8 in ipairs(slot1) do
		if not slot0._neddDownLoadDict[slot8] and slot0:getPackageMO(slot8) then
			slot2 = 0 + slot9.size
			slot3 = 0 + slot9.localSize
		end
	end

	for slot7, slot8 in ipairs(slot0._needDownloadLangs) do
		if slot0:getPackageMO(slot8) then
			slot2 = slot2 + slot9.size
			slot3 = slot3 + slot9.localSize
		end
	end

	return slot2, slot3
end

function slot0.isNeedDownload(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._needDownloadLangs) do
		if slot0:_checkDownloadLang(slot6) then
			return true
		end
	end

	if slot1 and #slot1 > 0 then
		for slot5, slot6 in ipairs(slot1) do
			if slot0:_checkDownloadLang(slot6) then
				return true
			end
		end
	end

	return false
end

function slot0.getDownloadInfoListTb(slot0, slot1)
	for slot6, slot7 in ipairs(slot0._needDownloadLangs) do
		slot0:_getDownloadInfoTb(slot7, {})
	end

	if slot1 and #slot1 > 0 then
		for slot6, slot7 in ipairs(slot1) do
			if not slot0._neddDownLoadDict[slot7] then
				slot0:_getDownloadInfoTb(slot7, slot2)
			end
		end
	end

	return slot2
end

function slot0._checkDownloadLang(slot0, slot1)
	if slot0:getPackageMO(slot1) and slot2:isNeedDownload() then
		return true
	end

	return false
end

function slot0._getDownloadInfoTb(slot0, slot1, slot2)
	slot2 = slot2 or {}

	if slot0:getPackageMO(slot1) and slot3:isNeedDownload() and slot3:getPackInfo() then
		slot2[slot3.langPack] = slot4
	end

	return slot2
end

return slot0
