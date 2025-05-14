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
	local var_4_1 = arg_4_0:getChessCoByItemId(arg_4_1)

	if string.nilorempty(var_4_1.specialShopCost) then
		return AutoChessStrEnum.CostType.Coin, var_4_0.cost
	else
		local var_4_2 = string.split(var_4_1.specialShopCost, "#")

		return var_4_2[1], tonumber(var_4_2[2])
	end
end

function var_0_0.getChessCoByItemId(arg_5_0, arg_5_1)
	local var_5_0 = lua_auto_chess_mall_item.configDict[arg_5_1]

	if var_5_0 then
		local var_5_1 = string.splitToNumber(var_5_0.context, "#")
		local var_5_2 = lua_auto_chess.configDict[var_5_1[1]][var_5_1[2]]

		if var_5_2 then
			return var_5_2
		else
			logError(string.format("异常:不存在棋子配置ID%s星级%s", var_5_1[1], var_5_1[2]))
		end
	else
		logError(string.format("异常:不存在商品ID%s", arg_5_1))
	end
end

function var_0_0.getTaskByActId(arg_6_0, arg_6_1)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(lua_autochess_task.configList) do
		if iter_6_1.activityId == arg_6_1 then
			var_6_0[#var_6_0 + 1] = iter_6_1
		end
	end

	return var_6_0
end

function var_0_0.getSkillEffectDesc(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.skillEffectDescConfig.configDict[arg_7_1]

	if not var_7_0 then
		logError(string.format("异常:技能概要ID '%s' 不存在!!!", arg_7_1))
	end

	return var_7_0
end

function var_0_0.getSkillEffectDescCoByName(arg_8_0, arg_8_1)
	local var_8_0 = LangSettings.instance:getCurLang() or -1

	if not arg_8_0.skillBuffDescConfigByName then
		arg_8_0.skillBuffDescConfigByName = {}
	end

	if not arg_8_0.skillBuffDescConfigByName[var_8_0] then
		local var_8_1 = {}

		for iter_8_0, iter_8_1 in ipairs(arg_8_0.skillEffectDescConfig.configList) do
			var_8_1[iter_8_1.name] = iter_8_1
		end

		arg_8_0.skillBuffDescConfigByName[var_8_0] = var_8_1
	end

	local var_8_2 = arg_8_0.skillBuffDescConfigByName[var_8_0][arg_8_1]

	if not var_8_2 then
		logError(string.format("异常:技能概要名称 '%s' 不存在!!!", tostring(arg_8_1)))
	end

	return var_8_2
end

var_0_0.instance = var_0_0.New()

return var_0_0
