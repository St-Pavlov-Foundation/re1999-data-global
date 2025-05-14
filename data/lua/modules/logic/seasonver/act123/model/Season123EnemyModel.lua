module("modules.logic.seasonver.act123.model.Season123EnemyModel", package.seeall)

local var_0_0 = class("Season123EnemyModel", BaseModel)

function var_0_0.release(arg_1_0)
	arg_1_0.selectIndex = nil
	arg_1_0.battleIdList = nil
	arg_1_0.stage = nil
	arg_1_0._groupMap = nil
	arg_1_0._monsterGroupMap = nil
	arg_1_0._group2Monsters = nil
	arg_1_0.selectMonsterGroupIndex = nil
	arg_1_0.selectMonsterIndex = nil
	arg_1_0.selectMonsterId = nil
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.activityId = arg_2_1
	arg_2_0.stage = arg_2_2
	arg_2_0.selectIndex = 1
	arg_2_0.battleIdList = var_0_0.getStageBattleIds(arg_2_1, arg_2_2)

	arg_2_0:initDatas()
	arg_2_0:initSelect(arg_2_3)
end

function var_0_0.initDatas(arg_3_0)
	arg_3_0._groupMap = {}
	arg_3_0._monsterGroupMap = {}
	arg_3_0._group2Monsters = {}
end

function var_0_0.initSelect(arg_4_0, arg_4_1)
	local var_4_0 = Season123Config.instance:getSeasonEpisodeStageCos(arg_4_0.activityId, arg_4_0.stage)

	if not var_4_0 then
		return nil
	end

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if iter_4_1.layer == arg_4_1 then
			arg_4_0.selectIndex = iter_4_0

			return
		end
	end
end

function var_0_0.getCurrentBattleGroupIds(arg_5_0)
	local var_5_0 = arg_5_0:getSelectBattleId()

	if not var_5_0 then
		return
	end

	local var_5_1 = arg_5_0._groupMap[var_5_0]

	if not var_5_1 then
		local var_5_2 = lua_battle.configDict[var_5_0]

		if string.nilorempty(var_5_2.monsterGroupIds) then
			var_5_1 = {}
		else
			var_5_1 = string.splitToNumber(var_5_2.monsterGroupIds, "#")

			for iter_5_0, iter_5_1 in ipairs(var_5_1) do
				local var_5_3 = lua_monster_group.configDict[iter_5_1]

				arg_5_0._monsterGroupMap[iter_5_1] = var_5_3

				arg_5_0:initGroup2Monster(iter_5_1, var_5_3)
			end
		end

		arg_5_0._groupMap[var_5_0] = var_5_1
	end

	return var_5_1
end

function var_0_0.initGroup2Monster(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = {}
	local var_6_1 = string.nilorempty(arg_6_2.monster)
	local var_6_2 = string.nilorempty(arg_6_2.spMonster)

	if var_6_1 and var_6_2 then
		return
	end

	local var_6_3 = var_6_1 and {} or string.splitToNumber(arg_6_2.monster, "#")
	local var_6_4 = var_6_2 and {} or string.splitToNumber(arg_6_2.spMonster, "#")

	for iter_6_0, iter_6_1 in ipairs(var_6_4) do
		table.insert(var_6_3, iter_6_1)
	end

	arg_6_0._group2Monsters[arg_6_1] = var_6_3
end

function var_0_0.getMonsterIds(arg_7_0, arg_7_1)
	return arg_7_0._group2Monsters[arg_7_1]
end

function var_0_0.setSelectIndex(arg_8_0, arg_8_1)
	arg_8_0.selectIndex = arg_8_1

	arg_8_0:getCurrentBattleGroupIds()
end

function var_0_0.getSelectedIndex(arg_9_0)
	return arg_9_0.selectIndex
end

function var_0_0.getBattleIds(arg_10_0)
	return arg_10_0.battleIdList
end

function var_0_0.getSelectBattleId(arg_11_0)
	return arg_11_0.battleIdList[arg_11_0.selectIndex]
end

function var_0_0.setEnemySelectMonsterId(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0.selectMonsterGroupIndex = arg_12_1
	arg_12_0.selectMonsterIndex = arg_12_2
	arg_12_0.selectMonsterId = arg_12_3
end

function var_0_0.getBossId(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getSelectBattleId()

	if not var_13_0 then
		return
	end

	local var_13_1 = FightModel.instance:getSelectMonsterGroupId(arg_13_1, var_13_0)
	local var_13_2 = var_13_1 and lua_monster_group.configDict[var_13_1]

	return var_13_2 and not string.nilorempty(var_13_2.bossId) and var_13_2.bossId or nil
end

function var_0_0.getStageBattleIds(arg_14_0, arg_14_1)
	local var_14_0 = {}
	local var_14_1 = Season123Config.instance:getSeasonEpisodeStageCos(arg_14_0, arg_14_1)

	if not var_14_1 then
		return var_14_0
	end

	for iter_14_0, iter_14_1 in ipairs(var_14_1) do
		local var_14_2 = DungeonConfig.instance:getEpisodeCO(iter_14_1.episodeId)

		if var_14_2 then
			table.insert(var_14_0, var_14_2.battleId)
		end
	end

	return var_14_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
