module("modules.logic.character.config.HeroConfig", package.seeall)

local var_0_0 = class("HeroConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0.heroConfig = nil
	arg_1_0.attributeConfig = nil
	arg_1_0.battleTagConfig = nil
	arg_1_0.friendLessConfig = nil
	arg_1_0.talent_cube_attr_config = nil
	arg_1_0.maxFaith = 0
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"character",
		"character_attribute",
		"character_battle_tag",
		"friendless",
		"talent_cube_attr",
		"hero_trial",
		"hero_trial_attr",
		"hero_group_type",
		"character_limited"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "character" then
		arg_3_0.heroConfig = arg_3_2
	elseif arg_3_1 == "character_attribute" then
		arg_3_0.attributeConfig = arg_3_2

		arg_3_0:processAttrConfig()
	elseif arg_3_1 == "character_battle_tag" then
		arg_3_0.battleTagConfig = arg_3_2
	elseif arg_3_1 == "friendless" then
		arg_3_0.friendLessConfig = arg_3_2

		for iter_3_0 = 1, #arg_3_0.friendLessConfig.configDict do
			arg_3_0.maxFaith = arg_3_0.maxFaith + arg_3_0.friendLessConfig.configDict[iter_3_0].friendliness
		end
	elseif arg_3_1 == "talent_cube_attr" then
		arg_3_0.talent_cube_attr_config = arg_3_2
	elseif arg_3_1 == "hero_group_type" then
		arg_3_0.heroGroupTypeDict = {}

		for iter_3_1, iter_3_2 in pairs(arg_3_2.configList) do
			local var_3_0 = string.splitToNumber(iter_3_2.chapterIds, "#") or {}

			for iter_3_3, iter_3_4 in pairs(var_3_0) do
				arg_3_0.heroGroupTypeDict[iter_3_4] = iter_3_2
			end
		end
	elseif arg_3_1 == "hero_trial" then
		arg_3_0.heroTrialConfig = arg_3_2.configDict
	end
end

function var_0_0.getTrial104Equip(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_3 = arg_4_3 or 0

	local var_4_0 = arg_4_0.heroTrialConfig[arg_4_2] and arg_4_0.heroTrialConfig[arg_4_2][arg_4_3]

	if var_4_0 then
		return var_4_0["act104EquipId" .. tostring(arg_4_1)]
	end
end

function var_0_0.getHeroCO(arg_5_0, arg_5_1)
	return arg_5_0.heroConfig.configDict[arg_5_1]
end

function var_0_0.getHeroGroupTypeCo(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return
	end

	return arg_6_0.heroGroupTypeDict[arg_6_1] or lua_hero_group_type.configDict[ModuleEnum.HeroGroupServerType.Activity]
end

function var_0_0.getHeroAttributesCO(arg_7_0)
	return arg_7_0.attributeConfig.configDict
end

function var_0_0.getHeroAttributeCO(arg_8_0, arg_8_1)
	return arg_8_0.attributeConfig.configDict[arg_8_1]
end

function var_0_0.getBattleTagConfigCO(arg_9_0, arg_9_1)
	return arg_9_0.battleTagConfig.configDict[arg_9_1]
end

function var_0_0.getTalentCubeAttrConfig(arg_10_0, arg_10_1, arg_10_2)
	return arg_10_0.talent_cube_attr_config.configDict[arg_10_1][arg_10_2]
end

function var_0_0.getTalentCubeMaxLevel(arg_11_0, arg_11_1)
	if not arg_11_0.max_talent_level_dic then
		arg_11_0.max_talent_level_dic = {}
	end

	if arg_11_0.max_talent_level_dic[arg_11_1] then
		return arg_11_0.max_talent_level_dic[arg_11_1]
	end

	local var_11_0 = 0

	for iter_11_0, iter_11_1 in pairs(arg_11_0.talent_cube_attr_config.configDict[arg_11_1]) do
		if var_11_0 <= iter_11_1.level then
			var_11_0 = iter_11_1.level
		end
	end

	arg_11_0.max_talent_level_dic[arg_11_1] = var_11_0

	return var_11_0
end

function var_0_0.getAnyRareCharacterCount(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.heroConfig.configDict
	local var_12_1 = 0

	for iter_12_0, iter_12_1 in pairs(var_12_0) do
		if iter_12_1.rare == arg_12_1 then
			var_12_1 = var_12_1 + 1
		end
	end

	return var_12_1
end

function var_0_0.getAnyOnlineRareCharacterCount(arg_13_0, arg_13_1)
	local var_13_0 = 0

	for iter_13_0, iter_13_1 in pairs(arg_13_0.heroConfig.configDict) do
		if iter_13_1.rare == arg_13_1 then
			if iter_13_1.isOnline == "1" then
				var_13_0 = var_13_0 + 1
			elseif iter_13_1.isOnline ~= "0" and TimeUtil.stringToTimestamp(iter_13_1.isOnline) < ServerTime.Now() then
				var_13_0 = var_13_0 + 1
			end
		end
	end

	return var_13_0
end

function var_0_0.getFaithPercent(arg_14_0, arg_14_1)
	if arg_14_1 >= arg_14_0.maxFaith then
		return {
			1,
			0
		}
	end

	local var_14_0 = 0
	local var_14_1 = 0
	local var_14_2 = 0

	for iter_14_0 = 1, #arg_14_0.friendLessConfig.configDict do
		var_14_0 = var_14_0 + arg_14_0.friendLessConfig.configDict[iter_14_0].friendliness

		if arg_14_1 <= var_14_0 then
			if var_14_0 == arg_14_1 then
				var_14_1 = arg_14_0.friendLessConfig.configDict[iter_14_0].percentage
				var_14_2 = arg_14_0.friendLessConfig.configDict[iter_14_0 + 1].friendliness

				break
			end

			var_14_1 = arg_14_0.friendLessConfig.configDict[iter_14_0 - 1].percentage
			var_14_2 = var_14_0 - arg_14_1

			break
		end
	end

	return {
		var_14_1 / 100,
		var_14_2
	}
end

function var_0_0.getMaxRank(arg_15_0, arg_15_1)
	if arg_15_1 <= 3 then
		return 2
	else
		return 3
	end
end

function var_0_0.getLevelUpItems(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = {}
	local var_16_1 = arg_16_0:getHeroCO(arg_16_1)

	for iter_16_0 = arg_16_2 + 1, arg_16_3 do
		local var_16_2 = SkillConfig.instance:getcosumeCO(iter_16_0, var_16_1.rare).cosume
		local var_16_3 = string.split(var_16_2, "|")

		for iter_16_1 = 1, #var_16_3 do
			local var_16_4 = string.split(var_16_3[iter_16_1], "#")

			if not var_16_0[iter_16_1] then
				local var_16_5 = {
					type = tonumber(var_16_4[1]),
					id = tonumber(var_16_4[2]),
					quantity = tonumber(var_16_4[3])
				}

				var_16_5.name = ""
				var_16_0[iter_16_1] = var_16_5
			else
				var_16_0[iter_16_1].quantity = var_16_0[iter_16_1].quantity + tonumber(var_16_4[3])
			end
		end
	end

	return var_16_0
end

function var_0_0.getShowLevel(arg_17_0, arg_17_1)
	if not arg_17_0._rankMaxLevels then
		local var_17_0 = CommonConfig.instance:getConstStr(ConstEnum.RankMaxLevel)

		arg_17_0._rankMaxLevels = string.splitToNumber(var_17_0, "#")
	end

	local var_17_1

	for iter_17_0 = #arg_17_0._rankMaxLevels, 1, -1 do
		local var_17_2 = arg_17_0._rankMaxLevels[iter_17_0]

		if var_17_2 < arg_17_1 then
			return arg_17_1 - var_17_2, iter_17_0 + 1
		end
	end

	return arg_17_1, 1
end

function var_0_0.getCommonLevelDisplay(arg_18_0, arg_18_1)
	local var_18_0, var_18_1 = arg_18_0:getShowLevel(arg_18_1)

	if var_18_1 == 1 then
		return string.format(luaLang("rank_level_display1"), var_18_0)
	elseif var_18_1 == 2 then
		return string.format(luaLang("rank_level_display2"), var_18_0)
	elseif var_18_1 == 3 then
		return string.format(luaLang("rank_level_display3"), var_18_0)
	elseif var_18_1 == 4 then
		return string.format(luaLang("rank_level_display4"), var_18_0)
	else
		return string.format(luaLang("rank_level_display1"), var_18_0)
	end
end

function var_0_0.getLevelDisplayVariant(arg_19_0, arg_19_1)
	if arg_19_1 == 0 then
		return luaLang("hero_display_level0_variant")
	end

	local var_19_0, var_19_1 = arg_19_0:getShowLevel(arg_19_1)

	if var_19_1 == 1 then
		return string.format(luaLang("rank_level_display1"), var_19_0)
	elseif var_19_1 == 2 then
		return string.format(luaLang("rank_level_display2"), var_19_0)
	elseif var_19_1 == 3 then
		return string.format(luaLang("rank_level_display3"), var_19_0)
	elseif var_19_1 == 4 then
		return string.format(luaLang("rank_level_display4"), var_19_0)
	else
		return string.format(luaLang("rank_level_display1"), var_19_0)
	end
end

function var_0_0.processAttrConfig(arg_20_0)
	arg_20_0.attrConfigByAttrType = {}

	for iter_20_0, iter_20_1 in pairs(arg_20_0.attributeConfig.configDict) do
		arg_20_0.attrConfigByAttrType[iter_20_1.attrType] = iter_20_1.id
	end

	arg_20_0.attrConfigByAttrType.atk = 102
	arg_20_0.attrConfigByAttrType.def = 103
	arg_20_0.attrConfigByAttrType.mdef = 104
	arg_20_0.attrConfigByAttrType.cri_dmg = 203
	arg_20_0.attrConfigByAttrType.cri_def = 204
	arg_20_0.attrConfigByAttrType.add_dmg = 205
	arg_20_0.attrConfigByAttrType.drop_dmg = 206
end

function var_0_0.getIDByAttrType(arg_21_0, arg_21_1)
	return arg_21_0.attrConfigByAttrType[arg_21_1]
end

function var_0_0.getAttrTypeByID(arg_22_0, arg_22_1)
	return arg_22_0.attributeConfig.configDict[arg_22_1] and arg_22_0.attributeConfig.configDict[arg_22_1].attrType
end

function var_0_0.talentGainTab2IDTab(arg_23_0, arg_23_1)
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in pairs(arg_23_1) do
		local var_23_1 = arg_23_0:getIDByAttrType(iter_23_0)

		var_23_0[var_23_1] = {}
		var_23_0[var_23_1].config_id = var_23_1
		var_23_0[var_23_1].id = var_23_1
		var_23_0[var_23_1].value = iter_23_1.value
	end

	return var_23_0
end

function var_0_0.getHeroesList(arg_24_0)
	local var_24_0 = {}
	local var_24_1 = ResSplitConfig.instance:getAllCharacterIds()
	local var_24_2 = VersionValidator.instance:isInReviewing()

	for iter_24_0, iter_24_1 in ipairs(arg_24_0.heroConfig.configList) do
		if tonumber(iter_24_1.isOnline) == 1 and (var_24_2 == false or var_24_1[iter_24_1.id]) then
			table.insert(var_24_0, iter_24_1)
		end
	end

	return var_24_0
end

function var_0_0.getHeroesByType(arg_25_0, arg_25_1)
	local var_25_0 = {}
	local var_25_1 = ResSplitConfig.instance:getAllCharacterIds()
	local var_25_2 = VersionValidator.instance:isInReviewing()

	for iter_25_0, iter_25_1 in ipairs(arg_25_0.heroConfig.configList) do
		if tonumber(iter_25_1.isOnline) == 1 and iter_25_1.heroType == arg_25_1 and (var_25_2 == false or var_25_1[iter_25_1.id]) then
			table.insert(var_25_0, iter_25_1)
		end
	end

	return var_25_0
end

function var_0_0.sortAttr(arg_26_0, arg_26_1)
	return var_0_0.instance:getIDByAttrType(arg_26_0.key or arg_26_0.attrType) < var_0_0.instance:getIDByAttrType(arg_26_1.key or arg_26_1.attrType)
end

local var_0_1 = {
	mdef = 4,
	def = 3,
	hp = 2,
	atk = 1
}

function var_0_0.sortAttrForEquipView(arg_27_0, arg_27_1)
	return var_0_1[arg_27_0.attrType] < var_0_1[arg_27_1.attrType]
end

function var_0_0.getHeroAttrRate(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = SkillConfig.instance:getherolevelCO(arg_28_1, 1)

	for iter_28_0, iter_28_1 in ipairs(lua_character_grow.configList) do
		if var_28_0[arg_28_2] < iter_28_1[arg_28_2] then
			return iter_28_1.id - 1 == 0 and 1 or iter_28_1.id - 1
		end
	end

	return lua_character_grow.configList[#lua_character_grow.configList].id
end

var_0_0.instance = var_0_0.New()

return var_0_0
