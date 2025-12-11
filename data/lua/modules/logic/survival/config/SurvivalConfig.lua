module("modules.logic.survival.config.SurvivalConfig", package.seeall)

local var_0_0 = class("SurvivalConfig", BaseConfig)

function var_0_0.onInit(arg_1_0)
	arg_1_0._allMapCo = {}
	arg_1_0._allShelterCo = {}
	arg_1_0.attrNameToId = {}
	arg_1_0.npcIdToItemCo = {}
	arg_1_0._npcConfigTags = {}
	arg_1_0._npcConfigShowTags = {}
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.reqConfigNames(arg_3_0)
	return {
		"survival_behavior",
		"survival_booster",
		"survival_building",
		"survival_equip_effect",
		"survival_const",
		"survival_map_group",
		"survival_shelter_intrude_fight",
		"survival_decree",
		"survival_equip",
		"survival_equip_found",
		"survival_equip_slot",
		"survival_fight",
		"survival_fight_level",
		"survival_found",
		"survival_hardness",
		"survival_hardness_mod",
		"survival_item",
		"survival_maintask",
		"survival_talent",
		"survival_map_group_mapping",
		"survival_mission",
		"survival_normaltask",
		"survival_npc",
		"survival_recruitment",
		"survival_report",
		"survival_search",
		"survival_shelter",
		"survival_shelter_invasion",
		"survival_shelter_invasion_fight",
		"survival_shelter_invasion_scheme",
		"survival_shelter_monster_act",
		"survival_storytask",
		"survival_subtask",
		"survival_tag",
		"survival_tag_type",
		"survival_talk",
		"survival_tree_desc",
		"survival_attr",
		"survival_shelter_intrude_scheme",
		"survival_recruit",
		"survival_reward",
		"survival_shop_item",
		"survival_end",
		"survival_equip_score",
		"survival_block",
		"survival_reputation",
		"survival_disaster",
		"survival_rain",
		"survival_maptarget",
		"survival_shop",
		"survival_shop_type"
	}
end

