module("modules.logic.optionpackage.model.OptionPackageModel", package.seeall)

slot0 = class("OptionPackageModel", BaseModel)

function slot0.ctor(slot0)
	slot0._setMOModel = BaseModel.New()
	slot0._packMOModel = BaseModel.New()
	slot0._initialized = false
	slot0._voiceLangsDict = {}

	uv0.super.ctor(slot0)
end

function slot0.onInit(slot0)
	if not HotUpdateVoiceMgr then
		return
	end

	slot0._initialized = true
	slot1 = OptionPackageEnum.PackageNameList or {}
	slot3 = HotUpdateVoiceMgr.ForceSelect or {}
	slot4 = GameConfig:GetDefaultVoiceShortcut()

	for slot8, slot9 in ipairs(slot0:getSupportVoiceLangs()) do
		slot10 = {}
		slot0._voiceLangsDict[slot9] = slot10

		table.insert(slot10, slot9)

		for slot14, slot15 in pairs(slot3) do
			if not tabletool.indexOf(slot10, slot14) then
				table.insert(slot10, slot14)
			end
		end

		if not tabletool.indexOf(slot10, slot4) then
			table.insert(slot10, slot4)
		end
	end

	slot5 = {}

	for slot9, slot10 in ipairs(slot1) do
		slot11 = OptionPackageSetMO.New()

		slot11:init(slot10, slot2, slot0._packMOModel)
		table.insert(slot5, slot11)
	end

	slot0._setMOModel:setList(slot5)
	slot0._packMOModel:setList({})
end

function slot0.getSupportVoiceLangs(slot0)
	if not slot0._supportVoiceLangList then
		slot0._supportVoiceLangList = {}

		tabletool.addValues(slot0._supportVoiceLangList, HotUpdateVoiceMgr and HotUpdateVoiceMgr.instance:getSupportVoiceLangs())
	end

	return slot0._supportVoiceLangList
end

function slot0.reInit(slot0)
	slot0._localPackSetNameList = nil
end

function slot0.setOpenInfo(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		if slot0:getPackageMO(slot5) then
			slot7:setLangInfo(slot6)
		end
	end
end

function slot0.getPackageMO(slot0, slot1)
	return slot0._packMOModel:getById(slot1)
end

function slot0.getPackageMOList(slot0)
	return slot0._packMOModel:getList()
end

function slot0.addPackageMO(slot0, slot1)
	slot0._packMOModel:addAtLast(slot1)
end

function slot0.addPackageMOList(slot0, slot1)
	slot0._packMOModel:addList(slot1)
end

function slot0.getPackageSetMO(slot0, slot1)
	return slot0._setMOModel:getById(slot1)
end

function slot0.getPackageSetMOList(slot0)
	return slot0._setMOModel:getList()
end

function slot0.setDownloadProgress(slot0, slot1, slot2, slot3)
	if slot0:getPackageMO(slot1) then
		slot4:setLocalSize(slot2)
	end
end

function slot0.updateLocalVersion(slot0, slot1)
	if slot0:getPackageMO(slot1) then
		slot2:setLocalVersion(OptionPackageController.instance:getLocalVersionInt(slot1))
	end
end

function slot0.onDownloadSucc(slot0, slot1)
	slot0:updateLocalVersion(slot1)
end

function slot0.onDeleteVoicePack(slot0, slot1)
	slot0:updateLocalVersion(slot1)
end

function slot0.getNeedVoiceLangList(slot0, slot1)
	return slot0._voiceLangsDict[slot1 or GameConfig:GetCurVoiceShortcut()]
end

function slot0.addLocalPackSetName(slot0, slot1)
	if not slot0._initialized then
		return
	end

	if not OptionPackageEnum.HasPackageNameDict[slot1] then
		return
	end

	if not tabletool.indexOf(HotUpdateOptionPackageMgr.instance:getPackageNameList(), slot1) then
		table.insert(slot2, slot1)
		HotUpdateOptionPackageMgr.instance:savePackageNameList(slot2)
	end
end

function slot0.saveLocalPackSetName(slot0)
	if not slot0._initialized then
		return
	end

	slot1 = slot0:_getLocalSetNameList()

	for slot6, slot7 in ipairs(slot0:getPackageSetMOList()) do
		slot8 = slot7.packName

		if slot7:hasLocalVersion() and not tabletool.indexOf(slot1, slot8) then
			table.insert(slot1, slot8)
		end
	end

	HotUpdateOptionPackageMgr.instance:savePackageNameList(slot1)
end

function slot0._getLocalSetNameList(slot0)
	if not slot0._localPackSetNameList then
		slot0._localPackSetNameList = HotUpdateOptionPackageMgr.instance:getPackageNameList() or {}
	end

	return slot0._localPackSetNameList
end

slot0.instance = slot0.New()

return slot0
