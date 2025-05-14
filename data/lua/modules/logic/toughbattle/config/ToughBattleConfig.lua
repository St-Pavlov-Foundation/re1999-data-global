module("modules.logic.toughbattle.config.ToughBattleConfig", package.seeall)

local var_0_0 = class("ToughBattleConfig", BaseConfig)

function var_0_0.onInit(arg_1_0)
	arg_1_0._diffcultToCOs = nil
	arg_1_0._storyCOs = nil
	arg_1_0._allActEpisodeIds = nil
	arg_1_0._episodeIdToCO = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity158_challenge",
		"activity158_const",
		"activity158_evaluate",
		"siege_battle",
		"siege_battle_word",
		"siege_battle_hero"
	}
end

function var_0_0.getRoundDesc(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(lua_activity158_evaluate.configList) do
		if arg_3_1 <= iter_3_1.round then
			return iter_3_1.desc
		end
	end

	return ""
end

function var_0_0.isActEleCo(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return false
	end

	if arg_4_1.type ~= DungeonEnum.ElementType.ToughBattle then
		return false
	end

	if (tonumber(arg_4_1.param) or 0) ~= 0 then
		return true
	end

	return false
end

function var_0_0.getConstValue(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = ""
	local var_5_1 = lua_activity158_const.configDict[arg_5_1]

	if var_5_1 then
		var_5_0 = var_5_1.value
	end

	if arg_5_2 then
		return tonumber(var_5_0) or 0
	else
		return var_5_0
	end
end

function var_0_0._initActInfo(arg_6_0)
	if not arg_6_0._episodeIdToCO then
		arg_6_0._allActEpisodeIds = {}
		arg_6_0._episodeIdToCO = {}

		for iter_6_0, iter_6_1 in ipairs(lua_activity158_challenge.configList) do
			arg_6_0._allActEpisodeIds[iter_6_1.episodeId] = true
			arg_6_0._episodeIdToCO[iter_6_1.episodeId] = iter_6_1
		end

		for iter_6_2, iter_6_3 in ipairs(lua_siege_battle.configList) do
			arg_6_0._episodeIdToCO[iter_6_3.episodeId] = iter_6_3
		end
	end
end

function var_0_0.isActStage2EpisodeId(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getCoByEpisodeId(arg_7_1)

	if not var_7_0 then
		return false
	end

	return var_7_0.stage == 2 and arg_7_0._allActEpisodeIds[var_7_0.episodeId]
end

function var_0_0.isStage1EpisodeId(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getCoByEpisodeId(arg_8_1)

	if not var_8_0 then
		return false
	end

	return var_8_0.stage == 1
end

function var_0_0.isActEpisodeId(arg_9_0, arg_9_1)
	arg_9_0:_initActInfo()

	return arg_9_0._allActEpisodeIds[arg_9_1]
end

function var_0_0.getCoByEpisodeId(arg_10_0, arg_10_1)
	arg_10_0:_initActInfo()

	return arg_10_0._episodeIdToCO[arg_10_1]
end

function var_0_0.getCOByDiffcult(arg_11_0, arg_11_1)
	if not arg_11_0._diffcultToCOs then
		arg_11_0._diffcultToCOs = {}

		for iter_11_0, iter_11_1 in ipairs(lua_activity158_challenge.configList) do
			local var_11_0 = arg_11_0._diffcultToCOs[iter_11_1.difficulty] or {}

			arg_11_0._diffcultToCOs[iter_11_1.difficulty] = var_11_0

			if iter_11_1.stage == 2 then
				var_11_0.stage2 = iter_11_1
			else
				if not var_11_0.stage1 then
					var_11_0.stage1 = {}
				end

				var_11_0.stage1[iter_11_1.sort] = iter_11_1
			end
		end
	end

	return arg_11_0._diffcultToCOs[arg_11_1]
end

function var_0_0.getStoryCO(arg_12_0)
	if not arg_12_0._storyCOs then
		arg_12_0._storyCOs = {}

		for iter_12_0, iter_12_1 in ipairs(lua_siege_battle.configList) do
			if iter_12_1.stage == 2 then
				arg_12_0._storyCOs.stage2 = iter_12_1
			else
				if not arg_12_0._storyCOs.stage1 then
					arg_12_0._storyCOs.stage1 = {}
				end

				arg_12_0._storyCOs.stage1[iter_12_1.sort] = iter_12_1
			end
		end
	end

	return arg_12_0._storyCOs
end

var_0_0.instance = var_0_0.New()

return var_0_0
