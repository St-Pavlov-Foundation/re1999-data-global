module("modules.logic.dungeon.controller.DungeonHelper", package.seeall)

local var_0_0 = _M

function var_0_0.getEpisodeRecommendLevel(arg_1_0, arg_1_1)
	local var_1_0 = DungeonConfig.instance:getEpisodeBattleId(arg_1_0)

	if not var_1_0 then
		return 0
	end

	return var_0_0.getBattleRecommendLevel(var_1_0, arg_1_1)
end

function var_0_0.getBattleRecommendLevel(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1 and "levelEasy" or "level"
	local var_2_1 = lua_battle.configDict[arg_2_0]

	if not var_2_1 then
		return 0
	end

	local var_2_2 = {}
	local var_2_3 = {}
	local var_2_4
	local var_2_5

	for iter_2_0, iter_2_1 in ipairs(string.splitToNumber(var_2_1.monsterGroupIds, "#")) do
		local var_2_6 = lua_monster_group.configDict[iter_2_1].bossId
		local var_2_7 = string.splitToNumber(lua_monster_group.configDict[iter_2_1].monster, "#")

		for iter_2_2, iter_2_3 in ipairs(var_2_7) do
			if var_0_0.isBossId(var_2_6, iter_2_3) then
				table.insert(var_2_3, iter_2_3)
			else
				table.insert(var_2_2, iter_2_3)
			end
		end
	end

	if #var_2_3 > 0 then
		return lua_monster.configDict[var_2_3[1]][var_2_0]
	elseif #var_2_2 > 0 then
		local var_2_8 = 0

		for iter_2_4, iter_2_5 in ipairs(var_2_2) do
			var_2_8 = var_2_8 + lua_monster.configDict[iter_2_5][var_2_0]
		end

		return math.ceil(var_2_8 / #var_2_2)
	else
		return 0
	end
end

function var_0_0.isBossId(arg_3_0, arg_3_1)
	local var_3_0 = string.splitToNumber(arg_3_0, "#")

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		if arg_3_1 == iter_3_1 then
			return true
		end
	end
end

function var_0_0.getEpisodeName(arg_4_0)
	local var_4_0 = DungeonConfig.instance:getEpisodeCO(arg_4_0)
	local var_4_1 = var_4_0 and DungeonConfig.instance:getChapterCO(var_4_0.chapterId)

	if not var_4_0 or not var_4_1 then
		return nil
	end

	local var_4_2 = var_4_1.chapterIndex
	local var_4_3, var_4_4 = DungeonConfig.instance:getChapterEpisodeIndexWithSP(var_4_1.id, var_4_0.id)

	return string.format("%s-%s", var_4_2, var_4_3)
end

return var_0_0
