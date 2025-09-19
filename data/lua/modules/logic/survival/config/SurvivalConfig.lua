module("modules.logic.survival.config.SurvivalConfig", package.seeall)

local var_0_0 = class("SurvivalConfig", BaseConfig)

function var_0_0.onInit(arg_1_0)
	arg_1_0._allMapCo = {}
	arg_1_0._allShelterCo = {}
	arg_1_0._mapGroupIdToCopyCo = {}
	arg_1_0.attrNameToId = {}
	arg_1_0.npcIdToItemCo = {}
	arg_1_0.outTalentGroupCo = {}
	arg_1_0.talentCollectCos = {}
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
		"survival_collect",
		"survival_const",
		"survival_copy",
		"survival_shelter_intrude_fight",
		"survival_decree",
		"survival_decreetask",
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
		"survival_talent",
		"survival_talent_active_skill",
		"survival_talent_collect",
		"survival_talent_group",
		"survival_talk",
		"survival_tree_desc",
		"survival_attr",
		"survival_shelter_intrude_scheme",
		"survival_recruit",
		"survival_reward",
		"survival_shop_item",
		"survival_end",
		"survival_equip_score",
		"survival_shelter_intrude"
	}
end

function var_0_0.onConfigLoaded(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == "survival_copy" then
		for iter_4_0, iter_4_1 in ipairs(arg_4_2.configList) do
			arg_4_0._mapGroupIdToCopyCo[iter_4_1.mapGroup] = iter_4_1
		end
	elseif arg_4_1 == "survival_attr" then
		for iter_4_2, iter_4_3 in ipairs(arg_4_2.configList) do
			arg_4_0.attrNameToId[iter_4_3.flag] = iter_4_3.id
		end
	elseif arg_4_1 == "survival_item" then
		for iter_4_4, iter_4_5 in ipairs(arg_4_2.configList) do
			if iter_4_5.type == SurvivalEnum.ItemType.NPC then
				local var_4_0 = tonumber(iter_4_5.effect) or 0

				arg_4_0.npcIdToItemCo[var_4_0] = iter_4_5
			end
		end
	elseif arg_4_1 == "survival_talent" then
		for iter_4_6, iter_4_7 in ipairs(arg_4_2.configList) do
			if not arg_4_0.outTalentGroupCo[iter_4_7.groupId] then
				arg_4_0.outTalentGroupCo[iter_4_7.groupId] = {}
			end

			table.insert(arg_4_0.outTalentGroupCo[iter_4_7.groupId], iter_4_7)
		end
	elseif arg_4_1 == "survival_talent_collect" then
		for iter_4_8, iter_4_9 in ipairs(arg_4_2.configList) do
			if not arg_4_0.talentCollectCos[iter_4_9.groupId] then
				arg_4_0.talentCollectCos[iter_4_9.groupId] = {}
			end

			table.insert(arg_4_0.talentCollectCos[iter_4_9.groupId], iter_4_9)
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

function var_0_0.getShelterMapCo(arg_9_0)
	local var_9_0 = arg_9_0:getCurShelterMapId()

	if not arg_9_0._allShelterCo[var_9_0] then
		local var_9_1 = addGlobalModule("modules.configs.survival.lua_survival_shelter_building_" .. tostring(var_9_0), "lua_survival_shelter_building_" .. tostring(var_9_0))

		arg_9_0._allShelterCo[var_9_0] = SurvivalShelterMapCo.New()

		arg_9_0._allShelterCo[var_9_0]:init(var_9_1)
	end

	return arg_9_0._allShelterCo[var_9_0]
end

function var_0_0.getAllTalentCos(arg_10_0, arg_10_1)
	if not arg_10_0.outTalentGroupCo[arg_10_1] then
		return {}
	end

	return arg_10_0.outTalentGroupCo[arg_10_1]
end

function var_0_0.getAllTalentGroupCos(arg_11_0)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(lua_survival_talent_group.configList) do
		if iter_11_1.choose == 1 and SurvivalHelper.instance:isInSeasonAndVersion(iter_11_1) then
			table.insert(var_11_0, iter_11_1)
		end
	end

	return var_11_0
end

function var_0_0.getCopyCo(arg_12_0, arg_12_1)
	return arg_12_0._mapGroupIdToCopyCo[arg_12_1]
end

function var_0_0.getConstValue(arg_13_0, arg_13_1)
	local var_13_0 = lua_survival_const.configDict[arg_13_1]

	if not var_13_0 then
		return "", ""
	end

	return var_13_0.value, var_13_0.value2
end

function var_0_0.getHighValueUnitSubTypes(arg_14_0)
	if not arg_14_0._highValueUnitSubType then
		local var_14_0 = arg_14_0:getConstValue(SurvivalEnum.ConstId.ShowEffectUnitSubTypes)

		arg_14_0._highValueUnitSubType = string.splitToNumber(var_14_0, "#") or {}
	end

	return arg_14_0._highValueUnitSubType
end

function var_0_0.getTaskCo(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0

	if arg_15_1 == SurvivalEnum.TaskModule.MainTask then
		var_15_0 = lua_survival_maintask.configDict[arg_15_2]
	elseif arg_15_1 == SurvivalEnum.TaskModule.SubTask then
		var_15_0 = lua_survival_subtask.configDict[arg_15_2]
	elseif arg_15_1 == SurvivalEnum.TaskModule.StoryTask then
		var_15_0 = lua_survival_storytask.configDict[arg_15_2]
	elseif arg_15_1 == SurvivalEnum.TaskModule.NormalTask then
		var_15_0 = lua_survival_normaltask.configDict[arg_15_2]
	elseif arg_15_1 == SurvivalEnum.TaskModule.DecreeTask then
		var_15_0 = lua_survival_decreetask.configDict[arg_15_2]
	end

	if not var_15_0 then
		logError(string.format("SurvivalConfig:getTaskCo taskCo is nil, moduleId:%s, taskId:%s", arg_15_1, arg_15_2))
	end

	return var_15_0
end

function var_0_0.getShelterPlayerInitPos(arg_16_0, arg_16_1)
	local var_16_0 = lua_survival_shelter.configDict[arg_16_1]

	return var_16_0 and var_16_0.position
end

function var_0_0.getShelterIntrudeSchemeConfig(arg_17_0, arg_17_1)
	if arg_17_1 == nil then
		logError("SurvivalConfig:getShelterIntrudeSchemeConfig id is nil")
	end

	local var_17_0 = lua_survival_shelter_intrude_scheme.configDict[arg_17_1]

	if var_17_0 == nil then
		logError("SurvivalConfig:getShelterIntrudeSchemeConfig config is nil, id:" .. tostring(arg_17_1))
	end

	return var_17_0
end

function var_0_0.getNpcConfigTag(arg_18_0, arg_18_1)
	if not arg_18_0._npcConfigTags[arg_18_1] then
		local var_18_0 = arg_18_0:getNpcConfig(arg_18_1)

		if var_18_0 == nil then
			return {}, {}
		end

		local var_18_1 = var_18_0.tag
		local var_18_2 = string.splitToNumber(var_18_1, "#") or {}

		arg_18_0._npcConfigTags[arg_18_1] = var_18_2

		local var_18_3 = {}

		for iter_18_0, iter_18_1 in ipairs(var_18_2) do
			local var_18_4 = lua_survival_tag.configDict[iter_18_1]
			local var_18_5 = var_18_4 and var_18_4.beHidden
			local var_18_6 = false

			if not string.nilorempty(var_18_5) then
				local var_18_7 = string.splitToNumber(var_18_5, "#")

				for iter_18_2, iter_18_3 in ipairs(var_18_7) do
					if tabletool.indexOf(var_18_2, iter_18_3) then
						var_18_6 = true

						break
					end
				end
			end

			if not var_18_6 then
				table.insert(var_18_3, iter_18_1)
			end
		end

		arg_18_0._npcConfigShowTags[arg_18_1] = var_18_3
	end

	return arg_18_0._npcConfigTags[arg_18_1], arg_18_0._npcConfigShowTags[arg_18_1]
end

function var_0_0.getMonsterBuffConfigTag(arg_19_0, arg_19_1)
	if arg_19_0._monsterBuffConfigTags == nil then
		arg_19_0._monsterBuffConfigTags = {}
	end

	if arg_19_1 == nil then
		return {}
	end

	if not arg_19_0._monsterBuffConfigTags[arg_19_1] then
		local var_19_0 = arg_19_0:getShelterIntrudeSchemeConfig(arg_19_1)

		if var_19_0 == nil then
			logError("SurvivalConfig:getMonsterBuffConfigTag monsterBuffCo is nil, monsterBuffId:" .. tostring(arg_19_1))

			return
		end

		local var_19_1 = string.splitToNumber(var_19_0.tags, "#")

		arg_19_0._monsterBuffConfigTags[arg_19_1] = var_19_1
	end

	return arg_19_0._monsterBuffConfigTags[arg_19_1]
end

function var_0_0.getDecreeCo(arg_20_0, arg_20_1)
	local var_20_0 = lua_survival_decree.configDict[arg_20_1]

	if var_20_0 == nil then
		logError(string.format("decree config is nil id:%s", arg_20_1))
	end

	return var_20_0
end

function var_0_0.getTagCo(arg_21_0, arg_21_1)
	local var_21_0 = lua_survival_tag.configDict[arg_21_1]

	if var_21_0 == nil then
		logError(string.format("tag config is nil id:%s", arg_21_1))
	end

	return var_21_0
end

function var_0_0.getSplitTag(arg_22_0, arg_22_1)
	if string.nilorempty(arg_22_1) then
		return {}
	end

	return (string.splitToNumber(arg_22_1, "#"))
end

function var_0_0.getRewardList(arg_23_0)
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in ipairs(lua_survival_reward.configList) do
		table.insert(var_23_0, iter_23_1)
	end

	return var_23_0
end

function var_0_0.saveLocalShelterEntityPosAndDir(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5)
	local var_24_0 = arg_24_0:getLocalShelterEntityPosKey(arg_24_1, arg_24_2, arg_24_3)

	PlayerPrefsHelper.setString(var_24_0, string.format("%s#%s#%s#%s", arg_24_4.q, arg_24_4.r, arg_24_4.s, arg_24_5))
end

function var_0_0.getLocalShelterEntityPosAndDir(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = arg_25_0:getLocalShelterEntityPosKey(arg_25_1, arg_25_2, arg_25_3)
	local var_25_1 = PlayerPrefsHelper.getString(var_25_0)

	if string.nilorempty(var_25_1) then
		return
	end

	local var_25_2 = string.splitToNumber(var_25_1, "#")
	local var_25_3 = SurvivalHexNode.New(var_25_2[1], var_25_2[2], var_25_2[3])
	local var_25_4 = var_25_2[4] or SurvivalEnum.Dir.Right

	return var_25_3, var_25_4
end

function var_0_0.getLocalShelterEntityPosKey(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	return (string.format("%s_shelter_entitypos_%s_%s_%s", PlayerModel.instance:getPlayinfo().userId, arg_26_1, arg_26_2, arg_26_3))
end

function var_0_0.getNpcConfig(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = lua_survival_npc.configDict[arg_27_1]

	if var_27_0 == nil and not arg_27_2 then
		logError(string.format("npc config is nil npcId:%s", arg_27_1))
	end

	return var_27_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
