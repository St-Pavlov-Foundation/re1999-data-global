module("modules.logic.settings.model.SettingsVoicePackageModel", package.seeall)

slot0 = class("SettingsVoicePackageModel", BaseModel)

function slot0.onInit(slot0)
	if not HotUpdateVoiceMgr then
		return
	end

	slot1 = {}
	slot0._packInfoDic = {}
	slot2 = HotUpdateVoiceMgr.instance:getSupportVoiceLangs()

	table.insert(slot2, "res-HD")

	for slot7 = 1, #slot2 do
		slot8 = slot2[slot7]

		SettingsVoicePackageItemMo.New():setLang(slot8, SettingsVoicePackageController.instance:getLocalVersionInt(slot8))

		if slot8 == GameConfig:GetDefaultVoiceShortcut() then
			table.insert(slot1, 1, slot10)
		else
			table.insert(slot1, slot10)
		end

		slot0._packInfoDic[slot10.lang] = slot10
	end

	SettingsVoicePackageListModel.instance:setList(slot1)
end

function slot0.getPackInfo(slot0, slot1)
	return slot0._packInfoDic[slot1]
end

function slot0.getPackLangName(slot0, slot1)
	if slot0:getPackInfo(slot1) then
		return luaLang(slot2.nameLangId)
	else
		return ""
	end
end

function slot0.setDownloadProgress(slot0, slot1, slot2, slot3)
	if slot0:getPackInfo(slot1) then
		slot4:setLocalSize(slot2)
	end
end

function slot0.onDownloadSucc(slot0, slot1)
	if slot0:getPackInfo(slot1) then
		slot2:setLang(slot1, SettingsVoicePackageController.instance:getLocalVersionInt(slot1))
	end
end

function slot0.onDeleteVoicePack(slot0, slot1)
	if slot0:getPackInfo(slot1) then
		slot2:setLang(slot1, SettingsVoicePackageController.instance:getLocalVersionInt(slot1))
	end
end

function slot0.getLocalVoiceTypeList(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0._packInfoDic) do
		if slot6:hasLocalFile() then
			table.insert(slot1, slot5)
		end
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0
