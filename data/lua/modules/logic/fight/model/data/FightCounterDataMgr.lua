module("modules.logic.fight.model.data.FightCounterDataMgr", package.seeall)

local var_0_0 = FightDataClass("FightCounterDataMgr", FightDataMgrBase)

var_0_0.CounterType = {}

local var_0_1 = {}

for iter_0_0, iter_0_1 in pairs(var_0_0.CounterType) do
	var_0_1[iter_0_1] = iter_0_0
end

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.counterDic = {}
end

function var_0_0.getCounter(arg_2_0, arg_2_1)
	return arg_2_0.counterDic[arg_2_1] or 0
end

function var_0_0.addCounter(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.counterDic[arg_3_1] or 0

	arg_3_0.counterDic[arg_3_1] = var_3_0 + 1
end

function var_0_0.removeCounter(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.counterDic[arg_4_1] or 0

	arg_4_0.counterDic[arg_4_1] = var_4_0 - 1
end

function var_0_0.printCounterInfo(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.counterDic) do
		logError("计数器 key = " .. var_0_1[iter_5_0] .. ", value = " .. iter_5_1)
	end
end

return var_0_0
