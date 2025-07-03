module("modules.logic.fight.model.data.FightEntityEXDataMgr", package.seeall)

local var_0_0 = FightDataClass("FightEntityEXDataMgr", FightDataMgrBase)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0._exDataDic = {}
end

function var_0_0.getEntityEXData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._exDataDic[arg_2_1]
	local var_2_1 = var_2_0

	if not var_2_0 then
		var_2_0 = {}
		arg_2_0._exDataDic[arg_2_1] = var_2_0
	end

	return var_2_0, var_2_1
end

function var_0_0.setEXDataAfterAddEntityMO(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:getEntityEXData(arg_3_1.id)

	tabletool.clear(var_3_0)
	arg_3_0:initEntityExData(var_3_0)
end

function var_0_0.initEntityExData(arg_4_0, arg_4_1)
	arg_4_0:initAboutExpoint(arg_4_1)
end

function var_0_0.initAboutExpoint(arg_5_0, arg_5_1)
	arg_5_1.playCardAddExPoint = 1
	arg_5_1.simulateAddExpoint = 0
end

function var_0_0.onStageChanged(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0._exDataDic) do
		arg_6_0:initAboutExpoint(iter_6_1)
	end
end

function var_0_0.addExPoint(arg_7_0, arg_7_1)
	local var_7_0, var_7_1 = arg_7_0:getEntityEXData(arg_7_1)

	if not var_7_1 then
		arg_7_0:initAboutExpoint(var_7_0)
	end

	var_7_0.simulateAddExpoint = var_7_0.simulateAddExpoint + var_7_0.playCardAddExPoint
end

function var_0_0.getSimulateAddExpoint(arg_8_0, arg_8_1)
	local var_8_0, var_8_1 = arg_8_0:getEntityEXData(arg_8_1)

	if not var_8_1 then
		arg_8_0:initAboutExpoint(var_8_0)
	end

	return var_8_0.simulateAddExpoint
end

return var_0_0
