module("modules.logic.fight.config.StressConfig", package.seeall)

local var_0_0 = class("StressConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"stress_const",
		"stress",
		"stress_rule",
		"stress_identity"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "stress" then
		arg_3_0:buildStressConfig(arg_3_2)
	elseif arg_3_1 == "stress_identity" then
		arg_3_0:buildStressIdentityConfig(arg_3_2)
	end
end

function var_0_0.buildStressConfig(arg_4_0, arg_4_1)
	arg_4_0.identity2Stress = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.configList) do
		local var_4_0 = iter_4_1.identity
		local var_4_1 = arg_4_0.identity2Stress[var_4_0]

		if not var_4_1 then
			var_4_1 = {}
			arg_4_0.identity2Stress[var_4_0] = var_4_1
		end

		local var_4_2 = iter_4_1.type
		local var_4_3 = var_4_1[var_4_2]

		if not var_4_3 then
			var_4_3 = {}
			var_4_1[var_4_2] = var_4_3
		end

		table.insert(var_4_3, iter_4_1)
	end
end

function var_0_0.buildStressIdentityConfig(arg_5_0, arg_5_1)
	arg_5_0.identityType2List = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.configList) do
		local var_5_0 = iter_5_1.identity
		local var_5_1 = arg_5_0.identityType2List[var_5_0]

		if not var_5_1 then
			var_5_1 = {}
			arg_5_0.identityType2List[var_5_0] = var_5_1
		end

		table.insert(var_5_1, iter_5_1)
	end
end

function var_0_0.getStressDict(arg_6_0, arg_6_1)
	arg_6_1 = tonumber(arg_6_1)

	return arg_6_1 and arg_6_0.identity2Stress[arg_6_1]
end

function var_0_0.getStressBehaviourName(arg_7_0, arg_7_1)
	if not arg_7_0.behaviour2ConstId then
		arg_7_0.behaviour2ConstId = {
			[FightEnum.StressBehaviour.Positive] = 12,
			[FightEnum.StressBehaviour.Negative] = 13,
			[FightEnum.StressBehaviour.Meltdown] = 14,
			[FightEnum.StressBehaviour.Resolute] = 15,
			[FightEnum.StressBehaviour.BaseAdd] = 17,
			[FightEnum.StressBehaviour.BaseReduce] = 18,
			[FightEnum.StressBehaviour.BaseResolute] = 19,
			[FightEnum.StressBehaviour.BaseMeltdown] = 20
		}
	end

	local var_7_0 = arg_7_0.behaviour2ConstId[arg_7_1]

	if not var_7_0 then
		logError("不支持的压力行为:" .. tostring(arg_7_1))

		return ""
	end

	local var_7_1 = lua_stress_const.configDict[var_7_0]

	return var_7_1 and var_7_1.value2
end

function var_0_0.getHeroIdentityList(arg_8_0, arg_8_1)
	arg_8_0.tempIdentityList = arg_8_0.tempIdentityList or {}

	tabletool.clear(arg_8_0.tempIdentityList)

	local var_8_0 = arg_8_1.career
	local var_8_1 = arg_8_0.identityType2List[FightEnum.IdentityType.Career]

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		if tonumber(iter_8_1.typeParam) == var_8_0 then
			table.insert(arg_8_0.tempIdentityList, iter_8_1)
		end
	end

	local var_8_2 = arg_8_1.heroType
	local var_8_3 = arg_8_0.identityType2List[FightEnum.IdentityType.HeroType]

	for iter_8_2, iter_8_3 in ipairs(var_8_3) do
		if tonumber(iter_8_3.typeParam) == var_8_2 then
			table.insert(arg_8_0.tempIdentityList, iter_8_3)
		end
	end

	local var_8_4 = string.split(arg_8_1.battleTag, "#")
	local var_8_5 = arg_8_0.identityType2List[FightEnum.IdentityType.BattleTag]

	for iter_8_4, iter_8_5 in ipairs(var_8_4) do
		for iter_8_6, iter_8_7 in ipairs(var_8_5) do
			if iter_8_7.typeParam == iter_8_5 then
				table.insert(arg_8_0.tempIdentityList, iter_8_7)

				break
			end
		end
	end

	local var_8_6 = arg_8_1.id
	local var_8_7 = arg_8_0.identityType2List[FightEnum.IdentityType.HeroId]

	for iter_8_8, iter_8_9 in ipairs(var_8_7) do
		if tonumber(iter_8_9.typeParam) == var_8_6 then
			table.insert(arg_8_0.tempIdentityList, iter_8_9)
		end
	end

	return arg_8_0.tempIdentityList
end

function var_0_0.getHeroIdentityText(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getHeroIdentityList(arg_9_1)
	local var_9_1 = ""

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		if iter_9_1.isNoShow ~= 1 then
			var_9_1 = var_9_1 .. string.format("<color=#d2c197><link=%s><u><%s></u></link></color>", iter_9_1.id, iter_9_1.name)
		end
	end

	return var_9_1
end

function var_0_0.getHeroTip(arg_10_0)
	return lua_stress_const.configDict[16].value2
end

var_0_0.instance = var_0_0.New()

return var_0_0
