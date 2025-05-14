module("modules.logic.versionactivity2_2.eliminate.config.EliminateConfig", package.seeall)

local var_0_0 = class("EliminateConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"eliminate_episode",
		"eliminate_chapter",
		"eliminate_reward",
		"teamchess_character",
		"eliminate_slot",
		"soldier_chess",
		"strong_hold",
		"teamchess_enemy",
		"war_chess_episode",
		"character_skill",
		"soldier_skill",
		"eliminate_cost",
		"strong_hold_rule",
		"eliminate_dialog"
	}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0:_initEliminateChessConfig()
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "eliminate_chapter" then
		arg_3_0:_initChapter()
	elseif arg_3_1 == "soldier_chess" then
		arg_3_0:_initSoldierChess()
	elseif arg_3_1 == "eliminate_cost" then
		arg_3_0:_initEvaluateGear()
		arg_3_0:_initCharacterDamageGear()
	end
end

function var_0_0._initSoldierChess(arg_4_0)
	arg_4_0._soldierChessList = {}
	arg_4_0._soldierChessShowList = {}
	arg_4_0._soldierChessShowMap = {}

	for iter_4_0, iter_4_1 in ipairs(lua_soldier_chess.configList) do
		local var_4_0 = 0
		local var_4_1 = GameUtil.splitString2(iter_4_1.cost, false, "#", "_")

		if var_4_1 then
			for iter_4_2, iter_4_3 in ipairs(var_4_1) do
				local var_4_2 = tonumber(iter_4_3[2])

				if var_4_2 then
					var_4_0 = var_4_0 + var_4_2
				else
					logError("eliminate_cost error:" .. tostring(iter_4_1.id) .. " cost:" .. tostring(iter_4_1.cost))
				end
			end
		end

		local var_4_3 = {
			id = iter_4_1.id,
			config = iter_4_1,
			costList = var_4_1,
			costValue = var_4_0
		}

		table.insert(arg_4_0._soldierChessList, var_4_3)

		if iter_4_1.formationDisplays == 1 then
			table.insert(arg_4_0._soldierChessShowList, var_4_3)

			arg_4_0._soldierChessShowMap[iter_4_1.id] = var_4_3
		end
	end
end

function var_0_0.getSoldierChessList(arg_5_0)
	return arg_5_0._soldierChessShowList
end

function var_0_0.getSoldierChessById(arg_6_0, arg_6_1)
	return arg_6_0._soldierChessShowMap[arg_6_1]
end

function var_0_0.getSoldierChessConfig(arg_7_0, arg_7_1)
	return lua_soldier_chess.configDict[arg_7_1]
end

function var_0_0.getSoldierSkillConfig(arg_8_0, arg_8_1)
	return lua_soldier_skill.configDict[arg_8_1]
end

function var_0_0.getSoldierChessQualityImageName(arg_9_0, arg_9_1)
	return EliminateTeamChessEnum.SoliderChessQualityImage[arg_9_1] or EliminateTeamChessEnum.SoliderChessQualityImage[1]
end

