module("modules.logic.sp01.assassin2.config.AssassinConfig", package.seeall)

local var_0_0 = class("AssassinConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"assassin_const",
		"assassin_library",
		"assassin_building",
		"assassin_map",
		"assassin_quest_type",
		"assassin_quest",
		"assassin_item",
		"assassin_career",
		"assassin_hero_trial",
		"assassin_career_skill_mapping",
		"assassin_stealth_const",
		"assassin_stealth_map",
		"assassin_stealth_map_grid",
		"assassin_stealth_map_grid_type",
		"assassin_stealth_map_wall",
		"assassin_stealth_map_point_comp_type",
		"assassin_stealth_mission",
		"assassin_act",
		"assassin_interactive",
		"assassin_stealth_refresh",
		"assassin_monster_group",
		"assassin_monster",
		"assassin_random",
		"assassin_buff",
		"assassin_trap",
		"assassin_task",
		"assassin_effect",
		"stealth_technique"
	}
end

function var_0_0.onConfigLoaded(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0[string.format("%sConfigLoaded", arg_2_1)]

	if var_2_0 then
		var_2_0(arg_2_0, arg_2_2)
	end
end

function var_0_0.assassin_constConfigLoaded(arg_3_0, arg_3_1)
	arg_3_0._pointPosList = {}
	arg_3_0._gridMaxPointCount = nil

	local var_3_0 = arg_3_1.configDict[AssassinEnum.ConstId.StealthGameGridPoint]

	if var_3_0 then
		local var_3_1 = GameUtil.splitString2(var_3_0.value, true)

		for iter_3_0, iter_3_1 in ipairs(var_3_1) do
			arg_3_0._pointPosList[iter_3_0] = {
				x = iter_3_1[1],
				y = iter_3_1[2]
			}
		end
	end

	arg_3_0._gridMaxPointCount = #arg_3_0._pointPosList
end

function var_0_0.assassin_buildingConfigLoaded(arg_4_0, arg_4_1)
	arg_4_0._typeBuildingDict = {}
	arg_4_0._buidlingEffectDict = {}
	arg_4_0._buildingLvCostDict = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.configList) do
		local var_4_0 = iter_4_1.type
		local var_4_1 = iter_4_1.level

		arg_4_0._typeBuildingDict[var_4_0] = arg_4_0._typeBuildingDict[var_4_0] or {}
		arg_4_0._typeBuildingDict[var_4_0][var_4_1] = iter_4_1
	end
end

local function var_0_1(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0[arg_5_1]

	if not var_5_0 then
		var_5_0 = {}
		arg_5_0[arg_5_1] = var_5_0
	end

	return var_5_0
end

function var_0_0.assassin_questConfigLoaded(arg_6_0, arg_6_1)
	arg_6_0._mapId2QuestCfgDict = {}
	arg_6_0._episode2QuestDict = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1.configList) do
		local var_6_0 = iter_6_1.mapId
		local var_6_1 = var_0_1(arg_6_0._mapId2QuestCfgDict, var_6_0)

		table.insert(var_6_1, iter_6_1)

		if iter_6_1.type == AssassinEnum.QuestType.Fight then
			arg_6_0._episode2QuestDict[tonumber(iter_6_1.param)] = iter_6_1.id
		end
	end
end

function var_0_0.assassin_libraryConfigLoaded(arg_7_0, arg_7_1)
	arg_7_0._actLibraryDict = {}
	arg_7_0._libraryTypeDict = {}
	arg_7_0._libraryActIdList = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1.configList) do
		local var_7_0 = iter_7_1.activityId
		local var_7_1 = iter_7_1.type
		local var_7_2 = arg_7_0._actLibraryDict[var_7_0]

		if not var_7_2 then
			var_7_2 = {}
			arg_7_0._actLibraryDict[var_7_0] = var_7_2
			arg_7_0._libraryTypeDict[var_7_0] = {}

			table.insert(arg_7_0._libraryActIdList, var_7_0)
		end

		local var_7_3 = var_7_2[var_7_1]

		if not var_7_3 then
			var_7_3 = {}
			var_7_2[var_7_1] = var_7_3

			table.insert(arg_7_0._libraryTypeDict[var_7_0], var_7_1)
		end

		table.insert(var_7_3, iter_7_1)
	end

	for iter_7_2, iter_7_3 in pairs(arg_7_0._libraryTypeDict) do
		table.sort(iter_7_3, function(arg_8_0, arg_8_1)
			return arg_8_0 < arg_8_1
		end)
	end
end

function var_0_0.assassin_itemConfigLoaded(arg_9_0, arg_9_1)
	arg_9_0._itemTypeDict = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_1.configList) do
		local var_9_0 = iter_9_1.itemType

		var_0_1(arg_9_0._itemTypeDict, var_9_0)[iter_9_1.level] = iter_9_1.itemId
	end
end

function var_0_0.assassin_hero_trialConfigLoaded(arg_10_0, arg_10_1)
	arg_10_0._quest2HeroIdDict = {}
	arg_10_0._careerUnlockDict = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1.configList) do
		local var_10_0 = iter_10_1.career
		local var_10_1 = var_0_1(arg_10_0._careerUnlockDict, var_10_0)

		var_10_1[#var_10_1 + 1] = iter_10_1.assassinHeroId

		if not string.nilorempty(iter_10_1.unlock) then
			local var_10_2 = string.split(iter_10_1.unlock, "#")
			local var_10_3 = tonumber(var_10_2[2])

			arg_10_0._quest2HeroIdDict[var_10_3] = iter_10_1.assassinHeroId
		end
	end
end

function var_0_0.assassin_career_skill_mappingConfigLoaded(arg_11_0, arg_11_1)
	arg_11_0.heroCareerSkillDict = {}
	arg_11_0.heroCareerPassiveSkillDict = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1.configList) do
		local var_11_0 = iter_11_1.assassinHeroId
		local var_11_1 = iter_11_1.careerId
		local var_11_2

		if iter_11_1.type == "Passive" then
			var_11_2 = var_0_1(arg_11_0.heroCareerPassiveSkillDict, var_11_0)
		else
			var_11_2 = var_0_1(arg_11_0.heroCareerSkillDict, var_11_0)
		end

		var_11_2[var_11_1] = iter_11_1.id
	end
end

function var_0_0.assassin_stealth_map_gridConfigLoaded(arg_12_0, arg_12_1)
	arg_12_0.mapGridPointDict = {}
	arg_12_0.mapGridPointTypeShow = {}
	arg_12_0.mapGridEntranceDict = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1.configList) do
		local var_12_0 = iter_12_1.mapId
		local var_12_1 = iter_12_1.gridId
		local var_12_2 = iter_12_1.point
		local var_12_3 = iter_12_1.pointShow

		if not string.nilorempty(var_12_2) then
			local var_12_4 = var_0_1(arg_12_0.mapGridPointDict, var_12_0)
			local var_12_5 = {}

			var_12_4[var_12_1] = var_12_5

			local var_12_6 = string.split(var_12_2, "|")

			for iter_12_2, iter_12_3 in ipairs(var_12_6) do
				local var_12_7 = string.split(iter_12_3, "#")

				var_12_5[tonumber(var_12_7[1])] = {
					pointType = tonumber(var_12_7[2]),
					pointParam = var_12_7[3]
				}
			end
		end

		if not string.nilorempty(var_12_3) then
			local var_12_8 = var_0_1(arg_12_0.mapGridPointTypeShow, var_12_0)
			local var_12_9 = {}

			var_12_8[var_12_1] = var_12_9

			local var_12_10 = string.split(var_12_3, "|")

			for iter_12_4, iter_12_5 in ipairs(var_12_10) do
				local var_12_11 = string.split(iter_12_5, "#")

				var_12_9[tonumber(var_12_11[1])] = {
					showImg = var_12_11[2],
					rotation = tonumber(var_12_11[3])
				}
			end
		end

		local var_12_12 = iter_12_1.gridParam

		if iter_12_1.gridType == AssassinEnum.StealthGameGridType.Roof and not string.nilorempty(var_12_12) then
			local var_12_13 = var_0_1(arg_12_0.mapGridEntranceDict, var_12_0)
			local var_12_14 = string.splitToNumber(var_12_12, "#")

			for iter_12_6, iter_12_7 in ipairs(var_12_14) do
				var_12_13[#var_12_13 + 1] = {
					gridId = var_12_1,
					dir = iter_12_7
				}
			end
		end
	end
