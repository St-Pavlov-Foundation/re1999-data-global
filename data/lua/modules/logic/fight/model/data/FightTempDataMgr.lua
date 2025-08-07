module("modules.logic.fight.model.data.FightTempDataMgr", package.seeall)

local var_0_0 = FightDataClass("FightTempDataMgr", FightDataMgrBase)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.hasNextWave = false
	arg_1_0.combineCount = 0
	arg_1_0.aiJiAoQteCount = 0
	arg_1_0.aiJiAoQteEndlessLoop = 0
	arg_1_0.aiJiAoFakeHpOffset = {}
	arg_1_0.aiJiAoSelectTargetView = nil
	arg_1_0.buffDurationDic = {}
end

function var_0_0.onCancelOperation(arg_2_0)
	arg_2_0.combineCount = 0
end

function var_0_0.onStageChanged(arg_3_0)
	arg_3_0.combineCount = 0
end

return var_0_0
