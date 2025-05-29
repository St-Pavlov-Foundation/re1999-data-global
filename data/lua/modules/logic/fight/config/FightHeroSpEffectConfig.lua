module("modules.logic.fight.config.FightHeroSpEffectConfig", package.seeall)

local var_0_0 = class("FightHeroSpEffectConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"fight_sp_effect_kkny_bear_damage",
		"fight_sp_effect_kkny_heal",
		"fight_sp_effect_kkny_bear_damage_hit",
		"fight_sp_effect_bkle",
		"fight_sp_effect_ly",
		"fight_sp_effect_alf",
		"fight_sp_effect_alf_timeline",
		"fight_sp_effect_alf_add_card",
		"fight_sp_effect_ddg"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	return
end

function var_0_0.getBKLEAddBuffEffect(arg_4_0, arg_4_1)
	if arg_4_0.curSkin ~= arg_4_1 then
		arg_4_0.curSkin = arg_4_1

		arg_4_0:initBKLERandomList(arg_4_1)
	end

	if #arg_4_0.BKLEEffectList == 0 then
		arg_4_0:initBKLERandomList(arg_4_1)
	end

	local var_4_0 = #arg_4_0.BKLEEffectList

	if var_4_0 <= 1 then
		return table.remove(arg_4_0.BKLEEffectList, 1)
	end

	local var_4_1 = math.random(1, var_4_0)

	return table.remove(arg_4_0.BKLEEffectList, var_4_1)
end

function var_0_0.initBKLERandomList(arg_5_0, arg_5_1)
	arg_5_0.BKLEEffectList = arg_5_0.BKLEEffectList or {}

	tabletool.clear(arg_5_0.BKLEEffectList)

	local var_5_0 = lua_fight_sp_effect_bkle.configDict[arg_5_1]
	local var_5_1 = FightStrUtil.instance:getSplitCache(var_5_0.path, "|")

	for iter_5_0, iter_5_1 in pairs(var_5_1) do
		arg_5_0.BKLEEffectList[iter_5_0] = iter_5_1
	end
end

function var_0_0.getLYEffectCo(arg_6_0, arg_6_1)
	return lua_fight_sp_effect_ly.configDict[arg_6_1] or lua_fight_sp_effect_ly.configDict[1]
end

function var_0_0.getRandomAlfASFDMissileRes(arg_7_0)
	if arg_7_0.tempRandomList and #arg_7_0.tempRandomList > 0 then
		arg_7_0.tempRandomList = arg_7_0.tempRandomList
	else
		arg_7_0.tempRandomList = tabletool.copy(lua_fight_sp_effect_alf.configList)
	end

	local var_7_0 = #arg_7_0.tempRandomList
	local var_7_1 = math.random(var_7_0)

	return table.remove(arg_7_0.tempRandomList, var_7_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
