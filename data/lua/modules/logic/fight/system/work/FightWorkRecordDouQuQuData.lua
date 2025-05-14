module("modules.logic.fight.system.work.FightWorkRecordDouQuQuData", package.seeall)

local var_0_0 = class("FightWorkRecordDouQuQuData", FightWorkItem)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightDataModel.instance.douQuQuMgr

	var_1_0.entity2HeroId = var_1_0.entity2HeroId or {}

	local var_1_1 = var_1_0.index

	var_1_0.entity2HeroId[var_1_1] = {}

	for iter_1_0, iter_1_1 in pairs(FightDataHelper.entityMgr:getAllEntityMO()) do
		var_1_0.entity2HeroId[var_1_1][iter_1_1.id] = iter_1_1.modelId
	end

	arg_1_0:onDone(true)
end

return var_0_0
