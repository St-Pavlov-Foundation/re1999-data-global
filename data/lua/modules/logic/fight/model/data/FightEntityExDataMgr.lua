module("modules.logic.fight.model.data.FightEntityExDataMgr", package.seeall)

local var_0_0 = FightDataClass("FightEntityExDataMgr", FightDataMgrBase)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.exDataDic = {}
end

function var_0_0.getById(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.exDataDic[arg_2_1]

	if not var_2_0 then
		var_2_0 = FightEntityExData.New()
		arg_2_0.exDataDic[arg_2_1] = var_2_0
	end

	return var_2_0
end

function var_0_0.onStageChanged(arg_3_0)
	return
end

return var_0_0
