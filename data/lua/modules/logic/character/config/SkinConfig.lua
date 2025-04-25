module("modules.logic.character.config.SkinConfig", package.seeall)

slot0 = class("SkinConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._skinConfig = nil
	slot0._skinStoreTagConfig = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"skin",
		"skin_special_act",
		"skin_ui_effect",
		"skin_ui_bloom",
		"skin_monster_scale",
		"skin_monster_hide_buff_effect",
		"skin_store_tag",
		"skin_fullscreen_effect"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "skin" then
		slot0._skinConfig = slot2

		slot0:_initSkinConfig()
	elseif slot1 == "skin_store_tag" then
		slot0._skinStoreTagConfig = slot2
	end
end

function slot0._initSkinConfig(slot0)
	if not slot0._characterSkinCoList then
		slot0._characterSkinCoList = {}
		slot0._live2dSkinDic = {}
		slot0._skinFolderNameMap = {}
		slot0._skinStoreGoodsDict = {}

		for slot5, slot6 in ipairs(slot0._skinConfig.configList) do
			if not string.nilorempty(slot6.live2d) and not string.nilorempty(slot6.verticalDrawing) then
				slot0._live2dSkinDic[slot6.verticalDrawing] = slot6.live2d
			end

			if not string.nilorempty(slot6.folderName) then
				if not string.nilorempty(slot6.live2d) then
					slot0:_setFolderName(slot6.live2d, slot6.folderName)
				elseif not string.nilorempty(slot6.verticalDrawing) then
					slot0:_setFolderName(slot6.verticalDrawing, slot6.folderName)
				end
			end

			if not slot0._characterSkinCoList[slot6.characterId] then
				slot0._characterSkinCoList[slot6.characterId] = {}
			end

			table.insert(slot7, slot6)

			if slot6.skinStoreId ~= 0 then
				slot0._skinStoreGoodsDict[slot6.skinStoreId] = slot6.id
			end
		end
	end
end

function slot0.isSkinStoreGoods(slot0, slot1)
	if slot0._skinStoreGoodsDict then
		return slot0._skinStoreGoodsDict[slot1] ~= nil, slot0._skinStoreGoodsDict[slot1]
	end
end

function slot0._setFolderName(slot0, slot1, slot2)
	slot0:_checkFolderName(slot1)

	slot0._skinFolderNameMap[slot1] = slot2

	if not string.match(slot2, "v%d+a%d+_") then
		logError(string.format("SkinConfig folderName:%s 不符合版本格式", slot2))
	end
end

function slot0._checkFolderName(slot0, slot1)
	if slot0._skinFolderNameMap[slot1] then
		logError(string.format("SkinConfig repeat folderName:%s,resName:%s", slot0._skinFolderNameMap[slot1], slot1))
	end
end

function slot0.getFolderName(slot0, slot1)
	return slot0._skinFolderNameMap[slot1] or slot1
end

function slot0.getLive2dSkin(slot0, slot1)
	return slot0._live2dSkinDic[slot1]
end

function slot0.getSkinCo(slot0, slot1)
	return slot0._skinConfig.configDict[slot1]
end

function slot0.getAllSkinCoList(slot0)
	return slot0._skinConfig.configList
end

function slot0.getSkinOffset(slot0, slot1, slot2)
	if string.nilorempty(slot1) then
		if slot2 then
			return slot2, true
		end

		return {
			0,
			0,
			1
		}, true
	end

	return string.splitToNumber(slot1, "#"), false
end

function slot0.getAfterRelativeOffset(slot0, slot1, slot2)
	slot4, slot5 = slot0:getSkinOffset(CommonConfig.instance:getConstStr(slot1))

	if slot5 then
		return slot2
	end

	slot2[1] = slot2[1] + slot4[1]
	slot2[2] = slot2[2] + slot4[2]
	slot2[3] = slot2[3] + slot4[3]

	return slot2
end

function slot0.getCharacterSkinCoList(slot0, slot1)
	return slot0._characterSkinCoList[slot1]
end

function slot0.getSkinStoreTagConfig(slot0, slot1)
	return slot0._skinStoreTagConfig.configDict[slot1]
end

slot0.instance = slot0.New()

return slot0