end

function var_0_0.assassin_monster_groupConfigLoaded(arg_13_0, arg_13_1)
	arg_13_0._enemyRefreshGroupDict = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_1.configList) do
		local var_13_0 = iter_13_1.group
		local var_13_1 = arg_13_0._enemyRefreshGroupDict[var_13_0]

		if not var_13_1 then
			var_13_1 = {}
			arg_13_0._enemyRefreshGroupDict[var_13_0] = var_13_1
		end

		var_13_1[#var_13_1 + 1] = iter_13_1
	end
end

function var_0_0.stealth_techniqueConfigLoaded(arg_14_0, arg_14_1)
	arg_14_0._mapShowTechniqueDict = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_1.configList) do
		local var_14_0 = iter_14_1.showInMap
		local var_14_1 = arg_14_0._mapShowTechniqueDict[var_14_0]

		if not var_14_1 then
			var_14_1 = {}
			arg_14_0._mapShowTechniqueDict[var_14_0] = var_14_1
		end

		var_14_1[#var_14_1 + 1] = iter_14_1.id
	end
end

function var_0_0.getSkillPropTargetType(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0

	if arg_15_2 then
		var_15_0 = arg_15_0:getAssassinSkillTarget(arg_15_1)
	else
		var_15_0 = arg_15_0:getAssassinItemTarget(arg_15_1)
	end

	return var_15_0
end

function var_0_0.getAssassinConstCfg(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = lua_assassin_const.configDict[arg_16_1]

	if not var_16_0 and arg_16_2 then
		logError(string.format("AssassinConfig:getAssassinConstCfg error, cfg is nil, constId:%s", arg_16_1))
	end

	return var_16_0
end

function var_0_0.getAssassinConst(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0
	local var_17_1 = arg_17_0:getAssassinConstCfg(arg_17_1, true)

	if var_17_1 then
		var_17_0 = var_17_1.value

		if arg_17_2 then
			var_17_0 = tonumber(var_17_0)
		end
	end

	return var_17_0
end

function var_0_0.getGridPointPosList(arg_18_0)
	return arg_18_0._pointPosList
end

function var_0_0.getGridMaxPointCount(arg_19_0)
	return arg_19_0._gridMaxPointCount
end

function var_0_0.getAssassinStealthConstCfg(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = lua_assassin_stealth_const.configDict[arg_20_1]

	if not var_20_0 and arg_20_2 then
		logError(string.format("AssassinConfig:getAssassinStealthConstCfg error, cfg is nil, constId:%s", arg_20_1))
	end

	return var_20_0
end

function var_0_0.getAssassinStealthConst(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0
	local var_21_1 = arg_21_0:getAssassinStealthConstCfg(arg_21_1, true)

	if var_21_1 then
		var_21_0 = var_21_1.value

		if arg_21_2 then
			var_21_0 = tonumber(var_21_0)
		end
	end

	return var_21_0
end

function var_0_0.getMapCfg(arg_22_0, arg_22_1)
	local var_22_0 = lua_assassin_map.configDict[arg_22_1]

	if not var_22_0 then
		logError(string.format("AssassinConfig:getMapCfg error, cfg is nil, mapId = %s", arg_22_1))
	end

	return var_22_0
end

function var_0_0.getMapIdList(arg_23_0)
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in ipairs(lua_assassin_map.configList) do
		var_23_0[#var_23_0 + 1] = iter_23_1.id
	end

	return var_23_0
end

function var_0_0.getMapTitle(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:getMapCfg(arg_24_1)

	return var_24_0 and var_24_0.title or ""
end

function var_0_0.getMapBg(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:getMapCfg(arg_25_1)

	return var_25_0 and var_25_0.bg
end

function var_0_0.getMapCenterPos(arg_26_0, arg_26_1)
	local var_26_0 = 0
	local var_26_1 = 0
	local var_26_2 = arg_26_0:getMapCfg(arg_26_1)

	if var_26_2 and not string.nilorempty(var_26_2.bgCenter) then
		local var_26_3 = string.splitToNumber(var_26_2.bgCenter, "#")

		var_26_0 = var_26_3[1] or var_26_0
		var_26_1 = var_26_3[2] or var_26_1
	end

	return var_26_0, var_26_1
end

function var_0_0.getQuestTypeCfg(arg_27_0, arg_27_1)
	local var_27_0 = lua_assassin_quest_type.configDict[arg_27_1]

	if not var_27_0 then
		logError(string.format("AssassinConfig.getQuestTypeCfg error cfg is nil, type:%s", arg_27_1))
	end

	return var_27_0
end

function var_0_0.getQuestTypeList(arg_28_0)
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in ipairs(lua_assassin_quest_type.configList) do
		var_28_0[#var_28_0 + 1] = iter_28_1.type
	end

	return var_28_0
end

function var_0_0.getQuestTypeName(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:getQuestTypeCfg(arg_29_1)

	return var_29_0 and var_29_0.name or ""
end

function var_0_0.getQuestTypeIcon(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0:getQuestTypeCfg(arg_30_1)

	return var_30_0 and var_30_0.icon
end

function var_0_0.getQuestCfg(arg_31_0, arg_31_1)
	local var_31_0 = lua_assassin_quest.configDict[arg_31_1]

	if not var_31_0 then
		logError(string.format("AssassinConfig:getQuestCfg error, cfg is nil, questId = %s", arg_31_1))
	end

	return var_31_0
end

function var_0_0.getQuestListInMap(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = {}
	local var_32_1 = arg_32_0._mapId2QuestCfgDict[arg_32_1]

	if var_32_1 then
		for iter_32_0, iter_32_1 in ipairs(var_32_1) do
			if not arg_32_2 then
				var_32_0[#var_32_0 + 1] = iter_32_1
			elseif arg_32_2 == iter_32_1.type then
				var_32_0[#var_32_0 + 1] = iter_32_1
			end
		end
	else
		logError(string.format("AssassinConfig:getQuestListInMap, map not has quest, mapId = %s", arg_32_1))
	end

	return var_32_0
end

function var_0_0.getQuestName(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0:getQuestCfg(arg_33_1)

	return var_33_0 and var_33_0.title
end

function var_0_0.getQuestDesc(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0:getQuestCfg(arg_34_1)

	return var_34_0 and var_34_0.desc
end

function var_0_0.getQuestPicture(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0:getQuestCfg(arg_35_1)

	return var_35_0 and var_35_0.picture
end

function var_0_0.getQuestMapId(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0:getQuestCfg(arg_36_1)

	return var_36_0 and var_36_0.mapId
end

function var_0_0.getQuestPos(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0:getQuestCfg(arg_37_1)

	return var_37_0 and var_37_0.position
end

function var_0_0.getQuestType(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0:getQuestCfg(arg_38_1)

	return var_38_0 and var_38_0.type
end

function var_0_0.getQuestParam(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0:getQuestCfg(arg_39_1)

	return var_39_0 and var_39_0.param
end

function var_0_0.getQuestDisplay(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_0:getQuestCfg(arg_40_1)

	return var_40_0 and var_40_0.display
end

function var_0_0.getQuestRewardCount(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0:getQuestCfg(arg_41_1)

	return var_41_0 and var_41_0.rewardCount
end

function var_0_0.getQuestRecommendHeroList(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_0:getQuestCfg(arg_42_1)

	if var_42_0 and not string.nilorempty(var_42_0.recommend) then
		return string.splitToNumber(var_42_0.recommend, "#")
	end
end

function var_0_0.getFightQuestId(arg_43_0, arg_43_1)
	return arg_43_0._episode2QuestDict[arg_43_1]
end

function var_0_0.getHeroCfgByAssassinHeroId(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_0:getAssassinHeroCfg(arg_44_1, true)
	local var_44_1 = 0
	local var_44_2 = lua_hero_trial.configDict[var_44_0.model][var_44_1]

	if var_44_2 then
		return HeroConfig.instance:getHeroCO(var_44_2.heroId)
	end
end

function var_0_0.getAssassinItemCfg(arg_45_0, arg_45_1, arg_45_2)
	local var_45_0 = lua_assassin_item.configDict[arg_45_1]

	if not var_45_0 and arg_45_2 then
		logError(string.format("AssassinConfig:getAssassinItemCfg error, cfg is nil, itemId:%s", arg_45_1))
	end

	return var_45_0
end

function var_0_0.getAssassinItemId(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0
	local var_46_1 = arg_46_0._itemTypeDict[arg_46_1]

	if var_46_1 then
		var_46_0 = var_46_1[arg_46_2]
	end

	return var_46_0
end

function var_0_0.getAssassinItemType(arg_47_0, arg_47_1)
	local var_47_0 = arg_47_0:getAssassinItemCfg(arg_47_1, true)

	return var_47_0 and var_47_0.itemType
end

function var_0_0.getAssassinItemLevel(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_0:getAssassinItemCfg(arg_48_1, true)

	return var_48_0 and var_48_0.level
end

function var_0_0.getAssassinItemName(arg_49_0, arg_49_1)
	local var_49_0 = arg_49_0:getAssassinItemCfg(arg_49_1, true)

	return var_49_0 and var_49_0.name
end

function var_0_0.getAssassinItemIcon(arg_50_0, arg_50_1)
	local var_50_0 = arg_50_0:getAssassinItemCfg(arg_50_1, true)

	return var_50_0 and var_50_0.icon
end

function var_0_0.getAssassinItemFightEffDesc(arg_51_0, arg_51_1)
	local var_51_0 = arg_51_0:getAssassinItemCfg(arg_51_1, true)

	return var_51_0 and var_51_0.fightEffDesc
end

function var_0_0.getAssassinItemStealthEffDesc(arg_52_0, arg_52_1)
	local var_52_0 = arg_52_0:getAssassinItemCfg(arg_52_1, true)

	return var_52_0 and var_52_0.stealthEffDesc
end

function var_0_0.getAssassinItemRoundLimit(arg_53_0, arg_53_1)
	local var_53_0 = arg_53_0:getAssassinItemCfg(arg_53_1, true)

	return var_53_0 and var_53_0.roundLimit or 0
end

function var_0_0.getAssassinItemCostPoint(arg_54_0, arg_54_1)
	local var_54_0 = arg_54_0:getAssassinItemCfg(arg_54_1, true)

	return var_54_0 and var_54_0.costPoint or 0
end

function var_0_0.getAssassinItemRange(arg_55_0, arg_55_1)
	local var_55_0
	local var_55_1
	local var_55_2 = arg_55_0:getAssassinItemCfg(arg_55_1, true)
	local var_55_3 = var_55_2 and var_55_2.range

	if not string.nilorempty(var_55_3) then
		local var_55_4 = string.split(var_55_3, "#")

		var_55_0 = var_55_4[1]
		var_55_1 = var_55_4[2]
	end

	return var_55_0, var_55_1
end

function var_0_0.getAssassinItemTargetCheck(arg_56_0, arg_56_1)
	local var_56_0
	local var_56_1
	local var_56_2 = arg_56_0:getAssassinItemCfg(arg_56_1, true)
	local var_56_3 = var_56_2 and var_56_2.targetCheck

	if not string.nilorempty(var_56_3) then
		local var_56_4 = string.splitToNumber(var_56_3, "#")

		var_56_0 = var_56_4[1]
		var_56_1 = var_56_4[2]
	end

	return var_56_0, var_56_1
end

function var_0_0.getAssassinItemTarget(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_0:getAssassinItemCfg(arg_57_1, true)

	return var_57_0 and var_57_0.target
end

function var_0_0.getAssassinItemTargetEff(arg_58_0, arg_58_1)
	local var_58_0 = arg_58_0:getAssassinItemCfg(arg_58_1, true)

	return var_58_0 and var_58_0.targetEff
end

function var_0_0.getAssassinCareerCfg(arg_59_0, arg_59_1, arg_59_2)
	local var_59_0 = lua_assassin_career.configDict[arg_59_1]

	if not var_59_0 and arg_59_2 then
		logError(string.format("AssassinConfig:getAssassinCareerCfg error, cfg is nil, careerId:%s", arg_59_1))
	end

	return var_59_0
end

function var_0_0.getAssassinCareerTitle(arg_60_0, arg_60_1)
	local var_60_0 = arg_60_0:getAssassinCareerCfg(arg_60_1, true)

	return var_60_0 and var_60_0.title
end

function var_0_0.getAssassinCareerEquipName(arg_61_0, arg_61_1)
	local var_61_0 = arg_61_0:getAssassinCareerCfg(arg_61_1, true)

	return var_61_0 and var_61_0.equipName
end

function var_0_0.getAssassinCareerCapacity(arg_62_0, arg_62_1)
	local var_62_0 = arg_62_0:getAssassinCareerCfg(arg_62_1, true)

	return var_62_0 and var_62_0.capacity or 0
end

function var_0_0.getAssassinCareerAttrList(arg_63_0, arg_63_1)
	local var_63_0 = {}
	local var_63_1 = arg_63_0:getAssassinCareerCfg(arg_63_1, true)

	var_63_0 = var_63_1 and GameUtil.splitString2(var_63_1.attrs, true) or var_63_0

	return var_63_0
end

function var_0_0.getAssassinCareerEquipPic(arg_64_0, arg_64_1)
	local var_64_0 = arg_64_0:getAssassinCareerCfg(arg_64_1, true)

	return var_64_0 and var_64_0.pic
end

function var_0_0.getAssassinCareerUnlockNeedHeroList(arg_65_0, arg_65_1)
	return arg_65_0._careerUnlockDict[arg_65_1] or {}
end

function var_0_0.getAssassinHeroCfg(arg_66_0, arg_66_1, arg_66_2)
	local var_66_0 = lua_assassin_hero_trial.configDict[arg_66_1]

	if not var_66_0 and arg_66_2 then
		logError(string.format("AssassinConfig:getAssassinHeroCfg error, cfg is nil, assassinHeroId:%s", arg_66_1))
	end

	return var_66_0
end

function var_0_0.getAssassinHeroIdList(arg_67_0)
	local var_67_0 = {}

	for iter_67_0, iter_67_1 in ipairs(lua_assassin_hero_trial.configList) do
		var_67_0[#var_67_0 + 1] = iter_67_1.assassinHeroId
	end

	return var_67_0
end

function var_0_0.getAssassinHeroCareerList(arg_68_0, arg_68_1)
	local var_68_0 = {}
	local var_68_1 = arg_68_0:getAssassinHeroCfg(arg_68_1, true)

	if var_68_1 then
		var_68_0[#var_68_0 + 1] = var_68_1.career

		if var_68_1.secondCareer and var_68_1.secondCareer ~= 0 then
			var_68_0[#var_68_0 + 1] = var_68_1.secondCareer
		end
	end

	return var_68_0
end

function var_0_0.isAssassinHeroCanChangeToCareer(arg_69_0, arg_69_1, arg_69_2)
	local var_69_0 = false
	local var_69_1 = arg_69_0:getAssassinHeroCfg(arg_69_1, true)

	if var_69_1 then
		var_69_0 = arg_69_2 == var_69_1.career or arg_69_2 == var_69_1.secondCareer
	end

	return var_69_0
end

function var_0_0.isAssassinHeroHasSecondCareer(arg_70_0, arg_70_1)
	local var_70_0 = arg_70_0:getAssassinHeroCfg(arg_70_1, true)
	local var_70_1 = var_70_0 and var_70_0.secondCareer

	return var_70_1 and var_70_1 ~= 0 and true or false
end

function var_0_0.getAssassinHeroImg(arg_71_0, arg_71_1)
	local var_71_0 = arg_71_0:getAssassinHeroCfg(arg_71_1, true)

	return var_71_0 and var_71_0.heroImg
end

function var_0_0.getAssassinHeroIcon(arg_72_0, arg_72_1)
	local var_72_0 = arg_72_0:getAssassinHeroCfg(arg_72_1, true)

	return var_72_0 and var_72_0.heroIcon
end

function var_0_0.getAssassinHeroEntityIcon(arg_73_0, arg_73_1)
	local var_73_0 = arg_73_0:getAssassinHeroCfg(arg_73_1, true)

	return var_73_0 and var_73_0.entityIcon
end

function var_0_0.getAssassinHeroTrialId(arg_74_0, arg_74_1)
	local var_74_0 = arg_74_0:getAssassinHeroCfg(arg_74_1, true)

	return var_74_0 and var_74_0.model
end

function var_0_0.getAssassinHeroTrialCfg(arg_75_0, arg_75_1, arg_75_2)
	local var_75_0 = arg_75_0:getAssassinHeroTrialId(arg_75_1)
	local var_75_1 = lua_hero_trial.configDict[var_75_0][arg_75_2 or 0]

	if not var_75_1 then
		logError(string.format("AssassinConfig:getAssassinHeroTrialCfg error, cfg is nil, assassinHeroId:%s trialId:%s", arg_75_1, var_75_0))
	end

	return var_75_1
end

function var_0_0.getUnlockHeroId(arg_76_0, arg_76_1)
	return arg_76_0._quest2HeroIdDict[arg_76_1]
end

function var_0_0.getAssassinCareerSkillCfg(arg_77_0, arg_77_1, arg_77_2)
	local var_77_0 = lua_assassin_career_skill_mapping.configDict[arg_77_1]

	if not var_77_0 and arg_77_2 then
		logError(string.format("AssassinConfig:getAssassinCareerSkillCfg error, cfg is nil, skillId:%s", arg_77_1))
	end

	return var_77_0
end

function var_0_0.getAssassinSkillIdByHeroCareer(arg_78_0, arg_78_1, arg_78_2)
	return arg_78_0:getAssassinActiveSkillIdByHeroCareer(arg_78_1, arg_78_2) or arg_78_0:getAssassinPassiveSkillIdByHeroCareer(arg_78_1, arg_78_2)
end

function var_0_0.getAssassinActiveSkillIdByHeroCareer(arg_79_0, arg_79_1, arg_79_2)
	local var_79_0
	local var_79_1 = arg_79_0.heroCareerSkillDict and arg_79_0.heroCareerSkillDict[arg_79_1]

	if var_79_1 then
		var_79_0 = var_79_1[arg_79_2]
	end

	return var_79_0
end

function var_0_0.getAssassinPassiveSkillIdByHeroCareer(arg_80_0, arg_80_1, arg_80_2)
	local var_80_0
	local var_80_1 = arg_80_0.heroCareerPassiveSkillDict and arg_80_0.heroCareerPassiveSkillDict[arg_80_1]

	if var_80_1 then
		var_80_0 = var_80_1[arg_80_2]
	end

	return var_80_0
end

function var_0_0.getAssassinSkillName(arg_81_0, arg_81_1)
	local var_81_0 = arg_81_0:getAssassinCareerSkillCfg(arg_81_1, true)

	return var_81_0 and var_81_0.name
end

function var_0_0.getAssassinSkillIcon(arg_82_0, arg_82_1)
	local var_82_0 = arg_82_0:getAssassinCareerSkillCfg(arg_82_1, true)

	return var_82_0 and var_82_0.icon
end

function var_0_0.getAssassinCareerSkillDesc(arg_83_0, arg_83_1)
	local var_83_0 = arg_83_0:getAssassinCareerSkillCfg(arg_83_1, true)

	return var_83_0 and var_83_0.desc
end

function var_0_0.getIsStealthGameSkill(arg_84_0, arg_84_1)
	local var_84_0 = arg_84_0:getAssassinCareerSkillCfg(arg_84_1, true)
	local var_84_1 = var_84_0 and var_84_0.cost

	return not string.nilorempty(var_84_1)
end

function var_0_0.getAssassinSkillCost(arg_85_0, arg_85_1)
	local var_85_0
	local var_85_1
	local var_85_2 = arg_85_0:getAssassinCareerSkillCfg(arg_85_1, true)
	local var_85_3 = var_85_2 and var_85_2.cost

	if not string.nilorempty(var_85_3) then
		local var_85_4 = string.split(var_85_3, "#")

		var_85_0 = var_85_4[1]
		var_85_1 = tonumber(var_85_4[2])
	end

	return var_85_0, var_85_1
end

function var_0_0.getAssassinSkillRange(arg_86_0, arg_86_1)
	local var_86_0
	local var_86_1
	local var_86_2 = arg_86_0:getAssassinCareerSkillCfg(arg_86_1, true)
	local var_86_3 = var_86_2 and var_86_2.range

	if not string.nilorempty(var_86_3) then
		local var_86_4 = string.split(var_86_3, "#")

		var_86_0 = var_86_4[1]
		var_86_1 = var_86_4[2]
	end

	return var_86_0, var_86_1
end

function var_0_0.getAssassinSkillTargetCheck(arg_87_0, arg_87_1)
	local var_87_0
	local var_87_1
	local var_87_2 = arg_87_0:getAssassinCareerSkillCfg(arg_87_1, true)
	local var_87_3 = var_87_2 and var_87_2.targetCheck

	if not string.nilorempty(var_87_3) then
		local var_87_4 = string.splitToNumber(var_87_3, "#")

		var_87_0 = var_87_4[1]
		var_87_1 = var_87_4[2]
	end

	return var_87_0, var_87_1
end

function var_0_0.getAssassinSkillTarget(arg_88_0, arg_88_1)
	local var_88_0 = arg_88_0:getAssassinCareerSkillCfg(arg_88_1, true)

	return var_88_0 and var_88_0.target
end

function var_0_0.getAssassinSkillRoundLimit(arg_89_0, arg_89_1)
	local var_89_0 = arg_89_0:getAssassinCareerSkillCfg(arg_89_1, true)

	return var_89_0 and var_89_0.roundLimit
end

function var_0_0.getAssassinSkillTimesLimit(arg_90_0, arg_90_1)
	local var_90_0 = arg_90_0:getAssassinCareerSkillCfg(arg_90_1, true)

	return var_90_0 and var_90_0.timesLimit
end

function var_0_0.getAssassinSkillTargetEff(arg_91_0, arg_91_1)
	local var_91_0 = arg_91_0:getAssassinCareerSkillCfg(arg_91_1, true)

	return var_91_0 and var_91_0.targetEff
end

function var_0_0.getStealthMapCfg(arg_92_0, arg_92_1, arg_92_2)
	local var_92_0 = lua_assassin_stealth_map.configDict[arg_92_1]

	if not var_92_0 and arg_92_2 then
		logError(string.format("AssassinConfig:getStealthMapCfg error, cfg is nil, mapId:%s", arg_92_1))
	end

	return var_92_0
end

function var_0_0.getStealthMapTitle(arg_93_0, arg_93_1)
	local var_93_0 = arg_93_0:getStealthMapCfg(arg_93_1, true)

	return var_93_0 and var_93_0.title
end

function var_0_0.getStealthMapNeedHeroCount(arg_94_0, arg_94_1)
	local var_94_0 = arg_94_0:getStealthMapCfg(arg_94_1, true)

	return var_94_0 and var_94_0.player or 0
end

function var_0_0.getStealthMapMission(arg_95_0, arg_95_1)
	local var_95_0 = arg_95_0:getStealthMapCfg(arg_95_1, true)

	return var_95_0 and var_95_0.mission
end

function var_0_0.getStealthMapForbidScaleGuide(arg_96_0, arg_96_1)
	local var_96_0
	local var_96_1
	local var_96_2 = arg_96_0:getStealthMapCfg(arg_96_1, true)

	if var_96_2 then
		local var_96_3 = string.splitToNumber(var_96_2.forbidScaleGuide, "#")

		var_96_0 = var_96_3[1]
		var_96_1 = var_96_3[2]
	end

	return var_96_0, var_96_1
end

function var_0_0.getStealthGameMapGridCfg(arg_97_0, arg_97_1, arg_97_2, arg_97_3)
	local var_97_0 = lua_assassin_stealth_map_grid.configDict[arg_97_1] and lua_assassin_stealth_map_grid.configDict[arg_97_1][arg_97_2]

	if not var_97_0 and arg_97_3 then
		logError(string.format("AssassinConfig:getStealthGameMapGridCfg error, cfg is nil, mapId:%s, gridId:%s", arg_97_1, arg_97_2))
	end

	return var_97_0
end

function var_0_0.getStealthGameMapGridList(arg_98_0, arg_98_1)
	local var_98_0 = {}
	local var_98_1 = lua_assassin_stealth_map_grid and lua_assassin_stealth_map_grid.configDict[arg_98_1]

	if var_98_1 then
		for iter_98_0, iter_98_1 in pairs(var_98_1) do
			var_98_0[#var_98_0 + 1] = iter_98_0
		end
	end

	return var_98_0
end

function var_0_0.getStealthGameMapTowerGridList(arg_99_0, arg_99_1)
	local var_99_0 = {}
	local var_99_1 = lua_assassin_stealth_map_grid and lua_assassin_stealth_map_grid.configDict[arg_99_1]

	if var_99_1 then
		for iter_99_0, iter_99_1 in pairs(var_99_1) do
			if arg_99_0:getGridPointType(arg_99_1, iter_99_0, AssassinEnum.TowerPointIndex.RightTop) == AssassinEnum.StealthGamePointType.Tower then
				var_99_0[#var_99_0 + 1] = iter_99_0
			end
		end
	end

	return var_99_0
end

function var_0_0.isShowGrid(arg_100_0, arg_100_1, arg_100_2)
	return arg_100_0:getStealthGameMapGridCfg(arg_100_1, arg_100_2) and true or false
end

function var_0_0.getGridType(arg_101_0, arg_101_1, arg_101_2)
	local var_101_0 = arg_101_0:getStealthGameMapGridCfg(arg_101_1, arg_101_2, true)

	return var_101_0 and var_101_0.gridType
end

function var_0_0.getGridParam(arg_102_0, arg_102_1, arg_102_2)
	local var_102_0 = arg_102_0:getStealthGameMapGridCfg(arg_102_1, arg_102_2, true)

	return var_102_0 and var_102_0.gridParam
end

function var_0_0.getGridIsEasyExpose(arg_103_0, arg_103_1, arg_103_2)
	local var_103_0 = arg_103_0:getStealthGameMapGridCfg(arg_103_1, arg_103_2, true)

	return var_103_0 and var_103_0.easyExplore
end

function var_0_0.getGridPointType(arg_104_0, arg_104_1, arg_104_2, arg_104_3)
	local var_104_0

	if arg_104_0:isShowGrid(arg_104_1, arg_104_2) then
		var_104_0 = AssassinEnum.StealthGamePointType.Empty

		local var_104_1 = arg_104_0.mapGridPointDict[arg_104_1]
		local var_104_2 = var_104_1 and var_104_1[arg_104_2]
		local var_104_3 = var_104_2 and var_104_2[arg_104_3]

		if var_104_3 then
			var_104_0 = var_104_3.pointType
		end
	else
		logError(string.format("AssassinConfig:getGridPointType error, map not has grid, map:%s gridId:%s", arg_104_1, arg_104_2))
	end

	return var_104_0
end

function var_0_0.getGridPointTypeParam(arg_105_0, arg_105_1, arg_105_2, arg_105_3)
	local var_105_0
	local var_105_1 = arg_105_0.mapGridPointDict[arg_105_1]
	local var_105_2 = var_105_1 and var_105_1[arg_105_2]
	local var_105_3 = var_105_2 and var_105_2[arg_105_3]

	if var_105_3 then
		var_105_0 = var_105_3.pointParam
	end

	return var_105_0
end

function var_0_0.isGridHasPointType(arg_106_0, arg_106_1, arg_106_2, arg_106_3)
	local var_106_0 = false
	local var_106_1 = arg_106_0.mapGridPointDict[arg_106_1]
	local var_106_2 = var_106_1 and var_106_1[arg_106_2]

	if var_106_2 then
		for iter_106_0, iter_106_1 in pairs(var_106_2) do
			if iter_106_1.pointType == arg_106_3 then
				var_106_0 = true

				break
			end
		end
	end

	return var_106_0
end

function var_0_0.getGridPos(arg_107_0, arg_107_1, arg_107_2)
	local var_107_0 = arg_107_0:getStealthGameMapGridCfg(arg_107_1, arg_107_2, true)

	if var_107_0 then
		return var_107_0.x, var_107_0.y
	end
end

function var_0_0.getTowerGridDict(arg_108_0, arg_108_1, arg_108_2, arg_108_3)
	local var_108_0 = {}

	if arg_108_0:getGridPointType(arg_108_1, arg_108_2, arg_108_3) == AssassinEnum.StealthGamePointType.Tower then
		local var_108_1 = arg_108_0:getGridPointTypeParam(arg_108_1, arg_108_2, arg_108_3)

		if not string.nilorempty(var_108_1) then
			local var_108_2 = string.split(var_108_1, ",")

			for iter_108_0, iter_108_1 in ipairs(var_108_2) do
				var_108_0[tonumber(iter_108_1)] = true
			end
		end
	end

	return var_108_0
end

function var_0_0.getStealthGridImg(arg_109_0, arg_109_1, arg_109_2)
	local var_109_0 = arg_109_0:getStealthGameMapGridCfg(arg_109_1, arg_109_2, true)

	return var_109_0 and var_109_0.gridImg
end

function var_0_0.getStealthGridRotation(arg_110_0, arg_110_1, arg_110_2)
	local var_110_0 = arg_110_0:getStealthGameMapGridCfg(arg_110_1, arg_110_2, true)

	return var_110_0 and var_110_0.rotation
end

function var_0_0.getPointTypeShowData(arg_111_0, arg_111_1, arg_111_2, arg_111_3)
	local var_111_0
	local var_111_1 = 0
	local var_111_2 = arg_111_0.mapGridPointTypeShow[arg_111_1]
	local var_111_3 = var_111_2 and var_111_2[arg_111_2]
	local var_111_4 = var_111_3 and var_111_3[arg_111_3]

	if var_111_4 then
		var_111_0 = var_111_4.showImg
		var_111_1 = var_111_4.rotation or 0
	end

	if string.nilorempty(var_111_0) then
		local var_111_5 = arg_111_0:getGridPointType(arg_111_1, arg_111_2, arg_111_3)

		var_111_0 = arg_111_0:getPointTypeIcon(var_111_5)
	end

	return var_111_0, var_111_1
end

function var_0_0.getMapStairList(arg_112_0, arg_112_1)
	return arg_112_0.mapGridEntranceDict and arg_112_0.mapGridEntranceDict[arg_112_1] or {}
end

function var_0_0.getStealthGameMapWallCfg(arg_113_0, arg_113_1, arg_113_2, arg_113_3)
	local var_113_0 = lua_assassin_stealth_map_wall.configDict[arg_113_1] and lua_assassin_stealth_map_wall.configDict[arg_113_1][arg_113_2]

	if not var_113_0 and arg_113_3 then
		logError(string.format("AssassinConfig:getStealthGameMapWallCfg error, cfg is nil, mapId:%s, wallId:%s", arg_113_1, arg_113_2))
	end

	return var_113_0
end

function var_0_0.getStealthGameMapWallList(arg_114_0, arg_114_1, arg_114_2)
	local var_114_0 = {}
	local var_114_1 = lua_assassin_stealth_map_wall and lua_assassin_stealth_map_wall.configDict[arg_114_1]

	if var_114_1 then
		arg_114_2 = arg_114_2 and true or false

		for iter_114_0, iter_114_1 in pairs(var_114_1) do
			if iter_114_1.isHor == arg_114_2 then
				var_114_0[#var_114_0 + 1] = iter_114_0
			end
		end
	end

	return var_114_0
end

function var_0_0.isShowWall(arg_115_0, arg_115_1, arg_115_2)
	return arg_115_0:getStealthGameMapWallCfg(arg_115_1, arg_115_2) and true or false
end

function var_0_0.getWallPos(arg_116_0, arg_116_1, arg_116_2)
	local var_116_0 = arg_116_0:getStealthGameMapWallCfg(arg_116_1, arg_116_2, true)

	if var_116_0 then
		return var_116_0.x, var_116_0.y
	end
end

function var_0_0.getStealthGameMapGridTypeCfg(arg_117_0, arg_117_1, arg_117_2)
	local var_117_0 = lua_assassin_stealth_map_grid_type.configDict[arg_117_1]

	if not var_117_0 and arg_117_2 then
		logError(string.format("AssassinConfig:getStealthGameMapGridTypeCfg error, cfg is nil, gridType:%s", arg_117_1))
	end

	return var_117_0
end

function var_0_0.getStealthGameMapGridTypeName(arg_118_0, arg_118_1)
	local var_118_0 = arg_118_0:getStealthGameMapGridTypeCfg(arg_118_1, true)

	return var_118_0 and var_118_0.name
end

function var_0_0.getStealthGameMapGridTypeIcon(arg_119_0, arg_119_1)
	local var_119_0 = arg_119_0:getStealthGameMapGridTypeCfg(arg_119_1, true)

	return var_119_0 and var_119_0.icon
end

function var_0_0.getStealthGameMapPointTypeCfg(arg_120_0, arg_120_1, arg_120_2)
	local var_120_0 = lua_assassin_stealth_map_point_comp_type.configDict[arg_120_1]

	if not var_120_0 and arg_120_2 then
		logError(string.format("AssassinConfig:getStealthGameMapPointTypeCfg error, cfg is nil, pointType:%s", arg_120_1))
	end

	return var_120_0
end

function var_0_0.getPointTypeName(arg_121_0, arg_121_1)
	local var_121_0 = arg_121_0:getStealthGameMapPointTypeCfg(arg_121_1, true)

	return var_121_0 and var_121_0.name
end

function var_0_0.getPointTypeIcon(arg_122_0, arg_122_1)
	local var_122_0 = arg_122_0:getStealthGameMapPointTypeCfg(arg_122_1, true)

	return var_122_0 and var_122_0.icon
end

function var_0_0.getPointTypeSmallIcon(arg_123_0, arg_123_1)
	local var_123_0 = arg_123_0:getStealthGameMapPointTypeCfg(arg_123_1, true)

	return var_123_0 and var_123_0.smallIcon
end

function var_0_0.getStealthMissionCfg(arg_124_0, arg_124_1, arg_124_2)
	local var_124_0 = lua_assassin_stealth_mission.configDict[arg_124_1]

	if not var_124_0 and arg_124_2 then
		logError(string.format("AssassinConfig:getStealthMissionCfg error, cfg is nil, missionId:%s", arg_124_1))
	end

	return var_124_0
end

function var_0_0.getStealthMissionDesc(arg_125_0, arg_125_1)
	local var_125_0 = arg_125_0:getStealthMissionCfg(arg_125_1, true)

	return var_125_0 and var_125_0.desc
end

function var_0_0.getStealthMissionRefresh(arg_126_0, arg_126_1)
	local var_126_0 = arg_126_0:getStealthMissionCfg(arg_126_1, true)

	if var_126_0 then
		return var_126_0.refresh1, var_126_0.refresh2
	end
end

function var_0_0.getStealthMissionType(arg_127_0, arg_127_1)
	local var_127_0 = arg_127_0:getStealthMissionCfg(arg_127_1, true)

	return var_127_0 and var_127_0.type
end

function var_0_0.getStealthMissionParam(arg_128_0, arg_128_1, arg_128_2)
	local var_128_0
	local var_128_1 = arg_128_0:getStealthMissionCfg(arg_128_1, true)
	local var_128_2 = var_128_1 and var_128_1.param

	if arg_128_2 then
		var_128_2 = string.splitToNumber(var_128_2, "#")
	end

	return var_128_2
end

function var_0_0.getTargetEnemies(arg_129_0, arg_129_1)
	local var_129_0

	if arg_129_1 and arg_129_1 ~= 0 and arg_129_0:getStealthMissionType(arg_129_1) == AssassinEnum.MissionType.TargetEnemy then
		var_129_0 = arg_129_0:getStealthMissionParam(arg_129_1, true)
	end

	return var_129_0
end

function var_0_0.getEnemyRefreshCfg(arg_130_0, arg_130_1, arg_130_2)
	local var_130_0 = lua_assassin_stealth_refresh.configDict[arg_130_1]

	if not var_130_0 and arg_130_2 then
		logError(string.format("AssassinConfig:getEnemyRefreshCfg error, cfg is nil, refreshId:%s", arg_130_1))
	end

	return var_130_0
end

function var_0_0.getEnemyRefreshPositionList(arg_131_0, arg_131_1)
	local var_131_0 = {}
	local var_131_1 = arg_131_0:getEnemyRefreshCfg(arg_131_1)
	local var_131_2 = var_131_1 and var_131_1.position1

	if not string.nilorempty(var_131_2) then
		var_131_0 = GameUtil.splitString2(var_131_2, true)
	end

	return var_131_0
end

function var_0_0.getEnemyRefreshData(arg_132_0, arg_132_1, arg_132_2)
	if not arg_132_0._enemyRefreshIndexDict then
		arg_132_0._enemyRefreshIndexDict = {}

		for iter_132_0, iter_132_1 in ipairs(lua_assassin_stealth_refresh.configList) do
			local var_132_0 = iter_132_1.id
			local var_132_1 = iter_132_1.position1

			if not string.nilorempty(var_132_1) then
				local var_132_2 = var_0_1(arg_132_0._enemyRefreshIndexDict, var_132_0)
				local var_132_3 = GameUtil.splitString2(var_132_1, true)

				for iter_132_2, iter_132_3 in ipairs(var_132_3) do
					var_132_2[iter_132_3[1]] = {
						index = iter_132_2,
						enemy = iter_132_3[2]
					}
				end
			end
		end
	end

	local var_132_4 = arg_132_0._enemyRefreshIndexDict[arg_132_1]

	return var_132_4 and var_132_4[arg_132_2]
end

function var_0_0.getEnemyGroupCfg(arg_133_0, arg_133_1, arg_133_2)
	local var_133_0 = lua_assassin_monster_group.configDict[arg_133_1]

	if not var_133_0 and arg_133_2 then
		logError(string.format("AssassinConfig:getEnemyGroupCfg error, cfg is nil, id:%s", arg_133_1))
	end

	return var_133_0
end

function var_0_0.getEnemyListInGroup(arg_134_0, arg_134_1)
	local var_134_0 = {}
	local var_134_1 = arg_134_0._enemyRefreshGroupDict and arg_134_0._enemyRefreshGroupDict[arg_134_1]

	if var_134_1 then
		for iter_134_0, iter_134_1 in ipairs(var_134_1) do
			local var_134_2 = iter_134_1 and iter_134_1.monster

			if not string.nilorempty(var_134_2) then
				local var_134_3 = string.splitToNumber(var_134_2, "#")

				tabletool.addValues(var_134_0, var_134_3)
			end
		end
	end

	return var_134_0
end

function var_0_0.getAssassinActCfg(arg_135_0, arg_135_1, arg_135_2)
	local var_135_0 = lua_assassin_act.configDict[arg_135_1]

	if not var_135_0 and arg_135_2 then
		logError(string.format("AssassinConfig:getAssassinActCfg error, cfg is nil, actId:%s", arg_135_1))
	end

	return var_135_0
end

function var_0_0.getAssassinActName(arg_136_0, arg_136_1)
	local var_136_0 = arg_136_0:getAssassinActCfg(arg_136_1, true)

	return var_136_0 and var_136_0.name
end

function var_0_0.getAssassinActIcon(arg_137_0, arg_137_1)
	local var_137_0 = arg_137_0:getAssassinActCfg(arg_137_1)

	return var_137_0 and var_137_0.icon
end

function var_0_0.getAssassinActShowImg(arg_138_0, arg_138_1)
	local var_138_0 = arg_138_0:getAssassinActCfg(arg_138_1, true)

	return var_138_0 and var_138_0.showImg
end

function var_0_0.getAssassinActPower(arg_139_0, arg_139_1)
	local var_139_0 = arg_139_0:getAssassinActCfg(arg_139_1, true)

	return var_139_0 and var_139_0.power
end

function var_0_0.getAssassinActEffect(arg_140_0, arg_140_1)
	local var_140_0 = arg_140_0:getAssassinActCfg(arg_140_1, true)

	if var_140_0 then
		return var_140_0.effectId, var_140_0.targetEffectId
	end
end

function var_0_0.getAssassinActAudioId(arg_141_0, arg_141_1)
	local var_141_0 = arg_141_0:getAssassinActCfg(arg_141_1, true)

	return var_141_0 and var_141_0.audioId
end

function var_0_0.getAssassinInteractCfg(arg_142_0, arg_142_1, arg_142_2)
	local var_142_0 = lua_assassin_interactive.configDict[arg_142_1]

	if not var_142_0 and arg_142_2 then
		logError(string.format("AssassinConfig:getAssassinInteractCfg error, cfg is nil, interactId:%s", arg_142_1))
	end

	return var_142_0
end

function var_0_0.getInteractGridId(arg_143_0, arg_143_1)
	local var_143_0 = arg_143_0:getAssassinInteractCfg(arg_143_1, true)

	return var_143_0 and var_143_0.gridId
end

function var_0_0.getInteractApCost(arg_144_0, arg_144_1)
	local var_144_0 = arg_144_0:getAssassinInteractCfg(arg_144_1, true)

	return var_144_0 and var_144_0.costPoint
end

function var_0_0.getAssassinRandomEventCfg(arg_145_0, arg_145_1, arg_145_2)
	local var_145_0 = lua_assassin_random.configDict[arg_145_1]

	if not var_145_0 and arg_145_2 then
		logError(string.format("AssassinConfig:getAssassinRandomEventCfg error, cfg is nil, eventId:%s", arg_145_1))
	end

	return var_145_0
end

function var_0_0.getEventType(arg_146_0, arg_146_1)
	local var_146_0 = arg_146_0:getAssassinRandomEventCfg(arg_146_1, true)

	return var_146_0 and var_146_0.type
end

function var_0_0.getEventParam(arg_147_0, arg_147_1)
	local var_147_0 = arg_147_0:getAssassinRandomEventCfg(arg_147_1, true)

	return var_147_0 and var_147_0.param
end

function var_0_0.getEventName(arg_148_0, arg_148_1)
	local var_148_0 = arg_148_0:getAssassinRandomEventCfg(arg_148_1, true)

	return var_148_0 and var_148_0.name
end

function var_0_0.getEventImg(arg_149_0, arg_149_1)
	local var_149_0 = arg_149_0:getAssassinRandomEventCfg(arg_149_1, true)

	return var_149_0 and var_149_0.img
end

function var_0_0.getEventDesc(arg_150_0, arg_150_1)
	local var_150_0 = arg_150_0:getAssassinRandomEventCfg(arg_150_1, true)

	return var_150_0 and var_150_0.desc
end

function var_0_0.getAssassinBuffCfg(arg_151_0, arg_151_1, arg_151_2)
	local var_151_0 = lua_assassin_buff.configDict[arg_151_1]

	if not var_151_0 and arg_151_2 then
		logError(string.format("AssassinConfig:getAssassinBuffCfg error, cfg is nil, buffId:%s", arg_151_1))
	end

	return var_151_0
end

function var_0_0.getBuffIdList(arg_152_0)
	if not arg_152_0._buffIdList then
		arg_152_0._buffIdList = {}

		for iter_152_0, iter_152_1 in ipairs(lua_assassin_buff.configList) do
			arg_152_0._buffIdList[#arg_152_0._buffIdList + 1] = iter_152_1.buffId
		end
	end

	return arg_152_0._buffIdList
end

function var_0_0.getAssassinBuffType(arg_153_0, arg_153_1)
	local var_153_0 = arg_153_0:getAssassinBuffCfg(arg_153_1, true)

	return var_153_0 and var_153_0.type
end

function var_0_0.getAssassinBuffEffectId(arg_154_0, arg_154_1)
	local var_154_0 = arg_154_0:getAssassinBuffCfg(arg_154_1, true)

	return var_154_0 and var_154_0.effectId
end

function var_0_0.getAssassinTrapCfg(arg_155_0, arg_155_1, arg_155_2)
	local var_155_0 = lua_assassin_trap.configDict[arg_155_1]

	if not var_155_0 and arg_155_2 then
		logError(string.format("AssassinConfig:getAssassinTrapCfg error, cfg is nil, trapId:%s", arg_155_1))
	end

	return var_155_0
end

function var_0_0.getTrapIdList(arg_156_0)
	if not arg_156_0._trapIdList then
		arg_156_0._trapIdList = {}

		for iter_156_0, iter_156_1 in ipairs(lua_assassin_trap.configList) do
			arg_156_0._trapIdList[#arg_156_0._trapIdList + 1] = iter_156_1.trapId
		end
	end

	return arg_156_0._trapIdList
end

function var_0_0.getTrapTypeList(arg_157_0)
	if not arg_157_0._trapTypeDict then
		arg_157_0._trapTypeDict = {}

		for iter_157_0, iter_157_1 in ipairs(lua_assassin_trap.configList) do
			if not arg_157_0._trapTypeDict[iter_157_1.type] then
				arg_157_0._trapTypeDict[iter_157_1.type] = {}
			end

			table.insert(arg_157_0._trapTypeDict[iter_157_1.type], iter_157_1.trapId)
		end
	end

	return arg_157_0._trapTypeDict
end

function var_0_0.getAssassinTrapType(arg_158_0, arg_158_1)
	local var_158_0 = arg_158_0:getAssassinTrapCfg(arg_158_1, true)

	return var_158_0 and var_158_0.type
end

function var_0_0.getAssassinTrapEffectId(arg_159_0, arg_159_1)
	local var_159_0 = arg_159_0:getAssassinTrapCfg(arg_159_1, true)

	return var_159_0 and var_159_0.effectId
end

function var_0_0.getAssassinEffectCfg(arg_160_0, arg_160_1, arg_160_2)
	local var_160_0 = lua_assassin_effect.configDict[arg_160_1]

	if not var_160_0 and arg_160_2 then
		logError(string.format("AssassinConfig:getAssassinEffectCfg error, cfg is nil, effectId:%s", arg_160_1))
	end

	return var_160_0
end

function var_0_0.getAssassinEffectResName(arg_161_0, arg_161_1)
	local var_161_0 = arg_161_0:getAssassinEffectCfg(arg_161_1, true)

	return var_161_0 and var_161_0.resName
end

function var_0_0.getAssassinEffectDuration(arg_162_0, arg_162_1)
	local var_162_0 = arg_162_0:getAssassinEffectCfg(arg_162_1, true)

	return var_162_0 and var_162_0.duration
end

function var_0_0.getAssassinEffectAudioId(arg_163_0, arg_163_1)
	local var_163_0 = arg_163_0:getAssassinEffectCfg(arg_163_1, true)

	return var_163_0 and var_163_0.audioId
end

function var_0_0.getStealthTechniqueCfg(arg_164_0, arg_164_1, arg_164_2)
	local var_164_0 = lua_stealth_technique.configDict[arg_164_1]

	if not var_164_0 and arg_164_2 then
		logError(string.format("AssassinConfig:getStealthTechniqueCfg error, cfg is nil, techniqueId:%s", arg_164_1))
	end

	return var_164_0
end

function var_0_0.getStealthTechniqueMainTitleId(arg_165_0, arg_165_1)
	local var_165_0 = arg_165_0:getStealthTechniqueCfg(arg_165_1, true)

	return var_165_0 and var_165_0.mainTitleId
end

function var_0_0.getStealthTechniqueSubTitleId(arg_166_0, arg_166_1)
	local var_166_0 = arg_166_0:getStealthTechniqueCfg(arg_166_1, true)

	return var_166_0 and var_166_0.subTitleId
end

function var_0_0.getStealthTechniqueMainTitle(arg_167_0, arg_167_1)
	local var_167_0 = arg_167_0:getStealthTechniqueCfg(arg_167_1, true)

	return var_167_0 and var_167_0.mainTitle
end

function var_0_0.getStealthTechniqueSubTitle(arg_168_0, arg_168_1)
	local var_168_0 = arg_168_0:getStealthTechniqueCfg(arg_168_1, true)

	return var_168_0 and var_168_0.subTitle
end

function var_0_0.getStealthTechniquePicture(arg_169_0, arg_169_1)
	local var_169_0 = arg_169_0:getStealthTechniqueCfg(arg_169_1, true)

	return var_169_0 and var_169_0.picture
end

function var_0_0.getStealthTechniqueContent(arg_170_0, arg_170_1)
	local var_170_0 = arg_170_0:getStealthTechniqueCfg(arg_170_1, true)

	return var_170_0 and var_170_0.content
end

function var_0_0.getTechniqueIdList(arg_171_0)
	local var_171_0 = {}

	for iter_171_0, iter_171_1 in ipairs(lua_stealth_technique.configList) do
		var_171_0[#var_171_0 + 1] = iter_171_1.id
	end

	return var_171_0
end

function var_0_0.getMapShowTechniqueList(arg_172_0, arg_172_1)
	return arg_172_0._mapShowTechniqueDict and arg_172_0._mapShowTechniqueDict[arg_172_1]
end

function var_0_0.getAssassinEnemyCfg(arg_173_0, arg_173_1, arg_173_2)
	local var_173_0 = lua_assassin_monster.configDict[arg_173_1]

	if not var_173_0 and arg_173_2 then
		logError(string.format("AssassinConfig:getAssassinEnemyCfg error, cfg is nil, monsterId:%s", arg_173_1))
	end

	return var_173_0
end

function var_0_0.getEnemyType(arg_174_0, arg_174_1)
	local var_174_0 = arg_174_0:getAssassinEnemyCfg(arg_174_1, true)

	return var_174_0 and var_174_0.type
end

function var_0_0.getEnemyScanRate(arg_175_0, arg_175_1)
	local var_175_0 = arg_175_0:getAssassinEnemyCfg(arg_175_1, true)

	return var_175_0 and var_175_0.scanRate
end

function var_0_0.getEnemyIsBoss(arg_176_0, arg_176_1)
	local var_176_0 = arg_176_0:getAssassinEnemyCfg(arg_176_1, true)

	return (var_176_0 and var_176_0.boss) ~= 0
end

function var_0_0.getEnemyIsNotMove(arg_177_0, arg_177_1)
	local var_177_0 = arg_177_0:getAssassinEnemyCfg(arg_177_1, true)

	return (var_177_0 and var_177_0.notMove) == AssassinEnum.EnemyMoveType.NotMove
end

function var_0_0.getEnemyHeadIcon(arg_178_0, arg_178_1)
	local var_178_0 = arg_178_0:getAssassinEnemyCfg(arg_178_1, true)

	return var_178_0 and var_178_0.icon
end

function var_0_0.getBuildingCo(arg_179_0, arg_179_1)
	local var_179_0 = lua_assassin_building.configDict[arg_179_1]

	if not var_179_0 then
		logError(string.format("建筑配置不存在 buildingId = %s", arg_179_1))
	end

	return var_179_0
end

function var_0_0.getBuildingLvCo(arg_180_0, arg_180_1, arg_180_2)
	local var_180_0 = arg_180_0:getBuildingTypeDict(arg_180_1)
	local var_180_1 = var_180_0 and var_180_0[arg_180_2]

	if not var_180_1 then
		logError(string.format("建筑配置不存在 buildingType = %s, lv = %s", arg_180_1, arg_180_2))
	end

	return var_180_1
end

function var_0_0.getBuildingMaxLv(arg_181_0, arg_181_1)
	local var_181_0 = arg_181_0:getBuildingTypeDict(arg_181_1)

	return var_181_0 and tabletool.len(var_181_0) or 0
end

function var_0_0.getBuildingTypeDict(arg_182_0, arg_182_1)
	local var_182_0 = arg_182_0._typeBuildingDict[arg_182_1]

	if not var_182_0 then
		logError(string.format("建筑配置不存在 buildingType = %s", arg_182_1))
	end

	return var_182_0
end

function var_0_0.getBuildingLvCostList(arg_183_0, arg_183_1, arg_183_2)
	local var_183_0 = arg_183_0:getBuildingLvCo(arg_183_1, arg_183_2)

	if not var_183_0 then
		return
	end

	local var_183_1 = var_183_0 and var_183_0.id
	local var_183_2 = arg_183_0._buildingLvCostDict[var_183_1]

	if not var_183_2 then
		var_183_2 = GameUtil.splitString2(var_183_0.unlock, true)
		arg_183_0._buidlingEffectDict[var_183_1] = var_183_2
	end

	return var_183_2
end

function var_0_0.getLibrarConfig(arg_184_0, arg_184_1)
	local var_184_0 = lua_assassin_library.configDict[arg_184_1]

	if not var_184_0 then
		logError(string.format("资料库配置不存在 libraryId = %s", arg_184_1))
	end

	return var_184_0
end

function var_0_0.getActLibraryConfigDict(arg_185_0, arg_185_1)
	local var_185_0 = arg_185_0._actLibraryDict and arg_185_0._actLibraryDict[arg_185_1]

	if not var_185_0 then
		logError(string.format("资料库配置不存在 actId = %s", arg_185_1))
	end

	return var_185_0
end

function var_0_0.getLibraryConfigs(arg_186_0, arg_186_1, arg_186_2)
	local var_186_0 = arg_186_0:getActLibraryConfigDict(arg_186_1)
	local var_186_1 = var_186_0 and var_186_0[arg_186_2]

	if not var_186_1 then
		logError(string.format("资料库配置不存在 actId = %s, libType = %s", arg_186_1, arg_186_2))
	end

	return var_186_1
end

function var_0_0.getLibraryActIdList(arg_187_0)
	return arg_187_0._libraryActIdList
end

function var_0_0.getActLibraryTypeList(arg_188_0, arg_188_1)
	local var_188_0 = arg_188_0._libraryTypeDict[arg_188_1]

	if not var_188_0 then
		logError(string.format("资料库大类中没有子类 actId = %s", arg_188_1))
	end

	return var_188_0
end

function var_0_0.getTaskCo(arg_189_0, arg_189_1)
	local var_189_0 = lua_assassin_task.configDict[arg_189_1]

	if not var_189_0 then
		logError(string.format("任务配置不存在 taskId = %s", arg_189_1))
	end

	return var_189_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
