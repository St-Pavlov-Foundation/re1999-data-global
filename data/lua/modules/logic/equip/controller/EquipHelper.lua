module("modules.logic.equip.controller.EquipHelper", package.seeall)

local var_0_0 = {
	sortType = {
		sortLvDown = "sortLvDown",
		sortQualityDown = "sortQualityDown",
		sortQualityUp = "sortQualityUp",
		sortLvUp = "sortLvUp"
	},
	equipSkillAddHighAttr = {
		"cri",
		"recri",
		"criDmg",
		"criDef",
		"addDmg",
		"dropDmg",
		"revive",
		"absorb",
		"clutch",
		"heal",
		"defenseIgnore"
	},
	equipSkillAddHighAttrSortPriority = {
		absorb = 5,
		cri = 2,
		defenseIgnore = 4,
		dropDmg = 8,
		revive = 9,
		recri = 10,
		addDmg = 1,
		criDmg = 3,
		heal = 7,
		criDef = 11,
		clutch = 6
	},
	CareerValue = {
		All = "0",
		Wisdom = "6",
		Animal = "4",
		Star = "2",
		Rock = "1",
		Spirit = "5",
		Wood = "3",
		SAW = "5_6"
	},
	EquipSkillColor = {
		["0"] = "#FFFFFF",
		["1"] = "#8C6838",
		["5|6"] = "#765A79",
		["2"] = "#4C7199",
		["3"] = "#3F8C52",
		["4"] = "#B35959"
	}
}

var_0_0.DefaultEquipSkillColorIndex = "0"

