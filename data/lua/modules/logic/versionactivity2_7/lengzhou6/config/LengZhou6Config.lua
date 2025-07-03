module("modules.logic.versionactivity2_7.lengzhou6.config.LengZhou6Config", package.seeall)

local var_0_0 = class("LengZhou6Config", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"activity190_episode",
		"activity190_task",
		"eliminate_battle_cost",
		"eliminate_battle_enemy",
		"eliminate_battle_enemybehavior",
		"eliminate_battle_endless_library_round",
		"eliminate_battle_character",
		"eliminate_battle_skill",
		"eliminate_battle_buff",
		"eliminate_battle_endless_mode",
		"eliminate_battle_eliminateblocks"
	}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._eliminateBattleDamage = {}
	arg_2_0._eliminateBattleHeal = {}
	arg_2_0._skillIdToSpecialAttr = nil
	arg_2_0._enemyRandomIdsConfig = nil
	arg_2_0._selectEnemyIds = nil
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	return
end

function var_0_0.getEpisodeConfig(arg_4_0, arg_4_1, arg_4_2)
	return lua_activity190_episode.configDict[arg_4_1][arg_4_2]
end

function var_0_0.getEliminateBattleEliminateBlocks(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = lua_eliminate_battle_eliminateblocks.configDict[arg_5_1]

	if arg_5_1 == nil or arg_5_2 == nil or var_5_0 == nil then
		logError("getEliminateBattleEliminateBlocks error eliminateName or eliminateType is nil" .. tostring(arg_5_1) .. tostring(arg_5_2))
	end

	if var_5_0 == nil then
		return nil
	end

	return var_5_0[arg_5_2]
end

function var_0_0.getEliminateBattleEnemy(arg_6_0, arg_6_1)
	return lua_eliminate_battle_enemy.configDict[arg_6_1]
end

function var_0_0.getEliminateBattleEnemyBehavior(arg_7_0, arg_7_1)
	return lua_eliminate_battle_enemybehavior.configDict[arg_7_1]
end

function var_0_0.getEliminateBattleCharacter(arg_8_0, arg_8_1)
	return lua_eliminate_battle_character.configDict[arg_8_1]
end

function var_0_0.getEliminateBattleSkill(arg_9_0, arg_9_1)
	return lua_eliminate_battle_skill.configDict[arg_9_1]
end

function var_0_0.getEliminateBattleBuff(arg_10_0, arg_10_1)
	return lua_eliminate_battle_buff.configDict[arg_10_1]
end

function var_0_0.getTaskByActId(arg_11_0, arg_11_1)
	if arg_11_0._taskList == nil then
		arg_11_0._taskList = {}

		for iter_11_0, iter_11_1 in ipairs(lua_activity190_task.configList) do
			if iter_11_1.activityId == arg_11_1 then
				table.insert(arg_11_0._taskList, iter_11_1)
			end
		end
	end

	return arg_11_0._taskList
end

function var_0_0.getPlayerAllSkillId(arg_12_0)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(lua_eliminate_battle_skill.configList) do
		if iter_12_1.type == LengZhou6Enum.SkillType.active or iter_12_1.type == LengZhou6Enum.SkillType.passive and not var_0_0.instance:isPlayerChessPassive(iter_12_1.id) then
			table.insert(var_12_0, iter_12_1.id)
		end
	end

	return var_12_0
end

function var_0_0.isPlayerChessPassive(arg_13_0, arg_13_1)
	for iter_13_0 = 1, 4 do
		if var_0_0.instance:getEliminateBattleCost(iter_13_0) == arg_13_1 then
			return true
		end
	end

	return false
end

function var_0_0.getEnemyRandomIdsConfig(arg_14_0, arg_14_1)
	if arg_14_0._enemyRandomIdsConfig == nil then
		arg_14_0._enemyRandomIdsConfig = {}
		arg_14_0._enemyEndlessLibraryRound = {}

		local var_14_0 = lua_eliminate_battle_endless_library_round.configList

		for iter_14_0 = 1, #var_14_0 do
			local var_14_1 = var_14_0[iter_14_0]
			local var_14_2 = string.splitToNumber(var_14_1.endlessLibraryRound, "#")
			local var_14_3 = string.splitToNumber(var_14_1.randomIds, "#")

			table.insert(arg_14_0._enemyEndlessLibraryRound, var_14_2[2])
			table.insert(arg_14_0._enemyRandomIdsConfig, var_14_3)
		end
	end

	local var_14_4 = arg_14_0:recordEnemyLastRandomId(arg_14_1)

	return arg_14_0._enemyRandomIdsConfig[var_14_4]
end

function var_0_0.getEnemyRandomRealIndex(arg_15_0, arg_15_1)
	if arg_15_0._enemyEndlessLibraryRound == nil then
		return 1
	end

	for iter_15_0 = 1, #arg_15_0._enemyEndlessLibraryRound do
		if arg_15_1 <= arg_15_0._enemyEndlessLibraryRound[iter_15_0] then
			return iter_15_0
		end
	end
end

function var_0_0.recordEnemyLastRandomId(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getEnemyRandomRealIndex(arg_16_1)

	if arg_16_0._lastEnemyRoundIndex ~= nil and var_16_0 ~= arg_16_0._lastEnemyRoundIndex then
		arg_16_0:clearSetSelectEnemyRandomId()
	end

	arg_16_0._lastEnemyRoundIndex = var_16_0

	return var_16_0
end

function var_0_0.setSelectEnemyRandomId(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_2 == nil then
		return
	end

	if arg_17_0._selectEnemyIds == nil then
		arg_17_0._selectEnemyIds = {}
	end

	local var_17_0 = arg_17_0._selectEnemyIds[arg_17_2] or 0

	arg_17_0._selectEnemyIds[arg_17_2] = var_17_0 + 1

	if arg_17_0._selectEnemyIds[arg_17_2] == 2 then
		local var_17_1 = arg_17_0:getEnemyRandomRealIndex(arg_17_1)

		if arg_17_0._enemyRandomIdsConfig ~= nil then
			local var_17_2 = arg_17_0._enemyRandomIdsConfig[var_17_1]

			for iter_17_0 = 1, #var_17_2 do
				if var_17_2[iter_17_0] == arg_17_2 then
					table.remove(var_17_2, iter_17_0)

					break
				end
			end

			arg_17_0._enemyRandomIdsConfig[var_17_1] = var_17_2
		end
	end
end

function var_0_0.clearSetSelectEnemyRandomId(arg_18_0)
	arg_18_0._selectEnemyIds = nil
end

function var_0_0.getEliminateBattleCost(arg_19_0, arg_19_1)
	local var_19_0 = lua_eliminate_battle_cost.configDict[arg_19_1].value or 0

	return tonumber(var_19_0)
end

function var_0_0.getEliminateBattleCostStr(arg_20_0, arg_20_1)
	return lua_eliminate_battle_cost.configDict[arg_20_1].value
end

function var_0_0.getComboThreshold(arg_21_0)
	return (arg_21_0:getEliminateBattleCost(27))
end

function var_0_0.getAllSpecialAttr(arg_22_0)
	if arg_22_0._skillIdToSpecialAttr == nil then
		arg_22_0._skillIdToSpecialAttr = {}

		for iter_22_0 = 28, 31 do
			local var_22_0 = arg_22_0:getEliminateBattleCostStr(iter_22_0)

			if not string.nilorempty(var_22_0) then
				local var_22_1 = string.split(var_22_0, "#")
				local var_22_2 = tonumber(var_22_1[1])
				local var_22_3 = var_22_1[2]
				local var_22_4 = var_22_1[3]
				local var_22_5 = tonumber(var_22_1[4])

				arg_22_0._skillIdToSpecialAttr[var_22_2] = {
					effect = var_22_3,
					chessType = var_22_4,
					value = var_22_5
				}
			end
		end
	end

	return arg_22_0._skillIdToSpecialAttr
end

function var_0_0.getEliminateBattleEndlessMode(arg_23_0, arg_23_1)
	if arg_23_0._battleEndLessMode == nil then
		arg_23_0._battleEndLessMode = {}
	end

	if arg_23_0._battleEndLessMode[arg_23_1] == nil then
		local var_23_0 = lua_eliminate_battle_endless_mode.configDict[arg_23_1]

		if var_23_0 == nil then
			return nil
		end

		local var_23_1 = {
			hp = tonumber(var_23_0.hpUp)
		}

		for iter_23_0 = 1, 5 do
			local var_23_2 = var_23_0["skill" .. iter_23_0]
			local var_23_3 = var_23_0["powerUp" .. iter_23_0]

			if not string.nilorempty(var_23_2) then
				var_23_1[var_23_2] = tonumber(var_23_3)
			end
		end

		arg_23_0._battleEndLessMode[arg_23_1] = var_23_1
	end

	return arg_23_0._battleEndLessMode[arg_23_1]
end

function var_0_0.getDamageValue(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_0._eliminateBattleDamage == nil then
		arg_24_0._eliminateBattleDamage = {}
	end

	if arg_24_0._eliminateBattleDamage[arg_24_1] == nil then
		arg_24_0._eliminateBattleDamage[arg_24_1] = {}
	end

	if arg_24_0._eliminateBattleDamage[arg_24_1][arg_24_2] == nil then
		local var_24_0 = {}
		local var_24_1 = arg_24_0:getEliminateBattleEliminateBlocks(arg_24_1, arg_24_2)

		if var_24_1 ~= nil then
			local var_24_2 = string.splitToNumber(var_24_1.damageRate, "#")

			var_24_0[1] = var_24_2[1]
			var_24_0[2] = var_24_2[2]
		end

		arg_24_0._eliminateBattleDamage[arg_24_1][arg_24_2] = var_24_0
	end

	local var_24_3 = arg_24_0._eliminateBattleDamage[arg_24_1][arg_24_2]

	return var_24_3[1] or 0, var_24_3[2] or 0
end

function var_0_0.getHealValue(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_0._eliminateBattleHeal == nil then
		arg_25_0._eliminateBattleHeal = {}
	end

	if arg_25_0._eliminateBattleHeal[arg_25_1] == nil then
		arg_25_0._eliminateBattleHeal[arg_25_1] = {}
	end

	if arg_25_0._eliminateBattleHeal[arg_25_1][arg_25_2] == nil then
		local var_25_0 = {}
		local var_25_1 = arg_25_0:getEliminateBattleEliminateBlocks(arg_25_1, arg_25_2)

		if var_25_1 ~= nil then
			local var_25_2 = string.splitToNumber(var_25_1.healRate, "#")

			var_25_0[1] = var_25_2[1]
			var_25_0[2] = var_25_2[2]
		end

		arg_25_0._eliminateBattleHeal[arg_25_1][arg_25_2] = var_25_0
	end

	local var_25_3 = arg_25_0._eliminateBattleHeal[arg_25_1][arg_25_2]

	return var_25_3[1] or 0, var_25_3[2] or 0
end

function var_0_0.clearLevelCache(arg_26_0)
	arg_26_0._enemyRandomIdsConfig = nil
	arg_26_0._enemyEndlessLibraryRound = nil
	arg_26_0._selectEnemyIds = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
