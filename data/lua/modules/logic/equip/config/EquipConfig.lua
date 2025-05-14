module("modules.logic.equip.config.EquipConfig", package.seeall)

local var_0_0 = class("EquipConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
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

function var_0_0.onInit(arg_2_0)
	return
end

var_0_0.MaxLevel = 60
var_0_0.EquipBreakAttrIdToFieldName = {
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

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "equip_const" then
		arg_3_0._baseExpDic = {}

		local var_3_0 = lua_equip_const.configDict[1].value
		local var_3_1
		local var_3_2
		local var_3_3

		for iter_3_0, iter_3_1 in ipairs(string.split(var_3_0, "|")) do
			local var_3_4 = string.split(iter_3_1, "#")
			local var_3_5 = var_3_4[1]
			local var_3_6 = var_3_4[2]

			arg_3_0._baseExpDic[tonumber(var_3_5)] = tonumber(var_3_6)
		end

		local var_3_7 = lua_equip_const.configDict[2].value

		for iter_3_2, iter_3_3 in ipairs(string.split(var_3_7, "|")) do
			local var_3_8 = string.split(iter_3_3, "#")
			local var_3_9 = var_3_8[1]
			local var_3_10 = var_3_8[2]

			arg_3_0._baseExpDic[tonumber(var_3_9)] = tonumber(var_3_10)
		end

		arg_3_0._expTransfer = {}

		local var_3_11 = string.split(lua_equip_const.configDict[3].value, "|")
		local var_3_12

		for iter_3_4, iter_3_5 in ipairs(var_3_11) do
			local var_3_13 = string.splitToNumber(iter_3_5, "#")

			arg_3_0._expTransfer[var_3_13[1]] = var_3_13[2] / 100
		end

		arg_3_0._equipBackpackMaxCount = tonumber(lua_equip_const.configDict[13].value)
		arg_3_0._equipNotShowRefineRare = tonumber(lua_equip_const.configDict[16].value)

		local var_3_14 = string.splitToNumber(lua_equip_const.configDict[17].value, "#")

		arg_3_0.equipDecomposeEquipId = var_3_14[2]
		arg_3_0.equipDecomposeEquipUnitCount = var_3_14[3]
	end

	if arg_3_1 == "equip_break_cost" then
		arg_3_0._equipBreakCostRareList = {}
		arg_3_0._equipMaxBreakLv = {}

		for iter_3_6, iter_3_7 in ipairs(lua_equip_break_cost.configList) do
			if not arg_3_0._equipBreakCostRareList[iter_3_7.rare] then
				arg_3_0._equipBreakCostRareList[iter_3_7.rare] = {}
			end

			table.insert(arg_3_0._equipBreakCostRareList[iter_3_7.rare], iter_3_7)

			if not arg_3_0._equipMaxBreakLv[iter_3_7.rare] then
				arg_3_0._equipMaxBreakLv[iter_3_7.rare] = 0
			end

			if iter_3_7.breakLevel > arg_3_0._equipMaxBreakLv[iter_3_7.rare] then
				arg_3_0._equipMaxBreakLv[iter_3_7.rare] = iter_3_7.breakLevel
			end
		end

		for iter_3_8, iter_3_9 in pairs(arg_3_0._equipBreakCostRareList) do
			table.sort(iter_3_9, function(arg_4_0, arg_4_1)
				return arg_4_0.breakLevel < arg_4_1.breakLevel
			end)
		end
	end

	if arg_3_1 == "equip_strengthen_cost" and not arg_3_0._strengthenCostQualityList then
		arg_3_0._strengthenCostQualityList = {}

		for iter_3_10, iter_3_11 in ipairs(lua_equip_strengthen_cost.configList) do
			local var_3_15 = arg_3_0._strengthenCostQualityList[iter_3_11.rare] or {}

			arg_3_0._strengthenCostQualityList[iter_3_11.rare] = var_3_15

			table.insert(var_3_15, iter_3_11)
		end
	end

	if arg_3_1 == "equip_skill" then
		arg_3_0._equipSkillList = {}
		arg_3_0.equip_skill_dic = {}

		for iter_3_12, iter_3_13 in ipairs(lua_equip_skill.configList) do
			arg_3_0._equipSkillList[iter_3_13.id] = arg_3_0._equipSkillList[iter_3_13.id] or {}
			arg_3_0._equipSkillList[iter_3_13.id][iter_3_13.skillLv] = iter_3_13
			arg_3_0.equip_skill_dic[iter_3_13.skill] = iter_3_13
			arg_3_0.equip_skill_dic[iter_3_13.skill2] = iter_3_13
		end
	end
end

function var_0_0.getOneLevelEquipProduceExp(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._baseExpDic[arg_5_1]

	if var_5_0 == nil then
		logError("not found base equip exp : " + tostring(arg_5_1))

		return 0
	end

	return var_5_0
end

function var_0_0.getCurrentBreakLevelMaxLevel(arg_6_0, arg_6_1)
	return arg_6_0:_getBreakLevelMaxLevel(arg_6_1.config.rare, arg_6_1.breakLv)
end

function var_0_0.getNextBreakLevelMaxLevel(arg_7_0, arg_7_1)
	return arg_7_0:_getBreakLevelMaxLevel(arg_7_1.config.rare, arg_7_1.breakLv + 1)
end

function var_0_0._getBreakLevelMaxLevel(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0._equipBreakCostRareList[arg_8_1]

	if not var_8_0 then
		logError(string.format("rare '%s' not config break cost", arg_8_1))

		return var_0_0.MaxLevel
	end

	for iter_8_0 = 1, #var_8_0 do
		if var_8_0[iter_8_0].breakLevel == arg_8_2 then
			return var_8_0[iter_8_0].level
		end
	end

	logWarn(string.format("rare '%s',breakLevel '%s' not config break cost", arg_8_1, arg_8_2))

	return var_0_0.MaxLevel
end

function var_0_0.getEquipRefineLvMax(arg_9_0)
	arg_9_0.equip_refine_lv_max = arg_9_0.equip_refine_lv_max or tonumber(lua_equip_const.configDict[15].value)

	return arg_9_0.equip_refine_lv_max
end

function var_0_0.getEquipUniversalId(arg_10_0)
	arg_10_0.equip_universal_id = arg_10_0.equip_universal_id or tonumber(lua_equip_const.configDict[14].value)

	return arg_10_0.equip_universal_id
end

function var_0_0.getMaxLevel(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._equipBreakCostRareList[arg_11_1.rare]

	if not var_11_0 then
		logWarn(string.format("rare '%s' not config break cost", arg_11_1.rare))

		return var_0_0.MaxLevel
	end

	return var_11_0[#var_11_0].level
end

function var_0_0.getEquipMaxBreakLv(arg_12_0, arg_12_1)
	return arg_12_0._equipMaxBreakLv and arg_12_0._equipMaxBreakLv[arg_12_1]
end

function var_0_0.getNextBreakLevelCostCo(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.breakLv
	local var_13_1 = arg_13_1.config.rare
	local var_13_2 = arg_13_0._equipBreakCostRareList[var_13_1]

	if not var_13_2 then
		logError(string.format("rare '%s' not config break cost", arg_13_1.config.rare))

		return nil
	end

	for iter_13_0, iter_13_1 in ipairs(var_13_2) do
		if var_13_0 < iter_13_1.breakLevel then
			return iter_13_1
		end
	end

	logWarn(string.format("rare '%s',breakLevel '%s'`s not have next breakLevel config", var_13_1, var_13_0))

	return var_13_2[#var_13_2]
end

function var_0_0.getIncrementalExp(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.config

	if var_14_0.isExpEquip == 1 then
		return arg_14_0._baseExpDic[var_14_0.id]
	end

	if arg_14_1.level == 1 then
		return arg_14_0._baseExpDic[var_14_0.rare]
	end

	local var_14_1 = 0
	local var_14_2 = 0
	local var_14_3 = 2
	local var_14_4
	local var_14_5

	for iter_14_0 = 0, arg_14_1.breakLv do
		local var_14_6 = arg_14_0:_getBreakLevelMaxLevel(var_14_0.rare, iter_14_0)
		local var_14_7 = arg_14_0._expTransfer[iter_14_0]
		local var_14_8 = 0

		for iter_14_1 = var_14_3, var_14_6 do
			if iter_14_1 > arg_14_1.level then
				break
			end

			var_14_8 = var_14_8 + arg_14_0:getEquipStrengthenCostExp(var_14_0.rare, iter_14_1)
		end

		var_14_1 = var_14_1 + var_14_8 * var_14_7
		var_14_3 = var_14_6 + 1
	end

	if arg_14_0:_getBreakLevelMaxLevel(var_14_0.rare, arg_14_1.breakLv) > arg_14_1.level then
		var_14_1 = var_14_1 + arg_14_1.exp * arg_14_0._expTransfer[arg_14_1.breakLv]
	else
		var_14_1 = var_14_1 + arg_14_1.exp * (arg_14_0._expTransfer[arg_14_1.breakLv + 1] and arg_14_0._expTransfer[arg_14_1.breakLv + 1] or arg_14_0._expTransfer[arg_14_1.breakLv])
	end

	local var_14_9 = var_14_1 + arg_14_0._baseExpDic[var_14_0.rare]

	return math.floor(var_14_9)
end

function var_0_0.getEquipStrengthenCostExp(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_2 == 1 then
		return arg_15_0._baseExpDic[arg_15_1]
	end

	return lua_equip_strengthen_cost.configDict[arg_15_1][arg_15_2].exp
end

function var_0_0.getEquipStrengthenCostCo(arg_16_0, arg_16_1, arg_16_2)
	arg_16_2 = math.min(arg_16_2, var_0_0.MaxLevel)

	return lua_equip_strengthen_cost.configDict[arg_16_1][arg_16_2]
end

function var_0_0.getNeedExpToMaxLevel(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:getCurrentBreakLevelMaxLevel(arg_17_1)
	local var_17_1 = 0
	local var_17_2 = arg_17_0._strengthenCostQualityList[arg_17_1.config.rare]

	for iter_17_0 = arg_17_1.level + 1, var_17_0 do
		var_17_1 = var_17_1 + var_17_2[iter_17_0].exp
	end

	return Mathf.Max(var_17_1 - arg_17_1.exp, 0)
end

function var_0_0.getEquipBackpackMaxCount(arg_18_0)
	return arg_18_0._equipBackpackMaxCount
end

function var_0_0.getEquipCo(arg_19_0, arg_19_1)
	return lua_equip.configDict[arg_19_1]
end

function var_0_0.getEquipValueStr(arg_20_0, arg_20_1)
	return arg_20_0:dirGetEquipValueStr(arg_20_1.showType, arg_20_1.value)
end

function var_0_0.dirGetEquipValueStr(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1 == 0 then
		return string.format("%s", arg_21_2)
	else
		arg_21_2 = arg_21_2 * 0.1

		local var_21_0 = math.floor(arg_21_2)

		if var_21_0 == arg_21_2 then
			arg_21_2 = var_21_0
		end

		return string.format("%s%%", arg_21_2)
	end
end

function var_0_0.getEquipSkillCfg(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0._equipSkillList[arg_22_1]

	if not var_22_0 then
		logError("equip skill config not found config, id : " .. arg_22_1)

		return nil
	end

	return var_22_0[arg_22_2]
end

function var_0_0.getStrengthenToLvExpInfo(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	arg_23_4 = arg_23_3 + arg_23_4

	local var_23_0 = 0
	local var_23_1 = arg_23_0._strengthenCostQualityList[arg_23_1]

	for iter_23_0, iter_23_1 in ipairs(var_23_1) do
		if arg_23_2 < iter_23_1.level then
			var_23_0 = iter_23_1.exp

			if var_23_0 <= arg_23_4 then
				if iter_23_0 == #var_23_1 then
					arg_23_4 = var_23_0

					break
				else
					arg_23_4 = arg_23_4 - var_23_0
				end
			else
				break
			end
		end
	end

	return arg_23_4, var_23_0
end

function var_0_0.getStrengthenToLvCost(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	local var_24_0 = 0
	local var_24_1 = arg_24_0._strengthenCostQualityList[arg_24_1]

	for iter_24_0, iter_24_1 in ipairs(var_24_1) do
		if arg_24_2 < iter_24_1.level then
			local var_24_2 = iter_24_1.exp

			if arg_24_3 > 0 then
				var_24_2 = var_24_2 - arg_24_3
				arg_24_3 = 0
			end

			if arg_24_4 > 0 then
				if var_24_2 < arg_24_4 then
					arg_24_4 = arg_24_4 - var_24_2
					var_24_0 = var_24_0 + math.floor(var_24_2 * iter_24_1.scoreCost / 1000)
				else
					var_24_0 = var_24_0 + math.floor(arg_24_4 * iter_24_1.scoreCost / 1000)
					arg_24_4 = 0
				end
			else
				break
			end
		end
	end

	return var_24_0
end

function var_0_0.getStrengthenToLvCostExp(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5)
	local var_25_0 = arg_25_0._strengthenCostQualityList[arg_25_1]
	local var_25_1 = true
	local var_25_2 = arg_25_0:_getBreakLevelMaxLevel(arg_25_1, arg_25_5)

	if arg_25_2 == var_25_2 then
		return {
			0,
			0
		}, var_25_1
	end

	local var_25_3 = arg_25_3 / var_25_0[arg_25_2 + 1].exp
	local var_25_4 = 0

	arg_25_4 = arg_25_4 + arg_25_3

	for iter_25_0 = arg_25_2 + 1, var_25_2 do
		local var_25_5 = var_25_0[iter_25_0].exp

		if var_25_5 <= arg_25_4 then
			arg_25_4 = arg_25_4 - var_25_5
			var_25_4 = var_25_4 + 1
		else
			var_25_4 = var_25_4 + arg_25_4 / var_25_5
			var_25_1 = false

			break
		end
	end

	return {
		var_25_3,
		var_25_4 - var_25_3
	}, var_25_1
end

function var_0_0.getStrengthenToLv(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = arg_26_0._strengthenCostQualityList[arg_26_1]
	local var_26_1 = 0
	local var_26_2 = arg_26_2

	for iter_26_0, iter_26_1 in ipairs(var_26_0) do
		if arg_26_2 < iter_26_1.level then
			var_26_1 = var_26_1 + iter_26_1.exp

			if var_26_1 <= arg_26_3 then
				var_26_2 = iter_26_1.level
			else
				break
			end
		end
	end

	return var_26_2
end

function var_0_0.getEquipBreakCo(arg_27_0, arg_27_1, arg_27_2)
	arg_27_2 = arg_27_2 or 0

	local var_27_0 = lua_equip_break_attr.configDict[arg_27_1]

	if not var_27_0 then
		return nil
	end

	local var_27_1 = var_27_0[arg_27_2]

	if not var_27_1 then
		return nil
	end

	return var_27_1
end

function var_0_0.getEquipCurrentBreakLvAttrEffect(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0:getEquipBreakCo(arg_28_1.id, arg_28_2)

	if not var_28_0 then
		return nil, 0
	end

	for iter_28_0, iter_28_1 in pairs(var_0_0.EquipBreakAttrIdToFieldName) do
		if var_28_0[iter_28_1] ~= 0 then
			return iter_28_0, var_28_0[iter_28_1]
		end
	end

	return nil, 0
end

function var_0_0.getEquipAddBaseAttr(arg_29_0, arg_29_1, arg_29_2)
	arg_29_2 = arg_29_2 or arg_29_1.level

	local var_29_0 = arg_29_1.config
	local var_29_1 = arg_29_0:calcStrengthenAttr(var_29_0, arg_29_2, "hp")
	local var_29_2 = arg_29_0:calcStrengthenAttr(var_29_0, arg_29_2, "atk")
	local var_29_3 = arg_29_0:calcStrengthenAttr(var_29_0, arg_29_2, "def")
	local var_29_4 = arg_29_0:calcStrengthenAttr(var_29_0, arg_29_2, "mdef")

	return var_29_1, var_29_2, var_29_3, var_29_4
end

function var_0_0.getEquipBreakAddAttrValueDict(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = {}

	for iter_30_0, iter_30_1 in ipairs(CharacterEnum.BaseAttrIdList) do
		var_30_0[iter_30_1] = 0
	end

	for iter_30_2, iter_30_3 in ipairs(CharacterEnum.UpAttrIdList) do
		var_30_0[iter_30_3] = 0
	end

	local var_30_1, var_30_2 = arg_30_0:getEquipCurrentBreakLvAttrEffect(arg_30_1, arg_30_2)

	if var_30_1 then
		var_30_0[var_30_1] = var_30_0[var_30_1] + var_30_2
	end

	for iter_30_4, iter_30_5 in pairs(var_30_0) do
		var_30_0[iter_30_4] = iter_30_5 / 10
	end

	return var_30_0
end

function var_0_0.getEquipStrengthenAttrMax0(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	local var_31_0, var_31_1, var_31_2, var_31_3, var_31_4 = arg_31_0:getEquipStrengthenAttr(arg_31_1, arg_31_2, arg_31_3, arg_31_4)

	if var_31_4 then
		for iter_31_0, iter_31_1 in pairs(var_31_4) do
			var_31_4[iter_31_0] = math.max(0, iter_31_1)
		end
	end

	return math.max(0, var_31_0), math.max(0, var_31_1), math.max(0, var_31_2), math.max(0, var_31_3), var_31_4
end

function var_0_0.getEquipStrengthenAttr(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = arg_32_1 and arg_32_1.config or arg_32_0:getEquipCo(arg_32_2)

	arg_32_3 = arg_32_3 or arg_32_1 and arg_32_1.level or arg_32_0:getMaxLevel(arg_32_0:getEquipCo(arg_32_2))

	local var_32_1 = arg_32_1 and arg_32_1.refineLv or 1
	local var_32_2 = {}

	for iter_32_0, iter_32_1 in pairs(lua_character_attribute.configDict) do
		if iter_32_1.type == 2 or iter_32_1.type == 3 then
			var_32_2[iter_32_1.attrType] = arg_32_0:calcAdvanceAttrGain(var_32_0, var_32_1, iter_32_1.attrType)
		end
	end

	local var_32_3 = arg_32_0:calcStrengthenAttr(var_32_0, arg_32_3, "hp")
	local var_32_4 = arg_32_0:calcStrengthenAttr(var_32_0, arg_32_3, "atk")
	local var_32_5 = arg_32_0:calcStrengthenAttr(var_32_0, arg_32_3, "def")
	local var_32_6 = arg_32_0:calcStrengthenAttr(var_32_0, arg_32_3, "mdef")

	return var_32_3, var_32_4, var_32_5, var_32_6, var_32_2
end

function var_0_0.getMaxEquipNormalAttr(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_0:getEquipCo(arg_33_1)
	local var_33_1, var_33_2 = arg_33_0:getEquipNormalAttr(arg_33_1, arg_33_0:getMaxLevel(var_33_0), arg_33_2)

	return var_33_1, var_33_2
end

function var_0_0.getEquipNormalAttr(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = arg_34_0:getEquipCo(arg_34_1)
	local var_34_1 = {
		"hp",
		"atk",
		"def",
		"mdef"
	}
	local var_34_2 = {}
	local var_34_3 = {}

	for iter_34_0, iter_34_1 in pairs(var_34_1) do
		local var_34_4 = {
			attrType = iter_34_1,
			value = arg_34_0:calcStrengthenAttr(var_34_0, arg_34_2, iter_34_1)
		}

		var_34_2[iter_34_1] = var_34_4

		table.insert(var_34_3, var_34_4)
	end

	table.sort(var_34_3, arg_34_3 or HeroConfig.sortAttr)

	return var_34_2, var_34_3
end

function var_0_0.getMaxEquipAdvanceAttr(arg_35_0, arg_35_1)
	local var_35_0, var_35_1 = arg_35_0:getEquipAdvanceAttr(arg_35_1, arg_35_0:getEquipRefineLvMax())

	return var_35_0, var_35_1
end

function var_0_0.getEquipAdvanceAttr(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = {}
	local var_36_1 = {}
	local var_36_2 = arg_36_0:getEquipCo(arg_36_1)

	for iter_36_0, iter_36_1 in pairs(lua_character_attribute.configDict) do
		if iter_36_1.type == 2 or iter_36_1.type == 3 then
			local var_36_3 = {
				attrType = iter_36_1.attrType,
				value = arg_36_0:calcAdvanceAttrGain(var_36_2, arg_36_2, iter_36_1.attrType)
			}

			var_36_0[iter_36_1.attrType] = var_36_3

			table.insert(var_36_1, var_36_3)
		end
	end

	table.sort(var_36_1, HeroConfig.sortAttr)

	return var_36_0, var_36_1
end

function var_0_0.calcAdvanceAttrGain(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	if arg_37_2 == 0 then
		arg_37_2 = 1
	end

	local var_37_0 = arg_37_0:getEquipSkillCfg(arg_37_1.skillType, arg_37_2)

	if not var_37_0 then
		logError("装备技能表找不到id：", arg_37_1.skillType, "等级：", arg_37_2)
	end

	return var_37_0[arg_37_3] or 0
end

function var_0_0.calcStrengthenAttr(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = lua_equip_strengthen.configDict[arg_38_1.strengthType]

	if not var_38_0 then
		return -1
	end

	local var_38_1 = var_38_0[arg_38_3]

	if not var_38_1 then
		return -1
	end

	local var_38_2 = arg_38_0:getEquipStrengthenCostCo(arg_38_1.rare, arg_38_2)

	return math.floor(var_38_1 * var_38_2.attributeRate / 1000)
end

function var_0_0.attrIdToName(arg_39_0, arg_39_1)
	return lua_character_attribute.configDict[arg_39_1].attrType
end

function var_0_0.getRareColor(arg_40_0, arg_40_1)
	return ItemEnum.Color[arg_40_1]
end

function var_0_0.isEquipSkill(arg_41_0, arg_41_1)
	return arg_41_0.equip_skill_dic[arg_41_1]
end

var_0_0.FastAddMAXFilterRareId = 91

function var_0_0.getMaxFilterRare(arg_42_0)
	if not arg_42_0.maxRare then
		arg_42_0.maxRare = CommonConfig.instance:getConstNum(ConstEnum.FastAddMAXFilterRareId)
	end

	return arg_42_0.maxRare
end

function var_0_0.getMinFilterRare(arg_43_0)
	return 2
end

function var_0_0.getNotShowRefineRare(arg_44_0)
	return arg_44_0._equipNotShowRefineRare
end

function var_0_0.getTagList(arg_45_0, arg_45_1)
	if not arg_45_1 then
		return {}
	end

	if string.nilorempty(arg_45_1.tag) then
		return {}
	end

	return string.splitToNumber(arg_45_1.tag, "#")
end

function var_0_0.getTagName(arg_46_0, arg_46_1)
	local var_46_0 = lua_equip_tag.configDict[arg_46_1]

	if not var_46_0 then
		logError(string.format("not found tag id : %s config", arg_46_1))

		return ""
	end

	return var_46_0.name
end

var_0_0.instance = var_0_0.New()

return var_0_0
