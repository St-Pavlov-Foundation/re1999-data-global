module("modules.logic.fight.model.data.FightParamData", package.seeall)

local var_0_0 = FightDataClass("FightParamData")

var_0_0.ParamKey = {
	ProgressId = 2,
	DoomsdayClock_Range1 = 4,
	ACT191_CUR_HP_RATE = 12,
	DoomsdayClock_Range4 = 7,
	ACT191_HUNTING = 10,
	DoomsdayClock_Range3 = 6,
	ACT191_MIN_HP_RATE = 9,
	ACT191_COIN = 11,
	DoomsdayClock_Offset = 8,
	ProgressSkill = 1,
	DoomsdayClock_Value = 3,
	DoomsdayClock_Range2 = 5
}

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
		arg_1_0[iter_1_1.key] = iter_1_1.value
	end
end

function var_0_0.getKey(arg_2_0, arg_2_1)
	return arg_2_0[arg_2_1]
end

function var_0_0.isInit(arg_3_0, arg_3_1)
	return arg_3_0.initDict[arg_3_1]
end

function var_0_0.setInit(arg_4_0, arg_4_1)
	return
end

return var_0_0
