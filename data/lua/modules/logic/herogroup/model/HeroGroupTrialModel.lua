module("modules.logic.herogroup.model.HeroGroupTrialModel", package.seeall)

local var_0_0 = class("HeroGroupTrialModel", BaseModel)

function var_0_0.ctor(arg_1_0)
	arg_1_0.curBattleId = nil
	arg_1_0._limitNum = 0
	arg_1_0._trialEquipMo = BaseModel.New()

	var_0_0.super.ctor(arg_1_0)
end

function var_0_0.setTrialByBattleId(arg_2_0, arg_2_1)
	arg_2_1 = arg_2_1 or HeroGroupModel.instance.battleId

	if arg_2_0.curBattleId == arg_2_1 then
		return
	end

	arg_2_0.curBattleId = arg_2_1

	local var_2_0 = lua_battle.configDict[arg_2_1]

	if not var_2_0 then
		return
	end

	arg_2_0._trialEquipMo:clear()
	var_0_0.super.clear(arg_2_0)

	local var_2_1 = var_2_0.trialHeros

	if HeroGroupModel.instance.episodeId and arg_2_1 == HeroGroupModel.instance.battleId then
		var_2_1 = HeroGroupHandler.getTrialHeros(HeroGroupModel.instance.episodeId)
	end

	if not string.nilorempty(var_2_1) then
		local var_2_2 = GameUtil.splitString2(var_2_1, true)

		for iter_2_0, iter_2_1 in pairs(var_2_2) do
			local var_2_3 = iter_2_1[1]
			local var_2_4 = iter_2_1[2] or 0

			if lua_hero_trial.configDict[var_2_3] and lua_hero_trial.configDict[var_2_3][var_2_4] then
				local var_2_5 = HeroMo.New()

				var_2_5:initFromTrial(unpack(iter_2_1))
				arg_2_0:addAtLast(var_2_5)
			else
				logError(string.format("试用角色配置不存在:%s#%s", var_2_3, var_2_4))
			end
		end
	end

	if not string.nilorempty(var_2_0.trialEquips) then
		local var_2_6 = string.splitToNumber(var_2_0.trialEquips, "|")

		for iter_2_2, iter_2_3 in pairs(var_2_6) do
			local var_2_7 = lua_equip_trial.configDict[iter_2_3]

			if var_2_7 then
				local var_2_8 = EquipMO.New()

				var_2_8:initByTrialEquipCO(var_2_7)
				arg_2_0._trialEquipMo:addAtLast(var_2_8)
			else
				logError("试用心相配置不存在" .. tostring(iter_2_3))
			end
		end
	end

	arg_2_0._limitNum = var_2_0.trialLimit

	local var_2_9 = ToughBattleModel.instance:getAddTrialHeros()

	if var_2_9 then
		arg_2_0._limitNum = math.min(4, #var_2_9 + arg_2_0._limitNum)

		for iter_2_4, iter_2_5 in pairs(var_2_9) do
			local var_2_10 = HeroMo.New()

			var_2_10:initFromTrial(iter_2_5)
			arg_2_0:addAtLast(var_2_10)
		end
	end
end

function var_0_0.setTrialByOdysseyGroupMo(arg_3_0, arg_3_1)
	arg_3_0:clear()

	arg_3_0._limitNum = 1

	if arg_3_1.trialDict then
		for iter_3_0, iter_3_1 in pairs(arg_3_1.trialDict) do
			local var_3_0 = iter_3_1[1]

			if var_3_0 ~= nil and var_3_0 ~= 0 then
				local var_3_1 = HeroMo.New()

				var_3_1:initFromTrial(var_3_0, 0, iter_3_0)
				arg_3_0:addAtLast(var_3_1)

				local var_3_2 = lua_hero_trial.configDict[var_3_0][0]
				local var_3_3 = EquipMO.New()

				var_3_3:initByTrialCO(var_3_2)
				var_3_3:clearRecommend()
				arg_3_0._trialEquipMo:addAtLast(var_3_3)
			end
		end
	end
end

function var_0_0.setTrailByTrialIdList(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:clear()

	arg_4_0._limitNum = arg_4_2 or arg_4_0._limitNum

	if arg_4_1 then
		for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
			arg_4_0:addTrialHero(iter_4_1)
		end
	end
end

function var_0_0.addTrialHero(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_1 or arg_5_1 == 0 then
		return
	end

	arg_5_2 = arg_5_2 or 0

	local var_5_0 = HeroMo.New()

	var_5_0:initFromTrial(arg_5_1, arg_5_2)
	arg_5_0:addAtLast(var_5_0)

	local var_5_1 = lua_hero_trial.configDict[arg_5_1][arg_5_2]
	local var_5_2 = EquipMO.New()

	var_5_2:initByTrialCO(var_5_1)
	arg_5_0._trialEquipMo:addAtLast(var_5_2)
end

local var_0_1 = false
local var_0_2 = false

function var_0_0.sortByLevelAndRare(arg_6_0, arg_6_1, arg_6_2)
	var_0_1 = arg_6_1
	var_0_2 = arg_6_2

	arg_6_0:sort(var_0_0.sortMoFunc)
end

function var_0_0.sortMoFunc(arg_7_0, arg_7_1)
	if var_0_1 then
		if arg_7_0.level ~= arg_7_1.level then
			if var_0_2 then
				return arg_7_0.level < arg_7_1.level
			else
				return arg_7_0.level > arg_7_1.level
			end
		elseif arg_7_0.config.rare ~= arg_7_1.config.rare then
			return arg_7_0.config.rare > arg_7_1.config.rare
		end
	elseif arg_7_0.config.rare ~= arg_7_1.config.rare then
		if var_0_2 then
			return arg_7_0.config.rare < arg_7_1.config.rare
		else
			return arg_7_0.config.rare > arg_7_1.config.rare
		end
	elseif arg_7_0.level ~= arg_7_1.level then
		return arg_7_0.level > arg_7_1.level
	end

	return arg_7_0.config.id < arg_7_1.config.id
end

function var_0_0.setFilter(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._filterDmgs = arg_8_1
	arg_8_0._filterCareers = arg_8_2
end

function var_0_0.getFilterList(arg_9_0)
	arg_9_0:checkBattleIdIsVaild()

	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_0:getList()) do
		if (not arg_9_0._filterCareers or tabletool.indexOf(arg_9_0._filterCareers, iter_9_1.config.career)) and (not arg_9_0._filterDmgs or tabletool.indexOf(arg_9_0._filterDmgs, iter_9_1.config.dmgType)) then
			table.insert(var_9_0, iter_9_1)
		end
	end

	return var_9_0
end

function var_0_0.clear(arg_10_0)
	arg_10_0.curBattleId = nil
	arg_10_0._limitNum = 0

	arg_10_0._trialEquipMo:clear()
	var_0_0.super.clear(arg_10_0)
end

function var_0_0.getLimitNum(arg_11_0)
	arg_11_0:checkBattleIdIsVaild()

	return arg_11_0._limitNum
end

function var_0_0.getHeroMo(arg_12_0, arg_12_1)
	return arg_12_0:getById(tostring(tonumber(arg_12_1.id .. "." .. arg_12_1.trialTemplate) - 1099511627776))
end

function var_0_0.getEquipMo(arg_13_0, arg_13_1)
	return arg_13_0._trialEquipMo:getById(tonumber(arg_13_1))
end

function var_0_0.getTrialEquipList(arg_14_0)
	return arg_14_0._trialEquipMo:getList()
end

function var_0_0.checkBattleIdIsVaild(arg_15_0)
	if arg_15_0.curBattleId and HeroGroupModel.instance.battleId and HeroGroupModel.instance.battleId > 0 and arg_15_0.curBattleId ~= HeroGroupModel.instance.battleId then
		arg_15_0:clear()
	end
end

function var_0_0.isOnlyUseTrial(arg_16_0)
	arg_16_0:checkBattleIdIsVaild()

	if not arg_16_0.curBattleId then
		return false
	end

	local var_16_0 = lua_battle.configDict[arg_16_0.curBattleId]

	return arg_16_0._limitNum > 0 and var_16_0.onlyTrial == 1
end

function var_0_0.haveTrialEquip(arg_17_0)
	arg_17_0:checkBattleIdIsVaild()

	return arg_17_0._trialEquipMo:getCount() > 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
