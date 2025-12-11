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
		"fight_sp_effect_alf_record_buff_effect",
		"fight_sp_effect_ddg",
		"fight_sp_effect_wuerlixi",
		"fight_sp_effect_wuerlixi_timeline",
		"fight_sp_effect_wuerlixi_float",
		"fight_sp_wuerlixi_monster_star_effect",
		"fight_sp_wuerlixi_monster_star_position_offset",
		"fight_luxi_skin_effect",
		"fight_sp_sm",
		"hero3124_buff_talent"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "fight_sp_effect_alf" then
		arg_3_0.initAlfRandomList = {}

		for iter_3_0, iter_3_1 in ipairs(arg_3_2.configList) do
			if iter_3_1.skinId == 0 then
				table.insert(arg_3_0.initAlfRandomList, iter_3_1)
			end
		end
	end
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
	local var_7_0 = FightDataHelper.entityMgr:getHeroSkin(FightEnum.HeroId.ALF)
	local var_7_1 = arg_7_0:getALFRandomList(var_7_0)
	local var_7_2 = #var_7_1
	local var_7_3 = math.random(var_7_2)

	return table.remove(var_7_1, var_7_3)
end

function var_0_0.getALFRandomList(arg_8_0, arg_8_1)
	arg_8_1 = arg_8_1 or 0

	if not arg_8_0.alfRandomDict then
		arg_8_0.alfRandomDict = {}
	end

	local var_8_0 = arg_8_0.alfRandomDict[arg_8_1]

	if not var_8_0 then
		var_8_0 = {}
		arg_8_0.alfRandomDict[arg_8_1] = var_8_0
	end

	for iter_8_0, iter_8_1 in ipairs(lua_fight_sp_effect_alf.configList) do
		if iter_8_1.skinId == arg_8_1 then
			table.insert(var_8_0, iter_8_1)
		end
	end

	if #var_8_0 < 1 then
		for iter_8_2, iter_8_3 in ipairs(arg_8_0.initAlfRandomList) do
			table.insert(var_8_0, iter_8_3)
		end
	end

	return var_8_0
end

function var_0_0.isKSDLSpecialBuff(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return false
	end

	arg_9_0:initKSDLSpecialBuffCo()

	return arg_9_0:getKSDLSpecialBuffRank(arg_9_1) ~= nil
end

function var_0_0.getKSDLSpecialBuffRank(arg_10_0, arg_10_1)
	if not arg_10_1 then
		return
	end

	arg_10_0:initKSDLSpecialBuffCo()

	return arg_10_0.ksdlBuffDict[arg_10_1]
end

function var_0_0.initKSDLSpecialBuffCo(arg_11_0)
	if arg_11_0.ksdlBuffDict then
		return arg_11_0.ksdlBuffDict
	end

	arg_11_0.ksdlBuffDict = {}

	for iter_11_0, iter_11_1 in ipairs(lua_hero3124_buff_talent.configList) do
		arg_11_0.ksdlBuffDict[iter_11_1.buffId] = iter_11_1.rank
	end

	return arg_11_0.ksdlBuffDict
end

var_0_0.tempEntityMoList = {}

function var_0_0.getAlfCardAddEffect(arg_12_0)
	local var_12_0 = 0
	local var_12_1 = var_0_0.tempEntityMoList
	local var_12_2 = FightDataHelper.entityMgr:getMyNormalList(var_12_1)

	for iter_12_0, iter_12_1 in ipairs(var_12_2) do
		if iter_12_1.modelId == FightEnum.HeroId.ALF then
			var_12_0 = iter_12_1.skin

			break
		end
	end

	local var_12_3 = lua_fight_sp_effect_alf_add_card.configDict[var_12_0] or lua_fight_sp_effect_alf_add_card.configList[1]

	return string.format("ui/viewres/fight/%s.prefab", var_12_3.effect)
end

var_0_0.instance = var_0_0.New()

return var_0_0
