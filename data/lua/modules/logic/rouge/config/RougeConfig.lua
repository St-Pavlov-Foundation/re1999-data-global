module("modules.logic.rouge.config.RougeConfig", package.seeall)

local var_0_0 = class("RougeConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"rouge_season",
		"rouge_const",
		"rouge_outside_const",
		"rouge_difficulty",
		"rouge_result",
		"rouge_badge",
		"rouge_ending",
		"rouge_last_reward",
		"rouge_style",
		"rouge_style_talent",
		"rouge_level",
		"rouge_active_skill",
		"rouge_map_skill",
		"rogue_collection_backpack",
		"rouge_genius_branch"
	}
end

local function var_0_1(arg_2_0)
	return lua_rouge_season.configDict[arg_2_0]
end

function var_0_0._openList(arg_3_0)
	local var_3_0 = lua_rouge_season.configList
	local var_3_1 = {
		0
	}

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		table.insert(var_3_1, iter_3_1.id)
	end

	return var_3_1
end

function var_0_0.onConfigLoaded(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == "rouge_season" then
		arg_4_0._openDict = {}

		arg_4_0:_getOrCreateOpenDict()
	elseif arg_4_1 == "rouge_difficulty" then
		arg_4_0._difficultyDlcDict = {}
		arg_4_0._difficultBaseDict = {}
		arg_4_0._difficultyStartViewInfoDict = {}

		arg_4_0:_getOrCreateDifficultyDict()
	elseif arg_4_1 == "rouge_style" then
		arg_4_0._styleBaseDict = {}
		arg_4_0._styleDlcDict = {}

		arg_4_0:_getOrCreateRougeStyleDict()
	elseif arg_4_1 == "rouge_const" then
		arg_4_0:_initConst()
	elseif arg_4_1 == "rouge_genius_branch" then
		arg_4_0._geniusBranchStartViewInfoDict = {}
		arg_4_0._geniusBranchIdListWithStartView = {}
	end
end

function var_0_0._initConst(arg_5_0)
	arg_5_0._roleCapacity = arg_5_0:_initRoleCapacity(RougeEnum.Const.RoleCapacity)
	arg_5_0._roleHalfCapacity = arg_5_0:_initRoleCapacity(RougeEnum.Const.RoleHalfCapacity)
end

function var_0_0._initRoleCapacity(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getConstValueByID(arg_6_1)
	local var_6_1 = GameUtil.splitString2(var_6_0, true, "|", "#")
	local var_6_2 = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		var_6_2[iter_6_1[1]] = iter_6_1[2]
	end

	return var_6_2
end

function var_0_0.getRoleCapacity(arg_7_0, arg_7_1)
	return arg_7_0._roleCapacity[arg_7_1] or 1
end

function var_0_0.getRoleHalfCapacity(arg_8_0, arg_8_1)
	return arg_8_0._roleHalfCapacity[arg_8_1] or 1
end

function var_0_0.getSeasonAndVersion(arg_9_0, arg_9_1)
	local var_9_0 = var_0_1(arg_9_1)

	return var_9_0.season, var_9_0.version
end

function var_0_0.getConstValueByID(arg_10_0, arg_10_1)
	return lua_rouge_const.configDict[arg_10_1].value
end

function var_0_0.getConstNumValue(arg_11_0, arg_11_1)
	return tonumber(arg_11_0:getConstValueByID(arg_11_1))
end

function var_0_0.getOutSideConstValueByID(arg_12_0, arg_12_1)
	return lua_rouge_outside_const.configList[arg_12_1].value
end

function var_0_0._getOrCreateDifficultyDict(arg_13_0)
	local var_13_0 = arg_13_0:season()

	if arg_13_0._difficultBaseDict[var_13_0] then
		return arg_13_0._difficultBaseDict[var_13_0], arg_13_0._difficultyDlcDict[var_13_0]
	end

	local var_13_1 = {}
	local var_13_2 = {}

	arg_13_0._difficultyDlcDict[var_13_0] = var_13_1
	arg_13_0._difficultBaseDict[var_13_0] = var_13_2

	if lua_rouge_difficulty.configDict[var_13_0] then
		for iter_13_0, iter_13_1 in pairs(lua_rouge_difficulty.configDict[var_13_0]) do
			if string.nilorempty(iter_13_1.version) then
				table.insert(var_13_2, iter_13_1)
			else
				local var_13_3 = RougeDLCHelper.versionStrToList(iter_13_1.version)

				for iter_13_2, iter_13_3 in ipairs(var_13_3) do
					var_13_1[iter_13_3] = var_13_1[iter_13_3] or {}

					if arg_13_0:isRougeSeasonIdOpen(iter_13_3) then
						table.insert(var_13_1[iter_13_3], iter_13_1)
					end
				end
			end
		end
	end

	for iter_13_4, iter_13_5 in pairs(var_13_1) do
		table.sort(iter_13_5, function(arg_14_0, arg_14_1)
			if arg_14_0.difficulty ~= arg_14_1.difficulty then
				return arg_14_0.difficulty < arg_14_1.difficulty
			end

			return false
		end)
	end

	return var_13_2, var_13_1
end

function var_0_0._getOrCreateOpenDict(arg_15_0)
	local var_15_0 = arg_15_0:season()

	if arg_15_0._openDict[var_15_0] then
		return arg_15_0._openDict[var_15_0]
	end

	local var_15_1 = {}

	arg_15_0._openDict[var_15_0] = var_15_1

	local var_15_2 = arg_15_0:_openList()

	for iter_15_0, iter_15_1 in ipairs(var_15_2) do
		var_15_1[iter_15_1] = true
	end

	return var_15_1
end

function var_0_0._getOrCreateRougeStyleDict(arg_16_0)
	local var_16_0 = arg_16_0:season()

	if arg_16_0._styleBaseDict[var_16_0] then
		return arg_16_0._styleBaseDict[var_16_0], arg_16_0._styleDlcDict[var_16_0]
	end

	local var_16_1 = {}
	local var_16_2 = {}

	arg_16_0._styleBaseDict[var_16_0] = var_16_2
	arg_16_0._styleDlcDict[var_16_0] = var_16_1

	if lua_rouge_style.configDict[var_16_0] then
		for iter_16_0, iter_16_1 in pairs(lua_rouge_style.configDict[var_16_0]) do
			if string.nilorempty(iter_16_1.version) then
				table.insert(var_16_2, iter_16_1)
			else
				local var_16_3 = RougeDLCHelper.versionStrToList(iter_16_1.version)

				for iter_16_2, iter_16_3 in ipairs(var_16_3) do
					var_16_1[iter_16_3] = var_16_1[iter_16_3] or {}

					if arg_16_0:isRougeSeasonIdOpen(iter_16_3) then
						table.insert(var_16_1[iter_16_3], iter_16_1)
					end
				end
			end
		end
	end

	for iter_16_4, iter_16_5 in pairs(var_16_1) do
		table.sort(iter_16_5, function(arg_17_0, arg_17_1)
			return arg_17_0.id < arg_17_1.id
		end)
	end

	return var_16_2, var_16_1
end

function var_0_0.isRougeSeasonIdOpen(arg_18_0, arg_18_1)
	return arg_18_0:_getOrCreateOpenDict()[arg_18_1] and true or false
end

function var_0_0.getDifficultyCOList(arg_19_0, arg_19_1, arg_19_2)
	if not arg_19_2 or #arg_19_2 <= 0 then
		return
	end

	local var_19_0 = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_2) do
		local var_19_1, var_19_2 = arg_19_0:_getOrCreateDifficultyDict()
		local var_19_3 = var_19_2 and var_19_2[iter_19_1]

		if var_19_3 then
			for iter_19_2, iter_19_3 in ipairs(var_19_3) do
				if RougeDLCHelper.isCurrentUsingContent(iter_19_3.version) and not var_19_0[iter_19_3.difficulty] then
					table.insert(arg_19_1, iter_19_3)

					var_19_0[iter_19_3.difficulty] = true
				end
			end
		end
	end
end

function var_0_0.getStylesCOList(arg_20_0, arg_20_1, arg_20_2)
	if not arg_20_2 or #arg_20_2 <= 0 then
		return
	end

	local var_20_0, var_20_1 = arg_20_0:_getOrCreateRougeStyleDict()
	local var_20_2 = {}

	for iter_20_0, iter_20_1 in ipairs(arg_20_2) do
		local var_20_3 = var_20_1 and var_20_1[iter_20_1]

		if var_20_3 then
			for iter_20_2, iter_20_3 in ipairs(var_20_3) do
				if RougeDLCHelper.isCurrentUsingContent(iter_20_3.version) and not var_20_2[iter_20_3.id] then
					table.insert(arg_20_1, iter_20_3)

					var_20_2[iter_20_3.id] = true
				end
			end
		end
	end
end

function var_0_0.getStyleConfig(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:season()

	return lua_rouge_style.configDict[var_21_0][arg_21_1]
end

function var_0_0.getSeasonStyleConfigs(arg_22_0)
	local var_22_0 = arg_22_0:season()

	return lua_rouge_style.configDict[var_22_0]
end

function var_0_0.getCollectionBackpackCO(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:getStyleConfig(arg_23_1).layoutId

	return lua_rogue_collection_backpack.configDict[var_23_0]
end

function var_0_0.getDifficultyCO(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:season()

	return lua_rouge_difficulty.configDict[var_24_0][arg_24_1]
end

function var_0_0.getDifficultyCOStartViewInfo(arg_25_0, arg_25_1)
	if not arg_25_1 then
		return {}
	end

	local var_25_0 = arg_25_0:season()
	local var_25_1 = arg_25_0._difficultyStartViewInfoDict[var_25_0]

	if var_25_1 and var_25_1[arg_25_1] then
		return var_25_1[arg_25_1]
	end

	arg_25_0._difficultyStartViewInfoDict[var_25_0] = arg_25_0._difficultyStartViewInfoDict[var_25_0] or {}

	local var_25_2 = {}

	arg_25_0._difficultyStartViewInfoDict[var_25_0][arg_25_1] = var_25_2

	local var_25_3 = arg_25_0:getDifficultyCO(arg_25_1).startView
	local var_25_4 = GameUtil.splitString2(var_25_3, false, "|", "#")

	if not var_25_4 then
		return var_25_2
	end

	for iter_25_0, iter_25_1 in ipairs(var_25_4) do
		local var_25_5 = iter_25_1[1]

		assert(RougeEnum.StartViewEnum[var_25_5], "unsupported error excel:R肉鸽表.xlsx export_难度表.sheet difficulty=" .. arg_25_1 .. " 列'startView'=" .. var_25_3 .. " 配了代码未支持的类型:" .. var_25_5)

		local var_25_6 = tonumber(iter_25_1[2]) or 0

		var_25_2[var_25_5] = (var_25_2[var_25_5] or 0) + var_25_6
	end

	return var_25_2
end

function var_0_0.getDifficultyCOStartViewDeltaValue(arg_26_0, arg_26_1, arg_26_2)
	return arg_26_0:getDifficultyCOStartViewInfo(arg_26_1)[arg_26_2] or 0
end

function var_0_0.getDifficultyCOTitle(arg_27_0, arg_27_1)
	return arg_27_0:getDifficultyCO(arg_27_1).title
end

function var_0_0.getActiveSkillCO(arg_28_0, arg_28_1)
	local var_28_0 = lua_rouge_active_skill.configDict[arg_28_1]

	if not var_28_0 then
		logError("缺少肉鸽激活技能配置, 技能id :" .. tostring(arg_28_1))
	end

	return var_28_0
end

function var_0_0.getMapSkillCo(arg_29_0, arg_29_1)
	local var_29_0 = lua_rouge_map_skill.configDict[arg_29_1]

	if not var_29_0 then
		logError("缺少肉鸽地图技能配置, 地图技能id :" .. tostring(arg_29_1))
	end

	return var_29_0
end

function var_0_0.getRougeBadgeCO(arg_30_0, arg_30_1, arg_30_2)
	return lua_rouge_badge.configDict[arg_30_1][arg_30_2]
end

function var_0_0.getEndingCO(arg_31_0, arg_31_1)
	local var_31_0 = lua_rouge_ending.configDict[arg_31_1]

	if not var_31_0 then
		logError("rouge end config not exist, endId : " .. tostring(arg_31_1))

		return
	end

	return var_31_0
end

function var_0_0.getLastRewardCO(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0:season()

	return lua_rouge_last_reward.configDict[var_32_0][arg_32_1]
end

function var_0_0.getStyleLockDesc(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0:getStyleConfig(arg_33_1)
	local var_33_1 = var_33_0.unlockType

	if not var_33_1 or var_33_1 == 0 then
		return ""
	end

	return RougeMapUnlockHelper.getLockTips(var_33_1, var_33_0.unlockParam)
end

function var_0_0.getAbortCDDuration(arg_34_0)
	return math.max(0, arg_34_0:getConstNumValue(44) or 0)
end

function var_0_0.getDifficultyCOListByVersions(arg_35_0, arg_35_1)
	local var_35_0 = {}
	local var_35_1 = arg_35_0:_getOrCreateDifficultyDict()

	tabletool.addValues(var_35_0, var_35_1)
	arg_35_0:getDifficultyCOList(var_35_0, arg_35_1)
	table.sort(var_35_0, function(arg_36_0, arg_36_1)
		if arg_36_0.difficulty ~= arg_36_1.difficulty then
			return arg_36_0.difficulty < arg_36_1.difficulty
		end

		if arg_36_0.version ~= arg_36_1.version then
			return arg_36_0.version < arg_36_1.version
		end

		return false
	end)

	return var_35_0
end

function var_0_0.getStyleCOListByVersions(arg_37_0, arg_37_1)
	local var_37_0 = {}
	local var_37_1 = arg_37_0:_getOrCreateRougeStyleDict()

	tabletool.addValues(var_37_0, var_37_1)
	arg_37_0:getStylesCOList(var_37_0, arg_37_1)
	table.sort(var_37_0, function(arg_38_0, arg_38_1)
		return arg_38_0.id < arg_38_1.id
	end)

	return var_37_0
end

function var_0_0.getGeniusBranchCO(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0:season()

	return lua_rouge_genius_branch.configDict[var_39_0][arg_39_1]
end

function var_0_0.getGeniusBranchStartViewInfo(arg_40_0, arg_40_1)
	if not arg_40_1 then
		return {}
	end

	local var_40_0 = arg_40_0:season()
	local var_40_1 = arg_40_0._geniusBranchStartViewInfoDict[var_40_0]

	if var_40_1 and var_40_1[arg_40_1] then
		return var_40_1[arg_40_1]
	end

	arg_40_0._geniusBranchStartViewInfoDict[var_40_0] = arg_40_0._geniusBranchStartViewInfoDict[var_40_0] or {}

	local var_40_2 = {}

	arg_40_0._geniusBranchStartViewInfoDict[var_40_0][arg_40_1] = var_40_2

	local var_40_3 = arg_40_0:getGeniusBranchCO(arg_40_1).startView
	local var_40_4 = GameUtil.splitString2(var_40_3, false, "|", "#")

	if not var_40_4 then
		return var_40_2
	end

	for iter_40_0, iter_40_1 in ipairs(var_40_4) do
		local var_40_5 = iter_40_1[1]

		assert(RougeEnum.StartViewEnum[var_40_5], "unsupported error R肉鸽局外表.xlsx export_天赋分支表.sheet id=" .. arg_40_1 .. " 列'startView'=" .. var_40_3 .. " 配了代码未支持的类型:" .. var_40_5)

		local var_40_6 = tonumber(iter_40_1[2]) or 0

		var_40_2[var_40_5] = (var_40_2[var_40_5] or 0) + var_40_6
	end

	return var_40_2
end

function var_0_0.getGeniusBranchStartViewDeltaValue(arg_41_0, arg_41_1, arg_41_2)
	return arg_41_0:getGeniusBranchStartViewInfo(arg_41_1)[arg_41_2] or 0
end

function var_0_0.getGeniusBranchIdListWithStartView(arg_42_0)
	local var_42_0 = arg_42_0:season()
	local var_42_1 = arg_42_0._geniusBranchIdListWithStartView[var_42_0]

	if var_42_1 then
		return var_42_1
	end

	local var_42_2 = {}

	arg_42_0._geniusBranchIdListWithStartView[var_42_0] = var_42_2

	local var_42_3 = lua_rouge_genius_branch.configDict[var_42_0]

	for iter_42_0, iter_42_1 in pairs(var_42_3) do
		if not string.nilorempty(iter_42_1.startView) then
			table.insert(var_42_2, iter_42_1.id)
		end
	end

	return var_42_2
end

function var_0_0.getSkillCo(arg_43_0, arg_43_1, arg_43_2)
	if arg_43_1 == RougeEnum.SkillType.Map then
		return arg_43_0:getMapSkillCo(arg_43_2)
	elseif arg_43_1 == RougeEnum.SkillType.Style then
		return arg_43_0:getActiveSkillCO(arg_43_2)
	else
		logError("未定义的技能类型:" .. tostring(arg_43_1))
	end
end

function var_0_0.season(arg_44_0)
	assert(false, "please override this function")
end

function var_0_0.openUnlockId(arg_45_0)
	assert(false, "please override this function")
end

function var_0_0.achievementJumpId(arg_46_0)
	assert(false, "please override this function")
end

var_0_0.instance = var_0_0.New()

return var_0_0
