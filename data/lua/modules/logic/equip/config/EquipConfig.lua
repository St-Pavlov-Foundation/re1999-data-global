module("modules.logic.equip.config.EquipConfig", package.seeall)

slot0 = class("EquipConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"equip",
		"equip_strengthen",
		"equip_strengthen_cost",
		"equip_break_cost",
		"equip_const",
		"equip_skill",
		"equip_tag",
		"equip_trial",
		"equip_break_attr"
	}
end

function slot0.onInit(slot0)
end

slot0.MaxLevel = 60
slot0.EquipBreakAttrIdToFieldName = {
	[CharacterEnum.AttrId.Attack] = "attack",
	[CharacterEnum.AttrId.Hp] = "hp",
	[CharacterEnum.AttrId.Defense] = "def",
	[CharacterEnum.AttrId.Mdefense] = "mdef",
	[CharacterEnum.AttrId.Cri] = "cri",
	[CharacterEnum.AttrId.Recri] = "recri",
	[CharacterEnum.AttrId.CriDmg] = "criDmg",
	[CharacterEnum.AttrId.CriDef] = "criDef",
	[CharacterEnum.AttrId.AddDmg] = "addDmg",
	[CharacterEnum.AttrId.DropDmg] = "dropDmg",
	[CharacterEnum.AttrId.Heal] = "heal",
	[CharacterEnum.AttrId.Revive] = "revive",
	[CharacterEnum.AttrId.DefenseIgnore] = "defenseIgnore",
	[CharacterEnum.AttrId.Absorb] = "absorb",
	[CharacterEnum.AttrId.NormalSkillRate] = "normalSkillRate",
	[CharacterEnum.AttrId.Clutch] = "clutch"
}

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "equip_const" then
		slot0._baseExpDic = {}
		slot4, slot5, slot6 = nil
		slot10 = "|"

		for slot10, slot11 in ipairs(string.split(lua_equip_const.configDict[1].value, slot10)) do
			slot4 = string.split(slot11, "#")
			slot0._baseExpDic[tonumber(slot4[1])] = tonumber(slot4[2])
		end

		slot10 = "|"

		for slot10, slot11 in ipairs(string.split(lua_equip_const.configDict[2].value, slot10)) do
			slot4 = string.split(slot11, "#")
			slot0._baseExpDic[tonumber(slot4[1])] = tonumber(slot4[2])
		end

		slot0._expTransfer = {}
		slot8 = nil

		for slot12, slot13 in ipairs(string.split(lua_equip_const.configDict[3].value, "|")) do
			slot8 = string.splitToNumber(slot13, "#")
			slot0._expTransfer[slot8[1]] = slot8[2] / 100
		end

		slot0._equipBackpackMaxCount = tonumber(lua_equip_const.configDict[13].value)
		slot0._equipNotShowRefineRare = tonumber(lua_equip_const.configDict[16].value)
		slot9 = string.splitToNumber(lua_equip_const.configDict[17].value, "#")
		slot0.equipDecomposeEquipId = slot9[2]
		slot0.equipDecomposeEquipUnitCount = slot9[3]
	end

	if slot1 == "equip_break_cost" then
		slot0._equipBreakCostRareList = {}
		slot0._equipMaxBreakLv = {}

		for slot6, slot7 in ipairs(lua_equip_break_cost.configList) do
			if not slot0._equipBreakCostRareList[slot7.rare] then
				slot0._equipBreakCostRareList[slot7.rare] = {}
			end

			table.insert(slot0._equipBreakCostRareList[slot7.rare], slot7)

			if not slot0._equipMaxBreakLv[slot7.rare] then
				slot0._equipMaxBreakLv[slot7.rare] = 0
			end

			if slot0._equipMaxBreakLv[slot7.rare] < slot7.breakLevel then
				slot0._equipMaxBreakLv[slot7.rare] = slot7.breakLevel
			end
		end

		for slot6, slot7 in pairs(slot0._equipBreakCostRareList) do
			table.sort(slot7, function (slot0, slot1)
				return slot0.breakLevel < slot1.breakLevel
			end)
		end
	end

	if slot1 == "equip_strengthen_cost" and not slot0._strengthenCostQualityList then
		slot0._strengthenCostQualityList = {}

		for slot6, slot7 in ipairs(lua_equip_strengthen_cost.configList) do
			slot8 = slot0._strengthenCostQualityList[slot7.rare] or {}
			slot0._strengthenCostQualityList[slot7.rare] = slot8

			table.insert(slot8, slot7)
		end
	end

	if slot1 == "equip_skill" then
		slot0._equipSkillList = {}
		slot0.equip_skill_dic = {}

		for slot6, slot7 in ipairs(lua_equip_skill.configList) do
			slot0._equipSkillList[slot7.id] = slot0._equipSkillList[slot7.id] or {}
			slot0._equipSkillList[slot7.id][slot7.skillLv] = slot7
			slot0.equip_skill_dic[slot7.skill] = slot7
			slot0.equip_skill_dic[slot7.skill2] = slot7
		end
	end
