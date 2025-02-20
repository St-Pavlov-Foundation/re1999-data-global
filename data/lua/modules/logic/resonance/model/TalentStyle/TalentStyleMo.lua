module("modules.logic.resonance.model.TalentStyle.TalentStyleMo", package.seeall)

slot0 = class("TalentStyleMo")

function slot0.ctor(slot0)
	slot0._styleCo = nil
	slot0._orginId = nil
	slot0._replaceId = nil
	slot0._styleId = nil
	slot0._isUse = false
	slot0._isSelect = false
	slot0._isNew = false
	slot0._isUnlock = false
	slot0._unlockPercent = 0
	slot0._hotUnlockStyle = nil
end

function slot0.setMo(slot0, slot1, slot2, slot3)
	slot0._styleCo = slot1
	slot0._orginId = slot2
	slot0._replaceId = slot3
	slot0._styleId = slot1.styleId
end

function slot0.isCanUnlock(slot0, slot1)
	return slot1 >= (slot0._styleCo and slot0._styleCo.level and slot0._styleCo.level or 0)
end

function slot0.onRefresh(slot0, slot1, slot2, slot3)
	slot0._isUse = slot1 == slot0._styleId
	slot0._isSelect = slot2 == slot0._styleId
	slot0._isUnlock = slot3
end

function slot0.setShowInfo(slot0)
end

function slot0.getStyleTag(slot0)
	if slot0._lastLangId ~= LangSettings.instance:getCurLang() then
		slot0._tagStr = nil
		slot0._name = nil
		slot0._lastLangId = slot1
	end

	if not slot0._name then
		slot0._name = slot0._styleCo.name
	end

	if string.nilorempty(slot0._tagStr) then
		slot0._tagStr = ""

		if not string.nilorempty(slot0._styleCo.tag) then
			for slot7, slot8 in ipairs(string.splitToNumber(slot2, "#")) do
				if string.nilorempty(slot0._tagStr) then
					slot0._tagStr = lua_character_attribute.configDict[slot8] and slot9.name or luaLang("talent_style_special_tag_" .. slot8)
				else
					slot0._tagStr = string.format("%s    %s", slot0._tagStr, slot10)
				end
			end
		end
	end

	return slot0._name, slot0._tagStr
end

function slot0.getStyleTagIcon(slot0)
	if (not slot0._growTagIcon or not slot0._nomalTagIcon) and slot0._styleCo.tagicon then
		if tonumber(slot1) and slot2 < 10 then
			slot1 = "0" .. slot2
		end

		slot0._growTagIcon = "fg_" .. slot1
		slot0._nomalTagIcon = "fz_" .. slot1
	end

	return slot0._growTagIcon, slot0._nomalTagIcon
end

function slot0.setNew(slot0, slot1)
	slot0._isNew = slot1 and slot0._styleId ~= 0
end

function slot0.setUnlockPercent(slot0, slot1)
	slot0._unlockPercent = slot1
end

function slot0.getUnlockPercent(slot0)
	return slot0._unlockPercent or 0
end

function slot0.setHotUnlockStyle(slot0, slot1)
	slot0._hotUnlockStyle = slot1
end

function slot0.isHotUnlock(slot0)
	return slot0._hotUnlockStyle
end

return slot0