function var_0_0.getSoldierChessDesc(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getSoldierChessConfig(arg_10_1).skillId
	local var_10_1 = string.splitToNumber(var_10_0, "#")
	local var_10_2 = ""

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		local var_10_3 = lua_soldier_skill.configDict[iter_10_1]

		if var_10_3 then
			var_10_2 = var_10_2 .. var_10_3.skillDes .. "\n"
		end
	end

	return var_10_2
end

function var_0_0.getUnLockMainCharacterSkillConst(arg_11_0)
	return arg_11_0:getConstValue(4)
end

function var_0_0.getUnLockChessSellConst(arg_12_0)
	return arg_12_0:getConstValue(5)
end

function var_0_0.getUnLockSelectSoliderConst(arg_13_0)
	return arg_13_0:getConstValue(6)
end

function var_0_0.getSellSoliderPermillage(arg_14_0)
	local var_14_0 = lua_eliminate_cost.configDict[12]

	return var_14_0 and tonumber(var_14_0.value) or 1
end

function var_0_0.getConstValue(arg_15_0, arg_15_1)
	local var_15_0 = lua_eliminate_cost.configDict[arg_15_1]

	return var_15_0 and tonumber(var_15_0.value) or 0
end

function var_0_0.getSoldierChessConfigConst(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0._soldierChessList) do
		local var_16_0 = iter_16_1.config

		if var_16_0 and var_16_0.id == arg_16_1 then
			return iter_16_1.costList, iter_16_1.costValue
		end
	end

	return nil
end

function var_0_0.getTeamChessCharacterConfig(arg_17_0, arg_17_1)
	return lua_teamchess_character.configDict[arg_17_1]
end

function var_0_0.getTeamChessEnemyConfig(arg_18_0, arg_18_1)
	return lua_teamchess_enemy.configDict[arg_18_1]
end

function var_0_0.getStrongHoldConfig(arg_19_0, arg_19_1)
	return lua_strong_hold.configDict[arg_19_1]
end

function var_0_0.getSoldierChessModelPath(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:getSoldierChessConfig(arg_20_1)

	return var_20_0 and var_20_0.resModel or ""
end

function var_0_0._initChapter(arg_21_0)
	arg_21_0._normalChapterList = {}

	for iter_21_0, iter_21_1 in ipairs(lua_eliminate_chapter.configList) do
		table.insert(arg_21_0._normalChapterList, iter_21_1)
	end
end

function var_0_0._initEliminateChessConfig(arg_22_0)
	arg_22_0._chessBoardConfig = {}
	arg_22_0._chessConfig = {}

	for iter_22_0 = 1, #T_lua_eliminate_chessBoard do
		local var_22_0 = T_lua_eliminate_chessBoard[iter_22_0]

		arg_22_0._chessBoardConfig[var_22_0.type] = var_22_0
	end

	for iter_22_1 = 1, #T_lua_eliminate_chess do
		local var_22_1 = T_lua_eliminate_chess[iter_22_1]

		arg_22_0._chessConfig[var_22_1.id] = var_22_1
	end
end

function var_0_0.getChessIconPath(arg_23_0, arg_23_1)
	return arg_23_0._chessConfig[arg_23_1] and arg_23_0._chessConfig[arg_23_1].iconPath or ""
end

function var_0_0.getChessSourceID(arg_24_0, arg_24_1)
	return arg_24_0._chessConfig[arg_24_1] and arg_24_0._chessConfig[arg_24_1].colorId or ""
end

function var_0_0.getChessBoardIconPath(arg_25_0, arg_25_1)
	return arg_25_0._chessBoardConfig[arg_25_1] and arg_25_0._chessBoardConfig[arg_25_1].iconPath or ""
end

function var_0_0.getNormalChapterList(arg_26_0)
	return arg_26_0._normalChapterList
end

function var_0_0.getEliminateEpisodeConfig(arg_27_0, arg_27_1)
	return lua_eliminate_episode.configDict[arg_27_1]
end

function var_0_0.getWarChessEpisodeConfig(arg_28_0, arg_28_1)
	return lua_war_chess_episode.configDict[arg_28_1]
end

function var_0_0.getMainCharacterSkillConfig(arg_29_0, arg_29_1)
	if arg_29_1 then
		local var_29_0 = string.splitToNumber(arg_29_1, "#")

		return lua_character_skill.configDict[var_29_0[1]]
	end

	return nil
end

function var_0_0.getStrongHoldRuleRuleConfig(arg_30_0, arg_30_1)
	return lua_strong_hold_rule.configDict[arg_30_1]
end

function var_0_0.getEliminateDialogConfig(arg_31_0, arg_31_1)
	local var_31_0 = lua_eliminate_dialog.configDict[arg_31_1]

	if var_31_0 == nil then
		var_31_0 = {}
	end

	local var_31_1 = lua_eliminate_dialog.configDict[999999]

	if var_31_1 ~= nil then
		tabletool.addValues(var_31_0, var_31_1)
	end

	return var_31_0
end

function var_0_0._initEvaluateGear(arg_32_0)
	local var_32_0 = lua_eliminate_cost.configDict[36]

	arg_32_0._evaluateGear = string.splitToNumber(var_32_0.value, "#")
end

function var_0_0.getEvaluateGear(arg_33_0)
	return arg_33_0._evaluateGear
end

function var_0_0._initCharacterDamageGear(arg_34_0)
	local var_34_0 = lua_eliminate_cost.configDict[38]

	arg_34_0._characterDamageGear = string.splitToNumber(var_34_0.value, "#")
end

function var_0_0.getCharacterDamageGear(arg_35_0)
	return arg_35_0._characterDamageGear
end

function var_0_0.getSoliderSkillConfig(arg_36_0, arg_36_1)
	return lua_soldier_skill.configDict[arg_36_1] or {}
end

var_0_0.instance = var_0_0.New()

return var_0_0