end

function slot0.getOneLevelEquipProduceExp(slot0, slot1)
	if slot0._baseExpDic[slot1] == nil then
		logError("not found base equip exp : " + tostring(slot1))

		return 0
	end

	return slot2
end

function slot0.getCurrentBreakLevelMaxLevel(slot0, slot1)
	return slot0:_getBreakLevelMaxLevel(slot1.config.rare, slot1.breakLv)
end

function slot0.getNextBreakLevelMaxLevel(slot0, slot1)
	return slot0:_getBreakLevelMaxLevel(slot1.config.rare, slot1.breakLv + 1)
end

function slot0._getBreakLevelMaxLevel(slot0, slot1, slot2)
	if not slot0._equipBreakCostRareList[slot1] then
		logError(string.format("rare '%s' not config break cost", slot1))

		return uv0.MaxLevel
	end

	for slot7 = 1, #slot3 do
		if slot3[slot7].breakLevel == slot2 then
			return slot3[slot7].level
		end
	end

	logWarn(string.format("rare '%s',breakLevel '%s' not config break cost", slot1, slot2))

	return uv0.MaxLevel
end

function slot0.getEquipRefineLvMax(slot0)
	slot0.equip_refine_lv_max = slot0.equip_refine_lv_max or tonumber(lua_equip_const.configDict[15].value)

	return slot0.equip_refine_lv_max
end

function slot0.getEquipUniversalId(slot0)
	slot0.equip_universal_id = slot0.equip_universal_id or tonumber(lua_equip_const.configDict[14].value)

	return slot0.equip_universal_id
end

