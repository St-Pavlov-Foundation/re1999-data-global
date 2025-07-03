module("modules.logic.fight.model.data.FightCacheFightDataMgr", package.seeall)

local var_0_0 = FightDataClass("FightCacheFightDataMgr", FightDataMgrBase)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.cacheList = {}
	arg_1_0.cache = {}
end

function var_0_0.cacheFightWavePush(arg_2_0, arg_2_1)
	table.insert(arg_2_0.cache, arg_2_1)
	table.insert(arg_2_0.cacheList, arg_2_1)
end

function var_0_0.getAndRemove(arg_3_0)
	return table.remove(arg_3_0.cache, 1)
end

function var_0_0.getNextFightData(arg_4_0)
	return arg_4_0.cache[1]
end

return var_0_0
