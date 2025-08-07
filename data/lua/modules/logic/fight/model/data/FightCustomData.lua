module("modules.logic.fight.model.data.FightCustomData", package.seeall)

local var_0_0 = FightDataClass("FightCustomData")

var_0_0.CustomDataType = {
	Act183 = 1,
	WeekwalkVer2 = 2,
	Odyssey = 5,
	Act191 = 3,
	Act128Sp = 6
}

local var_0_1 = {
	[var_0_0.CustomDataType.Act183] = true,
	[var_0_0.CustomDataType.Act191] = true,
	[var_0_0.CustomDataType.Odyssey] = true,
	[var_0_0.CustomDataType.Act128Sp] = true
}

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
		arg_1_0[iter_1_1.type] = var_0_1[iter_1_1.type] and cjson.decode(iter_1_1.data) or iter_1_1.data
	end
end

return var_0_0