function slot0.getMaxLevel(slot0, slot1)
	if not slot0._equipBreakCostRareList[slot1.rare] then
		logWarn(string.format("rare '%s' not config break cost", slot1.rare))

		return uv0.MaxLevel
	end

	return slot2[#slot2].level
end

function slot0.getEquipMaxBreakLv(slot0, slot1)
	return slot0._equipMaxBreakLv and slot0._equipMaxBreakLv[slot1]
end

function slot0.getNextBreakLevelCostCo(slot0, slot1)
	slot2 = slot1.breakLv

	if not slot0._equipBreakCostRareList[slot1.config.rare] then
		logError(string.format("rare '%s' not config break cost", slot1.config.rare))

		return nil
	end

	for slot8, slot9 in ipairs(slot4) do
		if slot2 < slot9.breakLevel then
			return slot9
		end
	end

	logWarn(string.format("rare '%s',breakLevel '%s'`s not have next breakLevel config", slot3, slot2))

	return slot4[#slot4]
end

function slot0.getIncrementalExp(slot0, slot1)
	if slot1.config.isExpEquip == 1 then
		return slot0._baseExpDic[slot2.id]
	end

	if slot1.level == 1 then
		return slot0._baseExpDic[slot2.rare]
	end

	slot3 = 0
	slot4 = 0
	slot5 = 2
	slot6, slot7 = nil

	for slot11 = 0, slot1.breakLv do
		slot15 = slot11
		slot7 = slot0._expTransfer[slot11]
		slot4 = 0

		for slot15 = slot5, slot0:_getBreakLevelMaxLevel(slot2.rare, slot15) do
			if slot1.level < slot15 then
				break
			end

			slot4 = slot4 + slot0:getEquipStrengthenCostExp(slot2.rare, slot15)
		end

		slot3 = slot3 + slot4 * slot7
		slot5 = slot6 + 1
	end

	return math.floor((slot1.level < slot0:_getBreakLevelMaxLevel(slot2.rare, slot1.breakLv) and slot3 + slot1.exp * slot0._expTransfer[slot1.breakLv] or slot3 + slot1.exp * (slot0._expTransfer[slot1.breakLv + 1] and slot0._expTransfer[slot1.breakLv + 1] or slot0._expTransfer[slot1.breakLv])) + slot0._baseExpDic[slot2.rare])
end

function slot0.getEquipStrengthenCostExp(slot0, slot1, slot2)
	if slot2 == 1 then
		return slot0._baseExpDic[slot1]
	end

	return lua_equip_strengthen_cost.configDict[slot1][slot2].exp
end

function slot0.getEquipStrengthenCostCo(slot0, slot1, slot2)
	return lua_equip_strengthen_cost.configDict[slot1][math.min(slot2, uv0.MaxLevel)]
end

function slot0.getNeedExpToMaxLevel(slot0, slot1)
	for slot8 = slot1.level + 1, slot0:getCurrentBreakLevelMaxLevel(slot1) do
		slot3 = 0 + slot0._strengthenCostQualityList[slot1.config.rare][slot8].exp
	end

	return Mathf.Max(slot3 - slot1.exp, 0)
end

function slot0.getEquipBackpackMaxCount(slot0)
	return slot0._equipBackpackMaxCount
end

function slot0.getEquipCo(slot0, slot1)
	return lua_equip.configDict[slot1]
end

function slot0.getEquipValueStr(slot0, slot1)
	return slot0:dirGetEquipValueStr(slot1.showType, slot1.value)
end

function slot0.dirGetEquipValueStr(slot0, slot1, slot2)
	if slot1 == 0 then
		return string.format("%s", slot2)
	else
		slot2 = slot2 * 0.1

		if math.floor(slot2) == slot2 then
			slot2 = slot3
		end

		return string.format("%s%%", slot2)
	end
end

function slot0.getEquipSkillCfg(slot0, slot1, slot2)
	if not slot0._equipSkillList[slot1] then
		logError("equip skill config not found config, id : " .. slot1)

		return nil
	end

	return slot3[slot2]
end

function slot0.getStrengthenToLvExpInfo(slot0, slot1, slot2, slot3, slot4)
	slot5 = 0

	for slot10, slot11 in ipairs(slot0._strengthenCostQualityList[slot1]) do
		if slot2 < slot11.level then
			if slot11.exp <= slot3 + slot4 then
				if slot10 == #slot6 then
					slot4 = slot5

					break
				else
					slot4 = slot4 - slot5
				end
			else
				break
			end
		end
	end

	return slot4, slot5
end

function slot0.getStrengthenToLvCost(slot0, slot1, slot2, slot3, slot4)
	slot5 = 0

	for slot10, slot11 in ipairs(slot0._strengthenCostQualityList[slot1]) do
		if slot2 < slot11.level then
			if slot3 > 0 then
				slot12 = slot11.exp - slot3
				slot3 = 0
			end

			if slot4 > 0 then
				if slot12 < slot4 then
					slot4 = slot4 - slot12
					slot5 = slot5 + math.floor(slot12 * slot11.scoreCost / 1000)
				else
					slot5 = slot5 + math.floor(slot4 * slot11.scoreCost / 1000)
					slot4 = 0
				end
			else
				break
			end
		end
	end

	return slot5
end

function slot0.getStrengthenToLvCostExp(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = slot0._strengthenCostQualityList[slot1]

	if slot2 == slot0:_getBreakLevelMaxLevel(slot1, slot5) then
		return {
			0,
			0
		}, true
	end

	slot10 = slot3 / slot6[slot2 + 1].exp
	slot4 = slot4 + slot3

	for slot15 = slot2 + 1, slot8 do
		if slot6[slot15].exp <= slot4 then
			slot4 = slot4 - slot17
			slot11 = 0 + 1
		else
			slot11 = slot11 + slot4 / slot17
			slot7 = false

			break
		end
	end

	return {
		slot10,
		slot11 - slot10
	}, slot7
end

function slot0.getStrengthenToLv(slot0, slot1, slot2, slot3)
	slot6 = slot2

	for slot10, slot11 in ipairs(slot0._strengthenCostQualityList[slot1]) do
		if slot2 < slot11.level then
			if slot3 >= 0 + slot11.exp then
				slot6 = slot11.level
			else
				break
			end
		end
	end

	return slot6
end

function slot0.getEquipBreakCo(slot0, slot1, slot2)
	slot2 = slot2 or 0

	if not lua_equip_break_attr.configDict[slot1] then
		return nil
	end

	if not slot3[slot2] then
		return nil
	end

	return slot4
end

function slot0.getEquipCurrentBreakLvAttrEffect(slot0, slot1, slot2)
	if not slot0:getEquipBreakCo(slot1.id, slot2) then
		return nil, 0
	end

	for slot7, slot8 in pairs(uv0.EquipBreakAttrIdToFieldName) do
		if slot3[slot8] ~= 0 then
			return slot7, slot3[slot8]
		end
	end

	return nil, 0
end

function slot0.getEquipAddBaseAttr(slot0, slot1, slot2)
	slot2 = slot2 or slot1.level
	slot3 = slot1.config

	return slot0:calcStrengthenAttr(slot3, slot2, "hp"), slot0:calcStrengthenAttr(slot3, slot2, "atk"), slot0:calcStrengthenAttr(slot3, slot2, "def"), slot0:calcStrengthenAttr(slot3, slot2, "mdef")
end

function slot0.getEquipBreakAddAttrValueDict(slot0, slot1, slot2)
	slot3 = {
		[slot8] = 0
	}

	for slot7, slot8 in ipairs(CharacterEnum.BaseAttrIdList) do
		-- Nothing
	end

	for slot7, slot8 in ipairs(CharacterEnum.UpAttrIdList) do
		slot3[slot8] = 0
	end

	slot4, slot5 = slot0:getEquipCurrentBreakLvAttrEffect(slot1, slot2)

	if slot4 then
		slot3[slot4] = slot3[slot4] + slot5
	end

	for slot9, slot10 in pairs(slot3) do
		slot3[slot9] = slot10 / 10
	end

	return slot3
end

function slot0.getEquipStrengthenAttrMax0(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6, slot7, slot8, slot9 = slot0:getEquipStrengthenAttr(slot1, slot2, slot3, slot4)

	if slot9 then
		for slot13, slot14 in pairs(slot9) do
			slot9[slot13] = math.max(0, slot14)
		end
	end

	return math.max(0, slot5), math.max(0, slot6), math.max(0, slot7), math.max(0, slot8), slot9
end

function slot0.getEquipStrengthenAttr(slot0, slot1, slot2, slot3)
	slot4 = slot1 and slot1.config or slot0:getEquipCo(slot2)
	slot3 = slot3 or slot1 and slot1.level or slot0:getMaxLevel(slot0:getEquipCo(slot2))

	for slot10, slot11 in pairs(lua_character_attribute.configDict) do
		if slot11.type == 2 or slot11.type == 3 then
			-- Nothing
		end
	end

	return slot0:calcStrengthenAttr(slot4, slot3, "hp"), slot0:calcStrengthenAttr(slot4, slot3, "atk"), slot0:calcStrengthenAttr(slot4, slot3, "def"), slot0:calcStrengthenAttr(slot4, slot3, "mdef"), {
		[slot11.attrType] = slot0:calcAdvanceAttrGain(slot4, slot1 and slot1.refineLv or 1, slot11.attrType)
	}
end

function slot0.getMaxEquipNormalAttr(slot0, slot1, slot2)
	slot4, slot5 = slot0:getEquipNormalAttr(slot1, slot0:getMaxLevel(slot0:getEquipCo(slot1)), slot2)

	return slot4, slot5
end

function slot0.getEquipNormalAttr(slot0, slot1, slot2, slot3)
	slot7 = {}

	for slot11, slot12 in pairs({
		"hp",
		"atk",
		"def",
		"mdef"
	}) do
		table.insert(slot7, {
			attrType = slot12,
			value = slot0:calcStrengthenAttr(slot0:getEquipCo(slot1), slot2, slot12)
		})
	end

	table.sort(slot7, slot3 or HeroConfig.sortAttr)

	return {
		[slot12] = slot13
	}, slot7
end

function slot0.getMaxEquipAdvanceAttr(slot0, slot1)
	slot2, slot3 = slot0:getEquipAdvanceAttr(slot1, slot0:getEquipRefineLvMax())

	return slot2, slot3
end

function slot0.getEquipAdvanceAttr(slot0, slot1, slot2)
	slot4 = {}

	for slot9, slot10 in pairs(lua_character_attribute.configDict) do
		if slot10.type == 2 or slot10.type == 3 then
			table.insert(slot4, {
				attrType = slot10.attrType,
				value = slot0:calcAdvanceAttrGain(slot0:getEquipCo(slot1), slot2, slot10.attrType)
			})
		end
	end

	table.sort(slot4, HeroConfig.sortAttr)

	return {
		[slot10.attrType] = slot11
	}, slot4
end

function slot0.calcAdvanceAttrGain(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		slot2 = 1
	end

	if not slot0:getEquipSkillCfg(slot1.skillType, slot2) then
		logError("装备技能表找不到id：", slot1.skillType, "等级：", slot2)
	end

	return slot4[slot3] or 0
end

function slot0.calcStrengthenAttr(slot0, slot1, slot2, slot3)
	if not lua_equip_strengthen.configDict[slot1.strengthType] then
		return -1
	end

	if not slot4[slot3] then
		return -1
	end

	return math.floor(slot5 * slot0:getEquipStrengthenCostCo(slot1.rare, slot2).attributeRate / 1000)
end

function slot0.attrIdToName(slot0, slot1)
	return lua_character_attribute.configDict[slot1].attrType
end

function slot0.getRareColor(slot0, slot1)
	return ItemEnum.Color[slot1]
end

function slot0.isEquipSkill(slot0, slot1)
	return slot0.equip_skill_dic[slot1]
end

slot0.FastAddMAXFilterRareId = 91

function slot0.getMaxFilterRare(slot0)
	if not slot0.maxRare then
		slot0.maxRare = CommonConfig.instance:getConstNum(ConstEnum.FastAddMAXFilterRareId)
	end

	return slot0.maxRare
end

function slot0.getMinFilterRare(slot0)
	return 2
end

function slot0.getNotShowRefineRare(slot0)
	return slot0._equipNotShowRefineRare
end

function slot0.getTagList(slot0, slot1)
	if not slot1 then
		return {}
	end

	if string.nilorempty(slot1.tag) then
		return {}
	end

	return string.splitToNumber(slot1.tag, "#")
end

function slot0.getTagName(slot0, slot1)
	if not lua_equip_tag.configDict[slot1] then
		logError(string.format("not found tag id : %s config", slot1))

		return ""
	end

	return slot2.name
end

slot0.instance = slot0.New()

return slot0