function var_0_0.onConfigLoaded(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == "survival_attr" then
		for iter_4_0, iter_4_1 in ipairs(arg_4_2.configList) do
			arg_4_0.attrNameToId[iter_4_1.flag] = iter_4_1.id
		end
	elseif arg_4_1 == "survival_item" then
		for iter_4_2, iter_4_3 in ipairs(arg_4_2.configList) do
			if iter_4_3.type == SurvivalEnum.ItemType.NPC then
				local var_4_0 = tonumber(iter_4_3.effect) or 0

				arg_4_0.npcIdToItemCo[var_4_0] = iter_4_3
			end
		end
	elseif arg_4_1 == "survival_fight" and isDebugBuild then
		for iter_4_4, iter_4_5 in pairs(arg_4_2.configList) do
			local var_4_1 = lua_battle.configDict[iter_4_5.battleId]

			if not var_4_1 then
				logError("战斗ID不存在" .. tostring(iter_4_5.battleId))
			elseif not string.nilorempty(var_4_1.trialHeros) then
				logError("探索内战斗配置了试用角色 " .. iter_4_5.id .. " >> " .. iter_4_5.battleId)
			end
		end
	end
end

function var_0_0.getBuildingConfig(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = lua_survival_building.configDict[arg_5_1]
	local var_5_1 = var_5_0 and var_5_0[arg_5_2]

	if not var_5_1 and not arg_5_3 then
		logError(string.format("SurvivalConfig BuildingConfig is nil, buildingId:%s, buildingLevel:%s", arg_5_1, arg_5_2))
	end

	return var_5_1
end

function var_0_0.getBuildingConfigByType(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(lua_survival_building.configList) do
		if iter_6_1.type == arg_6_1 then
			return iter_6_1
		end
	end
end

function var_0_0.getMapConfig(arg_7_0, arg_7_1)
	if not arg_7_0._allMapCo[arg_7_1] then
		local var_7_0 = addGlobalModule("modules.configs.survival.lua_survival_map_" .. tostring(arg_7_1), "lua_survival_map_" .. tostring(arg_7_1))
		local var_7_1 = SurvivalMapCo.New()

		var_7_1:init(var_7_0)

		arg_7_0._allMapCo[arg_7_1] = var_7_1
	end

	return arg_7_0._allMapCo[arg_7_1]
end

function var_0_0.getCurShelterMapId(arg_8_0)
	local var_8_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_8_1 = var_8_0 and var_8_0.shelterMapId or 10001

	if var_8_1 == 0 then
		var_8_1 = 10001
	end

	return var_8_1
end

function var_0_0.getShelterMapCo(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1 or arg_9_0:getCurShelterMapId()

	if not arg_9_0._allShelterCo[var_9_0] then
		local var_9_1 = addGlobalModule("modules.configs.survival.lua_survival_shelter_building_" .. tostring(var_9_0), "lua_survival_shelter_building_" .. tostring(var_9_0))

		arg_9_0._allShelterCo[var_9_0] = SurvivalShelterMapCo.New()

		arg_9_0._allShelterCo[var_9_0]:init(var_9_1)
	end

	return arg_9_0._allShelterCo[var_9_0]
end

function var_0_0.getConstValue(arg_10_0, arg_10_1)
	local var_10_0 = lua_survival_const.configDict[arg_10_1]

	if not var_10_0 then
		return "", ""
	end

	return var_10_0.value, var_10_0.value2
end

function var_0_0.getHighValueUnitSubTypes(arg_11_0)
	if not arg_11_0._highValueUnitSubType then
		local var_11_0 = arg_11_0:getConstValue(SurvivalEnum.ConstId.ShowEffectUnitSubTypes)

		arg_11_0._highValueUnitSubType = string.splitToNumber(var_11_0, "#") or {}
	end

	return arg_11_0._highValueUnitSubType
end

function var_0_0.getTaskCo(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0

	if arg_12_1 == SurvivalEnum.TaskModule.MainTask then
		var_12_0 = lua_survival_maintask.configDict[arg_12_2]
	elseif arg_12_1 == SurvivalEnum.TaskModule.SubTask then
		var_12_0 = lua_survival_subtask.configDict[arg_12_2]
	elseif arg_12_1 == SurvivalEnum.TaskModule.StoryTask then
		var_12_0 = lua_survival_storytask.configDict[arg_12_2]
	elseif arg_12_1 == SurvivalEnum.TaskModule.NormalTask then
		var_12_0 = lua_survival_normaltask.configDict[arg_12_2]
	elseif arg_12_1 == SurvivalEnum.TaskModule.MapMainTarget then
		var_12_0 = lua_survival_maptarget.configDict[arg_12_2]
	end

	if not var_12_0 then
		logError(string.format("SurvivalConfig:getTaskCo taskCo is nil, moduleId:%s, taskId:%s", arg_12_1, arg_12_2))
	end

	return var_12_0
end

function var_0_0.getShelterCfg(arg_13_0)
	local var_13_0 = SurvivalShelterModel.instance:getWeekInfo().shelterMapId

	return lua_survival_shelter.configDict[var_13_0]
end

function var_0_0.getShelterPlayerInitPos(arg_14_0, arg_14_1)
	local var_14_0 = lua_survival_shelter.configDict[arg_14_1]

	return var_14_0 and var_14_0.position
end

function var_0_0.getShelterIntrudeSchemeConfig(arg_15_0, arg_15_1)
	if arg_15_1 == nil then
		logError("SurvivalConfig:getShelterIntrudeSchemeConfig id is nil")
	end

	local var_15_0 = lua_survival_shelter_intrude_scheme.configDict[arg_15_1]

	if var_15_0 == nil then
		logError("SurvivalConfig:getShelterIntrudeSchemeConfig config is nil, id:" .. tostring(arg_15_1))
	end

	return var_15_0
end

function var_0_0.getNpcConfigTag(arg_16_0, arg_16_1)
	if not arg_16_0._npcConfigTags[arg_16_1] then
		local var_16_0 = arg_16_0:getNpcConfig(arg_16_1)

		if var_16_0 == nil then
			return {}, {}
		end

		local var_16_1 = var_16_0.tag
		local var_16_2 = string.splitToNumber(var_16_1, "#") or {}

		arg_16_0._npcConfigTags[arg_16_1] = var_16_2

		local var_16_3 = {}

		for iter_16_0, iter_16_1 in ipairs(var_16_2) do
			local var_16_4 = lua_survival_tag.configDict[iter_16_1]
			local var_16_5 = var_16_4 and var_16_4.beHidden
			local var_16_6 = false

			if not string.nilorempty(var_16_5) then
				local var_16_7 = string.splitToNumber(var_16_5, "#")

				for iter_16_2, iter_16_3 in ipairs(var_16_7) do
					if tabletool.indexOf(var_16_2, iter_16_3) then
						var_16_6 = true

						break
					end
				end
			end

			if not var_16_6 then
				table.insert(var_16_3, iter_16_1)
			end
		end

		arg_16_0._npcConfigShowTags[arg_16_1] = var_16_3
	end

	return arg_16_0._npcConfigTags[arg_16_1], arg_16_0._npcConfigShowTags[arg_16_1]
end

function var_0_0.getMonsterBuffConfigTag(arg_17_0, arg_17_1)
	return false
end

function var_0_0.getDecreeCo(arg_18_0, arg_18_1)
	local var_18_0 = lua_survival_decree.configDict[arg_18_1]

	if var_18_0 == nil then
		logError(string.format("decree config is nil id:%s", arg_18_1))
	end

	return var_18_0
end

function var_0_0.getTagCo(arg_19_0, arg_19_1)
	local var_19_0 = lua_survival_tag.configDict[arg_19_1]

	if var_19_0 == nil then
		logError(string.format("tag config is nil id:%s", arg_19_1))
	end

	return var_19_0
end

function var_0_0.getSplitTag(arg_20_0, arg_20_1)
	if string.nilorempty(arg_20_1) then
		return {}
	end

	return (string.splitToNumber(arg_20_1, "#"))
end

function var_0_0.getRewardList(arg_21_0)
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(lua_survival_reward.configList) do
		table.insert(var_21_0, iter_21_1)
	end

	return var_21_0
end

function var_0_0.saveLocalShelterEntityPosAndDir(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5)
	local var_22_0 = arg_22_0:getLocalShelterEntityPosKey(arg_22_1, arg_22_2, arg_22_3)

	PlayerPrefsHelper.setString(var_22_0, string.format("%s#%s#%s#%s", arg_22_4.q, arg_22_4.r, arg_22_4.s, arg_22_5))
end

function var_0_0.getLocalShelterEntityPosAndDir(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = arg_23_0:getLocalShelterEntityPosKey(arg_23_1, arg_23_2, arg_23_3)
	local var_23_1 = PlayerPrefsHelper.getString(var_23_0)

	if string.nilorempty(var_23_1) then
		return
	end

	local var_23_2 = string.splitToNumber(var_23_1, "#")
	local var_23_3 = SurvivalHexNode.New(var_23_2[1], var_23_2[2], var_23_2[3])
	local var_23_4 = var_23_2[4] or SurvivalEnum.Dir.Right

	return var_23_3, var_23_4
end

function var_0_0.getLocalShelterEntityPosKey(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	return (string.format("%s_shelter_entitypos_%s_%s_%s", PlayerModel.instance:getPlayinfo().userId, arg_24_1, arg_24_2, arg_24_3))
end

function var_0_0.getNpcConfig(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = lua_survival_npc.configDict[arg_25_1]

	if var_25_0 == nil and not arg_25_2 then
		logError(string.format("npc config is nil npcId:%s", arg_25_1))
	end

	return var_25_0
end

function var_0_0.getNpcRenown(arg_26_0, arg_26_1)
	if not arg_26_0.npcRenown then
		arg_26_0.npcRenown = {}
	end

	if not arg_26_0.npcRenown[arg_26_1] then
		local var_26_0 = lua_survival_npc.configDict[arg_26_1]

		if not string.nilorempty(var_26_0.renown) then
			arg_26_0.npcRenown[arg_26_1] = string.splitToNumber(var_26_0.renown, "#")
		end
	end

	return arg_26_0.npcRenown[arg_26_1]
end

function var_0_0.getNpcReputationValue(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0:getNpcRenown(arg_27_1)[2]

	return (SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.RenownChangeFix, var_27_0))
end

function var_0_0.getReputationCfgById(arg_28_0, arg_28_1, arg_28_2)
	return lua_survival_reputation.configDict[arg_28_1][arg_28_2]
end

function var_0_0.getReputationCost(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = lua_survival_reputation.configDict[arg_29_1][arg_29_2 + 1].cost

	return tonumber(var_29_0)
end

function var_0_0.getReputationMaxLevel(arg_30_0, arg_30_1)
	local var_30_0 = lua_survival_reputation.configDict[arg_30_1]
	local var_30_1 = 0

	for iter_30_0, iter_30_1 in pairs(var_30_0) do
		if var_30_1 < iter_30_0 then
			var_30_1 = iter_30_0
		end
	end

	return var_30_1
end

function var_0_0.getBuildReputationIcon(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = lua_survival_reputation.configDict[arg_31_1][arg_31_2]

	return SurvivalUnitIconHelper.instance:getRelationIcon(var_31_0.type)
end

function var_0_0.getShopFreeReward(arg_32_0, arg_32_1, arg_32_2)
	if arg_32_0.shopFreeReward == nil then
		arg_32_0:_parsReputation()
	end

	return arg_32_0.shopFreeReward[arg_32_1][arg_32_2]
end

function var_0_0._parsReputation(arg_33_0)
	local var_33_0 = lua_survival_reputation.configList

	arg_33_0.shopFreeReward = {}

	for iter_33_0, iter_33_1 in ipairs(var_33_0) do
		local var_33_1 = iter_33_1.reward
		local var_33_2 = string.match(var_33_1, "^item#(.+)$")

		if not string.nilorempty(var_33_2) then
			local var_33_3 = GameUtil.splitString2(var_33_2, true, "&", ":")

			if arg_33_0.shopFreeReward[iter_33_1.id] == nil then
				arg_33_0.shopFreeReward[iter_33_1.id] = {}
			end

			arg_33_0.shopFreeReward[iter_33_1.id][iter_33_1.lv] = var_33_3[1]
		end
	end
end

function var_0_0.getReputationRedDotType(arg_34_0, arg_34_1)
	if arg_34_1 == 31011201 then
		return RedDotEnum.DotNode.SurvivalReputationShop_3119
	elseif arg_34_1 == 31011202 then
		return RedDotEnum.DotNode.SurvivalReputationShop_3120
	elseif arg_34_1 == 31011203 then
		return RedDotEnum.DotNode.SurvivalReputationShop_3121
	elseif arg_34_1 == 31011204 then
		return RedDotEnum.DotNode.SurvivalReputationShop_3122
	end
end

function var_0_0.getShopType(arg_35_0, arg_35_1)
	return lua_survival_shop.configDict[arg_35_1].type
end

function var_0_0.getShopName(arg_36_0, arg_36_1)
	return lua_survival_shop.configDict[arg_36_1].name
end

function var_0_0.getShopItemUnlock(arg_37_0, arg_37_1)
	if arg_37_0.reputationShopItemUnlock == nil then
		arg_37_0:_parseShopItem()
	end

	return arg_37_0.reputationShopItemUnlock[arg_37_1]
end

function var_0_0.getShopItemsByLevel(arg_38_0, arg_38_1, arg_38_2)
	if arg_38_0.reputationShopLevelItems == nil then
		arg_38_0:_parseShopItem()
	end

	return arg_38_0.reputationShopLevelItems[arg_38_1][arg_38_2]
end

function var_0_0.getReputationItemMaxLevel(arg_39_0, arg_39_1)
	if arg_39_0.reputationShopLevelItems == nil then
		arg_39_0:_parseShopItem()
	end

	return #arg_39_0.reputationShopLevelItems[arg_39_1]
end

function var_0_0._parseShopItem(arg_40_0)
	arg_40_0.reputationShopItemUnlock = {}
	arg_40_0.reputationShopLevelItems = {}

	for iter_40_0, iter_40_1 in ipairs(lua_survival_shop_item.configList) do
		if not string.nilorempty(iter_40_1.unlock) then
			local var_40_0 = string.split(iter_40_1.unlock, "#")

			if var_40_0[1] == "reputation" then
				local var_40_1 = tonumber(var_40_0[2])
				local var_40_2 = tonumber(var_40_0[3])

				arg_40_0.reputationShopItemUnlock[iter_40_1.id] = {
					id = var_40_1,
					level = var_40_2
				}

				if arg_40_0.reputationShopLevelItems[var_40_1] == nil then
					arg_40_0.reputationShopLevelItems[var_40_1] = {}
				end

				if arg_40_0.reputationShopLevelItems[var_40_1][var_40_2] == nil then
					arg_40_0.reputationShopLevelItems[var_40_1][var_40_2] = {}
				end

				table.insert(arg_40_0.reputationShopLevelItems[var_40_1][var_40_2], iter_40_1)
			end
		end
	end
end

function var_0_0.getShopTabConfigs(arg_41_0)
	return lua_survival_shop_type.configList
end

function var_0_0.getHardnessCfg(arg_42_0)
	local var_42_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_42_1 = SurvivalModel.instance:getOutSideInfo()
	local var_42_2 = var_42_0 and var_42_0.difficulty or var_42_1.currMod

	return lua_survival_hardness_mod.configDict[var_42_2]
end

function var_0_0.parseEquip(arg_43_0)
	arg_43_0.equipGroup = {}

	for iter_43_0, iter_43_1 in ipairs(lua_survival_equip.configList) do
		local var_43_0 = iter_43_1.group

		if arg_43_0.equipGroup[var_43_0] == nil then
			arg_43_0.equipGroup[var_43_0] = {}
		end

		table.insert(arg_43_0.equipGroup[var_43_0], iter_43_1)
	end
end

function var_0_0.getEquipByGroup(arg_44_0, arg_44_1)
	if arg_44_0.equipGroup == nil then
		arg_44_0:parseEquip()
	end

	return arg_44_0.equipGroup[arg_44_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
