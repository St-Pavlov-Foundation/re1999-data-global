module("modules.logic.versionactivity2_5.autochess.config.AutoChessConfig", package.seeall)

local var_0_0 = class("AutoChessConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"auto_chess_enemy",
		"auto_chess_enemy_formation",
		"auto_chess_episode",
		"auto_chess_master",
		"auto_chess_master_skill",
		"auto_chess_mall",
		"auto_chess_mall_item",
		"auto_chess_mall_coin",
		"auto_chess_mall_refresh",
		"auto_chess",
		"auto_chess_skill",
		"auto_chess_translate",
		"auto_chess_buff",
		"auto_chess_skill_eff_desc",
		"auto_chess_round",
		"auto_chess_rank",
		"autochess_task",
		"auto_chess_const",
		"auto_chess_effect"
	}
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "auto_chess_skill_eff_desc" then
		arg_3_0.skillEffectDescConfig = arg_3_2
	end
end

function var_0_0.getItemBuyCost(arg_4_0, arg_4_1)
	local var_4_0 = lua_auto_chess_mall_item.configDict[arg_4_1]

	if var_4_0 then
		local var_4_1 = string.splitToNumber(var_4_0.context, "#")
		local var_4_2 = arg_4_0:getChessCfgById(var_4_1[1], var_4_1[2])

		if string.nilorempty(var_4_2.specialShopCost) then
			return AutoChessStrEnum.CostType.Coin, var_4_0.cost
		else
			local var_4_3 = string.split(var_4_2.specialShopCost, "#")

			return var_4_3[1], tonumber(var_4_3[2])
		end
	else
		logError(string.format("不存在商品ID: %s 配置", arg_4_1))
	end
end

function var_0_0.getChessCfgById(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_2 then
		local var_5_0 = lua_auto_chess.configDict[arg_5_1][arg_5_2]

		if var_5_0 then
			return var_5_0
		else
			logError(string.format("异常:不存在棋子配置ID: %s 星级: %s", arg_5_1, arg_5_2))
		end
	else
		return lua_auto_chess.configDict[arg_5_1]
	end
end

function var_0_0.getChessCfgListByRace(arg_6_0, arg_6_1)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(lua_auto_chess.configDict) do
		local var_6_1 = iter_6_1[1]

		if var_6_1 and var_6_1.race == arg_6_1 then
			var_6_0[#var_6_0 + 1] = var_6_1
		end
	end

	return var_6_0
end

function var_0_0.getLeaderCfgList(arg_7_0)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(lua_auto_chess_master.configDict) do
		var_7_0[#var_7_0 + 1] = iter_7_0
	end

	return var_7_0
end

function var_0_0.getLeaderCfg(arg_8_0, arg_8_1)
	return lua_auto_chess_master.configDict[arg_8_1]
end

function var_0_0.getTaskByActId(arg_9_0, arg_9_1)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(lua_autochess_task.configList) do
		if iter_9_1.activityId == arg_9_1 then
			var_9_0[#var_9_0 + 1] = iter_9_1
		end
	end

	return var_9_0
end

function var_0_0.getSkillEffectDesc(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.skillEffectDescConfig.configDict[arg_10_1]

	if not var_10_0 then
		logError(string.format("异常:技能概要ID '%s' 不存在!!!", arg_10_1))
	end

	return var_10_0
end

function var_0_0.getSkillEffectDescCoByName(arg_11_0, arg_11_1)
	local var_11_0 = LangSettings.instance:getCurLang() or -1

	if not arg_11_0.skillBuffDescConfigByName then
		arg_11_0.skillBuffDescConfigByName = {}
	end

	if not arg_11_0.skillBuffDescConfigByName[var_11_0] then
		local var_11_1 = {}

		for iter_11_0, iter_11_1 in ipairs(arg_11_0.skillEffectDescConfig.configList) do
			var_11_1[iter_11_1.name] = iter_11_1
		end

		arg_11_0.skillBuffDescConfigByName[var_11_0] = var_11_1
	end

	local var_11_2 = arg_11_0.skillBuffDescConfigByName[var_11_0][arg_11_1]

	if not var_11_2 then
		logError(string.format("异常:技能概要名称 '%s' 不存在!!!", tostring(arg_11_1)))
	end

	return var_11_2
end

function var_0_0.getEpisodeCO(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(lua_auto_chess_episode.configList) do
		if iter_12_1.id == arg_12_1 then
			return iter_12_1
		end
	end

	logError(string.format("关卡ID: %s 关卡配置为空!!!", arg_12_1))
end

function var_0_0.getPveEpisodeCoList(arg_13_0, arg_13_1)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(lua_auto_chess_episode.configList) do
		if iter_13_1.activityId == arg_13_1 and iter_13_1.type == AutoChessEnum.EpisodeType.PVE then
			var_13_0[#var_13_0 + 1] = iter_13_1
		end
	end

	if next(var_13_0) then
		return var_13_0
	else
		logError(string.format("活动ID: %s PVE关卡配置为空!!!", arg_13_1))
	end
end

function var_0_0.getPvpEpisodeCo(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(lua_auto_chess_episode.configList) do
		if iter_14_1.activityId == arg_14_1 and (iter_14_1.type == AutoChessEnum.EpisodeType.PVP or iter_14_1.type == AutoChessEnum.EpisodeType.PVP2) then
			return iter_14_1
		end
	end

	logError(string.format(" 活动ID: %s PVP关卡配置为空!!!", arg_14_1))
end

var_0_0.instance = var_0_0.New()

return var_0_0