function var_0_0.getEquipSkillDes(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = EquipConfig.instance:getEquipCo(arg_1_0)
	local var_1_1 = EquipConfig.instance:getEquipSkillCfg(var_1_0.skillType, arg_1_1)

	if not var_1_1 then
		return ""
	end

	local var_1_2 = var_0_0.getEquipSkillAdvanceAttrDes(arg_1_0, arg_1_1, arg_1_3)
	local var_1_3 = var_0_0.calEquipSkillBaseDes(var_1_1.baseDesc)

	if not string.nilorempty(var_1_2) and not string.nilorempty(var_1_3) then
		var_1_3 = "，" .. var_1_3
	end

	local var_1_4 = var_1_2 .. var_1_3

	if not string.nilorempty(var_1_1.spDesc) then
		var_1_4 = var_1_4 .. "\n" .. var_0_0.getSpecialSkillDes(arg_1_0, arg_1_1)
	end

	if arg_1_2 then
		var_1_4 = HeroSkillModel.instance:skillDesToSpot(var_1_4, nil, nil, true)
	end

	return var_1_4
end

function var_0_0.calEquipSkillBaseDes(arg_2_0, arg_2_1)
	arg_2_1 = arg_2_1 or "#C66030"
	arg_2_0 = string.gsub(arg_2_0, "%{", string.format("<color=%s>", arg_2_1))
	arg_2_0 = string.gsub(arg_2_0, "%}", "</color>")

	return arg_2_0
end

function var_0_0.getEquipSkillAdvanceAttrDes(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = EquipConfig.instance:getEquipCo(arg_3_0)
	local var_3_1 = EquipConfig.instance:getEquipSkillCfg(var_3_0.skillType, arg_3_1)

	if not var_3_1 then
		return ""
	end

	local var_3_2 = ""
	local var_3_3

	for iter_3_0, iter_3_1 in ipairs(var_0_0.equipSkillAddHighAttr) do
		local var_3_4 = var_3_1[iter_3_1] or 0

		if var_3_4 ~= 0 then
			local var_3_5 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(iter_3_1))

			var_3_2 = var_3_2 .. var_3_5.name .. luaLang("equip_skill_upgrade") .. var_3_4 / 10 .. "%，"
		end
	end

	if not string.nilorempty(var_3_2) then
		var_3_2 = luaLang("equip_refine_memory") .. var_3_2
		var_3_2 = string.sub(var_3_2, 1, #var_3_2 - GameUtil.charsize(string.byte("，")))
	end

	if arg_3_2 then
		var_3_2 = HeroSkillModel.instance:skillDesToSpot(var_3_2, nil, nil, true)
	end

	return var_3_2
end

function var_0_0.getEquipSkillAdvanceAttrDesTab(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = EquipConfig.instance:getEquipCo(arg_4_0)
	local var_4_1 = EquipConfig.instance:getEquipSkillCfg(var_4_0.skillType, arg_4_1)

	if not var_4_1 then
		logError(string.format("not found equipSKill config, equipId : %s, equip SkillType : %s, refine level : %s", arg_4_0, var_4_0.skillType, arg_4_1))

		return nil
	end

	local var_4_2 = {}
	local var_4_3
	local var_4_4
	local var_4_5

	for iter_4_0, iter_4_1 in ipairs(var_0_0.equipSkillAddHighAttr) do
		local var_4_6 = var_4_1[iter_4_1] or 0

		if var_4_6 ~= 0 then
			local var_4_7 = {}
			local var_4_8 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(iter_4_1)).name .. luaLang("equip_skill_upgrade") .. "<space=0.45em>" .. var_4_6 / 10 .. "%"

			if arg_4_2 then
				var_4_8 = HeroSkillModel.instance:skillDesToSpot(var_4_8, arg_4_2, nil, true)
			end

			var_4_7.desc = var_4_8
			var_4_7.key = iter_4_1
			var_4_7.value = var_4_6

			table.insert(var_4_2, var_4_7)
		end
	end

	table.sort(var_4_2, function(arg_5_0, arg_5_1)
		if arg_5_0.value ~= arg_5_1.value then
			return arg_5_0.value > arg_5_1.value
		end

		return var_0_0.equipSkillAddHighAttrSortPriority[arg_5_0.key] < var_0_0.equipSkillAddHighAttrSortPriority[arg_5_1.key]
	end)

	local var_4_9 = {}

	for iter_4_2 = 1, #var_4_2 do
		table.insert(var_4_9, var_4_2[iter_4_2].desc)
	end

	return var_4_9
end

function var_0_0.getEquipSkillBaseDes(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = EquipConfig.instance:getEquipCo(arg_6_0)
	local var_6_1 = EquipConfig.instance:getEquipSkillCfg(var_6_0.skillType, arg_6_1)

	if not var_6_1 then
		return ""
	end

	local var_6_2 = {}

	if not string.nilorempty(var_6_1.baseDesc) then
		table.insert(var_6_2, var_0_0.calEquipSkillBaseDes(var_6_1.baseDesc, arg_6_2))
	end

	return var_6_2
end

function var_0_0.getEquipSkillDescList(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = EquipConfig.instance:getEquipCo(arg_7_0)
	local var_7_1 = EquipConfig.instance:getEquipSkillCfg(var_7_0.skillType, arg_7_1)
	local var_7_2 = {}

	if not var_7_1 then
		return {}
	end

	if not string.nilorempty(var_7_1.baseDesc) then
		table.insert(var_7_2, var_0_0.calEquipSkillBaseDes(var_7_1.baseDesc, arg_7_2))
	end

	return var_7_2
end

function var_0_0.getSpecialSkillDes(arg_8_0, arg_8_1)
	local var_8_0 = EquipConfig.instance:getEquipCo(arg_8_0)
	local var_8_1 = EquipConfig.instance:getEquipSkillCfg(var_8_0.skillType, arg_8_1)

	if not var_8_1 or string.nilorempty(var_8_1.spDesc) then
		return ""
	end

	return string.format("<#4b93d6><u><link='%s'>[%s]:</link></u></color>", arg_8_0, var_8_0.feature) .. var_8_1.spDesc, var_8_0.feature, var_8_1.spDesc
end

function var_0_0.isRefineUniversalMaterials(arg_9_0)
	return arg_9_0 == EquipConfig.instance:getEquipUniversalId()
end

function var_0_0.isExpEquip(arg_10_0)
	return arg_10_0 and arg_10_0.isExpEquip == 1
end

function var_0_0.isConsumableEquip(arg_11_0)
	local var_11_0 = EquipConfig.instance:getEquipCo(arg_11_0)

	return var_0_0.isRefineUniversalMaterials(arg_11_0) or var_0_0.isExpEquip(var_11_0)
end

function var_0_0.isSpRefineEquip(arg_12_0)
	return arg_12_0 and arg_12_0.isSpRefine ~= 0
end

function var_0_0.isNormalEquip(arg_13_0)
	return arg_13_0 and not var_0_0.isExpEquip(arg_13_0) and not var_0_0.isRefineUniversalMaterials(arg_13_0.id) and not var_0_0.isSpRefineEquip(arg_13_0)
end

function var_0_0.sortLvUp(arg_14_0, arg_14_1)
	if arg_14_0.level == arg_14_1.level then
		if arg_14_0.config.rare == arg_14_1.config.rare then
			return arg_14_0.id > arg_14_1.id
		else
			return arg_14_0.config.rare > arg_14_1.config.rare
		end
	else
		return arg_14_0.level > arg_14_1.level
	end
end

function var_0_0.sortLvDown(arg_15_0, arg_15_1)
	if arg_15_0.level == arg_15_1.level then
		if arg_15_0.config.rare == arg_15_1.config.rare then
			return arg_15_0.id > arg_15_1.id
		else
			return arg_15_0.config.rare > arg_15_1.config.rare
		end
	else
		return arg_15_0.level < arg_15_1.level
	end
end

function var_0_0.sortQualityUp(arg_16_0, arg_16_1)
	if arg_16_0.config.rare == arg_16_1.config.rare then
		if arg_16_0.level == arg_16_1.level then
			return arg_16_0.id > arg_16_1.id
		else
			return arg_16_0.level > arg_16_1.level
		end
	else
		return arg_16_0.config.rare > arg_16_1.config.rare
	end
end

function var_0_0.sortQualityDown(arg_17_0, arg_17_1)
	if arg_17_0.config.rare == arg_17_1.config.rare then
		if arg_17_0.level == arg_17_1.level then
			return arg_17_0.id > arg_17_1.id
		else
			return arg_17_0.level > arg_17_1.level
		end
	else
		return arg_17_0.config.rare < arg_17_1.config.rare
	end
end

function var_0_0.typeSort(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0
	local var_18_1 = true

	if var_0_0.isRefineUniversalMaterials(arg_18_0.id) ~= var_0_0.isRefineUniversalMaterials(arg_18_1.id) then
		if var_0_0.isRefineUniversalMaterials(arg_18_0.id) then
			var_18_0 = true
		else
			var_18_0 = false
		end
	elseif var_0_0.isSpRefineEquip(arg_18_0) ~= var_0_0.isSpRefineEquip(arg_18_1) then
		if var_0_0.isSpRefineEquip(arg_18_0) then
			var_18_0 = true
		else
			var_18_0 = false
		end
	elseif var_0_0.isNormalEquip(arg_18_0) ~= var_0_0.isNormalEquip(arg_18_1) then
		if var_0_0.isNormalEquip(arg_18_0) then
			var_18_0 = true
		else
			var_18_0 = false
		end
	else
		var_18_1 = false
	end

	if arg_18_2 then
		return not var_18_0, var_18_1
	else
		return var_18_0, var_18_1
	end
end

function var_0_0.sortRefineList(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.config
	local var_19_1 = arg_19_1.config
	local var_19_2, var_19_3 = var_0_0.typeSort(var_19_0, var_19_1)

	if var_19_3 then
		return var_19_2
	end

	if arg_19_0.refineLv ~= arg_19_1.refineLv then
		return arg_19_0.refineLv < arg_19_1.refineLv
	else
		return arg_19_0.level < arg_19_1.level
	end

	return false
end

function var_0_0.createMaxLevelEquipMo(arg_20_0, arg_20_1)
	local var_20_0 = EquipConfig.instance:getEquipCo(arg_20_0)
	local var_20_1 = var_0_0.isNormalEquip(var_20_0)
	local var_20_2 = EquipMO.New()

	var_20_2.config = var_20_0
	var_20_2.equipId = var_20_0.id

	if arg_20_1 then
		var_20_2.id = arg_20_1
	end

	if var_20_1 then
		var_20_2.level = EquipConfig.instance:getMaxLevel(var_20_0)
		var_20_2.refineLv = EquipConfig.instance:getEquipRefineLvMax()
		var_20_2.breakLv = EquipConfig.instance:getEquipMaxBreakLv(var_20_0.rare)
	else
		var_20_2.level = 1
		var_20_2.refineLv = 1
		var_20_2.breakLv = 1
	end

	return var_20_2
end

function var_0_0.createMinLevelEquipMo(arg_21_0, arg_21_1)
	local var_21_0 = EquipConfig.instance:getEquipCo(arg_21_0)
	local var_21_1 = EquipMO.New()

	var_21_1.config = var_21_0
	var_21_1.equipId = var_21_0.id

	if arg_21_1 then
		var_21_1.id = arg_21_1
	end

	var_21_1.level = 1
	var_21_1.refineLv = 1
	var_21_1.breakLv = 0

	return var_21_1
end

function var_0_0.sortByLevelFunc(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.config
	local var_22_1 = arg_22_1.config
	local var_22_2, var_22_3 = var_0_0.typeSort(var_22_0, var_22_1)

	if var_22_3 then
		return var_22_2
	end

	if arg_22_0.level ~= arg_22_1.level then
		if CharacterBackpackEquipListModel.instance._levelAscend then
			return arg_22_0.level < arg_22_1.level
		else
			return arg_22_0.level > arg_22_1.level
		end
	elseif arg_22_0.config.rare ~= arg_22_1.config.rare then
		return arg_22_0.config.rare > arg_22_1.config.rare
	elseif arg_22_0.equipId ~= arg_22_1.equipId then
		return arg_22_0.equipId > arg_22_1.equipId
	elseif arg_22_0.config.rare == arg_22_1.config.rare then
		if arg_22_0.refineLv ~= arg_22_1.refineLv then
			return arg_22_0.refineLv > arg_22_1.refineLv
		else
			return arg_22_0.uid < arg_22_1.uid
		end
	else
		return arg_22_0.uid < arg_22_1.uid
	end
end

function var_0_0.sortByLevelFuncChooseListModel(arg_23_0, arg_23_1)
	if var_0_0.isNormalEquip(arg_23_0.config) ~= var_0_0.isNormalEquip(arg_23_1.config) then
		if var_0_0.isNormalEquip(arg_23_0.config) then
			return false
		else
			return true
		end
	elseif arg_23_0.level ~= arg_23_1.level then
		if EquipChooseListModel.instance._levelAscend then
			return arg_23_0.level < arg_23_1.level
		else
			return arg_23_0.level > arg_23_1.level
		end
	elseif arg_23_0.config.rare ~= arg_23_1.config.rare then
		if EquipChooseListModel.instance._qualityAscend then
			return arg_23_0.config.rare < arg_23_1.config.rare
		else
			return arg_23_0.config.rare > arg_23_1.config.rare
		end

		return arg_23_0.config.rare > arg_23_1.config.rare
	elseif arg_23_0.equipId ~= arg_23_1.equipId then
		return arg_23_0.equipId > arg_23_1.equipId
	elseif arg_23_0.config.rare == arg_23_1.config.rare then
		if arg_23_0.refineLv ~= arg_23_1.refineLv then
			return arg_23_0.refineLv > arg_23_1.refineLv
		else
			return arg_23_0.uid < arg_23_1.uid
		end
	else
		return arg_23_0.uid < arg_23_1.uid
	end
end

function var_0_0.sortByQualityFunc(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0.config
	local var_24_1 = arg_24_1.config
	local var_24_2, var_24_3 = var_0_0.typeSort(var_24_0, var_24_1)

	if var_24_3 then
		return var_24_2
	end

	if arg_24_0.config.rare ~= arg_24_1.config.rare then
		if CharacterBackpackEquipListModel.instance._qualityAscend then
			return arg_24_0.config.rare < arg_24_1.config.rare
		else
			return arg_24_0.config.rare > arg_24_1.config.rare
		end
	elseif arg_24_0.level ~= arg_24_1.level then
		return arg_24_0.level > arg_24_1.level
	elseif arg_24_0.equipId ~= arg_24_1.equipId then
		return arg_24_0.equipId > arg_24_1.equipId
	elseif arg_24_0.level == arg_24_1.level then
		return arg_24_0.uid < arg_24_1.uid
	else
		return arg_24_0.uid < arg_24_1.uid
	end
end

function var_0_0.sortByQualityFuncChooseListModel(arg_25_0, arg_25_1)
	if var_0_0.isNormalEquip(arg_25_0.config) ~= var_0_0.isNormalEquip(arg_25_1.config) then
		if var_0_0.isNormalEquip(arg_25_0.config) then
			return false
		else
			return true
		end
	elseif arg_25_0.config.rare ~= arg_25_1.config.rare then
		if EquipChooseListModel.instance._qualityAscend then
			return arg_25_0.config.rare < arg_25_1.config.rare
		else
			return arg_25_0.config.rare > arg_25_1.config.rare
		end
	elseif arg_25_0.level ~= arg_25_1.level then
		if EquipChooseListModel.instance._levelAscend then
			return arg_25_0.level < arg_25_1.level
		else
			return arg_25_0.level > arg_25_1.level
		end
	elseif arg_25_0.equipId ~= arg_25_1.equipId then
		return arg_25_0.equipId > arg_25_1.equipId
	elseif arg_25_0.level == arg_25_1.level then
		return arg_25_0.uid < arg_25_1.uid
	else
		return arg_25_0.uid < arg_25_1.uid
	end
end

function var_0_0.sortByTimeFunc(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0.config
	local var_26_1 = arg_26_1.config
	local var_26_2, var_26_3 = var_0_0.typeSort(var_26_0, var_26_1)

	if var_26_3 then
		return var_26_2
	end

	if arg_26_0.id ~= arg_26_1.id then
		if CharacterBackpackEquipListModel.instance._timeAscend then
			return arg_26_0.id < arg_26_1.id
		else
			return arg_26_0.id > arg_26_1.id
		end
	elseif arg_26_0.level ~= arg_26_1.level then
		return arg_26_0.level > arg_26_1.level
	else
		return arg_26_0.config.rare > arg_26_1.config.rare
	end
end

function var_0_0.detectEquipSkillSuited(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = HeroConfig.instance:getHeroCO(arg_27_0)
	local var_27_1 = EquipConfig.instance:getEquipSkillCfg(arg_27_1, arg_27_2)

	if not var_27_0 then
		return false
	end

	if not var_27_1 then
		logError("装备技能表找不到id：", arg_27_1, "Lv:", arg_27_2)

		return
	end

	local var_27_2 = string.splitToNumber(var_27_1.career, "|") or {}

	if #var_27_2 == 0 then
		return true
	end

	for iter_27_0, iter_27_1 in ipairs(var_27_2) do
		if iter_27_1 == var_27_0.career then
			return true
		end
	end

	return false
end

function var_0_0.getEquipSkillCareer(arg_28_0, arg_28_1)
	return nil
end

function var_0_0.isEqualCareer(arg_29_0, arg_29_1)
	if arg_29_1 == var_0_0.CareerValue.All then
		return true
	end

	local var_29_0 = var_0_0.getEquipSkillCareer(arg_29_0.config.id, arg_29_0.refineLv)
	local var_29_1 = string.splitToNumber(var_29_0, "|")
	local var_29_2 = string.splitToNumber(arg_29_1, "_")

	for iter_29_0, iter_29_1 in ipairs(var_29_2) do
		for iter_29_2, iter_29_3 in ipairs(var_29_1) do
			if iter_29_3 == iter_29_1 then
				return true
			end
		end
	end

	return false
end

function var_0_0.isEqualCareerByCo(arg_30_0, arg_30_1)
	if arg_30_1 == var_0_0.CareerValue.All then
		return true
	end

	local var_30_0 = var_0_0.getEquipSkillCareer(arg_30_0.id, 1)
	local var_30_1 = string.splitToNumber(var_30_0, "|")
	local var_30_2 = string.splitToNumber(arg_30_1, "_")

	for iter_30_0, iter_30_1 in ipairs(var_30_2) do
		for iter_30_2, iter_30_3 in ipairs(var_30_1) do
			if iter_30_3 == iter_30_1 then
				return true
			end
		end
	end

	return false
end

function var_0_0.getSkillBaseDescAndIcon(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = var_0_0.getEquipSkillCareer(arg_31_0, arg_31_1)
	local var_31_1 = var_0_0.getSkillBaseNameColor(var_31_0)
	local var_31_2 = var_0_0.getSkillCarrerIconName(var_31_0)

	return var_0_0.getEquipSkillBaseDes(arg_31_0, arg_31_1, arg_31_2), var_31_2, var_31_1
end

function var_0_0.getSkillCarrerIconName(arg_32_0)
	local var_32_0 = "bg_shuxing"

	if string.nilorempty(arg_32_0) then
		var_32_0 = "bg_shuxing_0"
	else
		local var_32_1 = string.splitToNumber(arg_32_0, "|")

		for iter_32_0, iter_32_1 in ipairs(var_32_1) do
			var_32_0 = var_32_0 .. "_" .. iter_32_1
		end
	end

	return var_32_0
end

function var_0_0.getSkillCarrerSpecialIconName(arg_33_0)
	local var_33_0

	if string.nilorempty(arg_33_0) then
		var_33_0 = "lssx_0"
	else
		var_33_0 = "jinglian"

		local var_33_1 = string.splitToNumber(arg_33_0, "|")

		for iter_33_0, iter_33_1 in ipairs(var_33_1) do
			var_33_0 = var_33_0 .. "_" .. iter_33_1
		end
	end

	return var_33_0
end

function var_0_0.getSkillCareerNewIconName(arg_34_0, arg_34_1)
	if string.nilorempty(arg_34_0) then
		arg_34_1 = arg_34_1 and arg_34_1 .. "_0" or "lssx_0"
	else
		arg_34_1 = arg_34_1 or "career"

		local var_34_0 = string.splitToNumber(arg_34_0, "|")

		for iter_34_0, iter_34_1 in ipairs(var_34_0) do
			arg_34_1 = arg_34_1 .. "_" .. iter_34_1
		end
	end

	return arg_34_1
end

function var_0_0.loadEquipCareerNewIcon(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = var_0_0.getEquipSkillCareer(arg_35_0.id, arg_35_2 or 1)
	local var_35_1 = var_0_0.isHasSkillBaseDesc(arg_35_0.id, arg_35_2 or 1)

	if not string.nilorempty(var_35_0) and var_35_1 then
		local var_35_2 = var_0_0.getSkillCareerNewIconName(var_35_0, arg_35_3)

		UISpriteSetMgr.instance:setCommonSprite(arg_35_1, var_35_2)
		gohelper.setActive(arg_35_1.gameObject, true)
	else
		gohelper.setActive(arg_35_1.gameObject, false)
	end
end

function var_0_0.isHasSkillBaseDesc(arg_36_0, arg_36_1)
	local var_36_0 = EquipConfig.instance:getEquipCo(arg_36_0)
	local var_36_1 = EquipConfig.instance:getEquipSkillCfg(var_36_0.skillType, arg_36_1)

	if not var_36_1 or string.nilorempty(var_36_1.baseDesc) then
		return false
	end

	return true
end

function var_0_0.getSkillBaseNameColor(arg_37_0)
	return var_0_0.EquipSkillColor[var_0_0.DefaultEquipSkillColorIndex]
end

function var_0_0.getDefaultColor()
	return var_0_0.EquipSkillColor[var_0_0.DefaultEquipSkillColorIndex]
end

function var_0_0.getEquipIconLoadPath(arg_39_0)
	local var_39_0 = arg_39_0.isExpEquip
	local var_39_1 = arg_39_0._config.icon
	local var_39_2 = var_39_0 and ResUrl.getEquipIcon(string.format("%s_equip", var_39_1)) or ResUrl.getEquipIcon(var_39_1)

	arg_39_0._simageicon:LoadImage(var_39_2, arg_39_0._loadImageFinish, arg_39_0)
end

function var_0_0.getEquipDefaultIconLoadPath(arg_40_0)
	local var_40_0 = arg_40_0._config.icon
	local var_40_1 = ResUrl.getHeroDefaultEquipIcon(var_40_0)

	arg_40_0._simageicon:LoadImage(var_40_1, var_0_0.getEquipDefaultIconLoadEnd, arg_40_0)
end

function var_0_0.getEquipDefaultIconLoadEnd(arg_41_0)
	arg_41_0._simageicon:GetComponent(gohelper.Type_Image):SetNativeSize()
	arg_41_0:_loadImageFinish()
end

function var_0_0.getAttrPercentValueStr(arg_42_0)
	return GameUtil.noMoreThanOneDecimalPlace(arg_42_0 / 10) .. "%"
end

function var_0_0.getAttrBreakText(arg_43_0)
	return HeroConfig.instance:getHeroAttributeCO(arg_43_0).name
end

function var_0_0.getEquipSkillDesc(arg_44_0)
	arg_44_0 = SkillHelper.addLink(arg_44_0)
	arg_44_0 = SkillHelper.addBracketColor(arg_44_0)

	return arg_44_0
end

return var_0_0
