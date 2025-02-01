module("modules.logic.seasonver.act123.utils.Season123EquipMetaUtils", package.seeall)

slot0 = class("Season123EquipMetaUtils")
slot0.attrKey = {
	atk = "attack",
	def = "defense",
	dropDmg = "dropDmg",
	cri = "cri",
	revive = "revive",
	recri = "recri",
	mdef = "mdefense",
	defenseIgnore = "defenseIgnore",
	addDmg = "addDmg",
	absorb = "absorb",
	hp = "hp",
	criDmg = "criDmg",
	heal = "heal",
	criDef = "criDef",
	normalSkillRate = "normalSkillRate",
	clutch = "clutch"
}

function slot0.getEquipPropsDescStr(slot0)
	slot1 = ""

	if Season123Config.instance:getSeasonEquipCo(slot0) then
		for slot7, slot8 in ipairs(uv0.getEquipPropsStrList(slot2.attrId)) do
			slot1 = string.nilorempty(slot1) and slot1 .. slot8 or slot1 .. slot8 .. "\n" .. slot8
		end

		for slot8, slot9 in ipairs(uv0.getSkillEffectStrList(slot2)) do
			slot10 = string.format(luaLang("season_effect_desc_template"), slot9)
			slot1 = string.nilorempty(slot1) and slot1 .. slot10 or slot1 .. slot10 .. "\n" .. slot10
		end

		if string.nilorempty(slot1) then
			slot1 = slot1 .. "\n"
		end

		return slot1
	else
		logError(string.format("can't find season equip config, id = [%s]", slot0))
	end

	return slot1
end

slot0.PropValueColorPattern = "<color=#d2c197>"

function slot0.getEquipPropsStrList(slot0, slot1)
	slot2 = {}
	slot3 = nil

	if slot0 then
		slot3 = Season123Config.instance:getSeasonEquipAttrCo(slot0)
	end

	if not slot3 then
		return slot2
	end

	for slot7, slot8 in pairs(uv0.attrKey) do
		if slot3[slot7] and slot9 ~= 0 and HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(slot8)) then
			slot12 = slot11.name
			slot13 = slot11.showType == 1 and "%%" or ""
			slot14 = slot11.showType == 1 and 10 or 1
			slot15 = uv0.PropValueColorPattern

			if slot1 then
				slot15 = ""
			end

			table.insert(slot2, (slot9 <= 0 or GameUtil.getSubPlaceholderLuaLang(luaLang("season123_attr_up"), {
				slot12,
				slot15,
				tostring(slot9 / slot14),
				slot13
			})) and GameUtil.getSubPlaceholderLuaLang(luaLang("season123_attr_down"), {
				slot12,
				slot15,
				tostring(-slot9 / slot14),
				slot13
			}))
		end
	end

	return slot2
end

function slot0.getSkillEffectStrList(slot0)
	slot2 = {}

	if slot0.skillId then
		slot3 = nil

		if slot0.isMain == Activity123Enum.isMainRole then
			for slot8, slot9 in ipairs(string.split(slot1, "|")) do
				if #string.splitToNumber(slot9, "#") >= 2 and slot10[2] ~= nil then
					table.insert({}, slot10[2])
				end
			end
		else
			slot3 = string.splitToNumber(slot1, "#")
		end

		for slot7, slot8 in ipairs(slot3) do
			if FightConfig.instance:getSkillEffectCO(slot8) then
				table.insert(slot2, FightConfig.instance:getSkillEffectDesc(nil, slot9))
			else
				logError(string.format("can't find skill config ID = [%s]", slot8))
			end
		end
	end

	return slot2
end

function slot0.isMainRoleCard(slot0)
	return slot0.isMain == Activity123Enum.isMainRole
end

function slot0.getCurSeasonEquipCount(slot0)
	if Season123Model.instance:getActInfo(Season123Model.instance:getCurSeasonId()) ~= nil then
		return uv0.getEquipCount(slot1, slot0)
	end

	return 0
end

slot0.Text_Career_Color_Bright_Bg = {
	["0"] = "#252525",
	["1"] = "#ac5320",
	["2"] = "#324bb6",
	["5"] = "#804885",
	["3"] = "#27682e",
	["4"] = "#9f342c"
}

function slot0.getCareerColorBrightBg(slot0)
	if Season123Config.instance:getSeasonEquipCo(slot0) and slot1.career then
		return uv0.Text_Career_Color_Bright_Bg[slot1.career] or uv0.Text_Career_Color_Bright_Bg["0"]
	end

	return uv0.Text_Career_Color_Bright_Bg["0"]
end

slot0.No_Effect_Alpha = "66"
slot0.Text_Career_Color_Dark_Bg = {
	["0"] = "#cac8c5",
	["1"] = "#e99b56",
	["2"] = "#6384e5",
	["5"] = "#804885",
	["3"] = "#65b96f",
	["4"] = "#d97373"
}

function slot0.getCareerColorDarkBg(slot0)
	if Season123Config.instance:getSeasonEquipCo(slot0) and slot1.career then
		return uv0.Text_Career_Color_Dark_Bg[slot1.career] or uv0.Text_Career_Color_Dark_Bg["0"]
	end

	return uv0.Text_Career_Color_Dark_Bg["0"]
end

function slot0.getEquipCount(slot0, slot1)
	if Season123Model.instance:getAllItemMo(slot0) then
		for slot7, slot8 in pairs(slot2) do
			if slot8.itemId == slot1 then
				slot3 = 0 + 1
			end

			return slot3
		end
	end

	return 0
end

function slot0.applyIconOffset(slot0, slot1, slot2)
	if Season123Config.instance:getSeasonEquipCo(slot0) then
		slot4 = 0
		slot5 = 0
		slot6 = 1
		slot7 = 26
		slot8 = -180
		slot9 = 0.76

		if not string.nilorempty(slot3.iconOffset) then
			slot10 = string.splitToNumber(slot3.iconOffset, "#")
			slot6 = slot10[3]
			slot5 = slot10[2]
			slot4 = slot10[1]
		end

		if not string.nilorempty(slot3.signOffset) then
			slot10 = string.splitToNumber(slot3.signOffset, "#")
			slot9 = slot10[3]
			slot8 = slot10[2]
			slot7 = slot10[1]
		end

		if slot1 then
			transformhelper.setLocalScale(slot1.transform, slot6, slot6, 1)
			recthelper.setAnchor(slot1.transform, slot4, slot5)
		end

		if slot2 then
			transformhelper.setLocalScale(slot2.transform, slot9, slot9, 1)
			recthelper.setAnchor(slot2.transform, slot7, slot8)
		end
	end
end

function slot0.isBanActivity(slot0, slot1)
	return slot0.activityId ~= slot1
end

return slot0
