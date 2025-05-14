module("modules.logic.explore.model.mo.ExploreCounterMO", package.seeall)

local var_0_0 = pureTable("ExploreCounterMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.tarUnitId = arg_1_1
	arg_1_0.dic = {}
	arg_1_0.tarCount = 0
	arg_1_0.nowCount = 0
end

function var_0_0.addTarCount(arg_2_0)
	arg_2_0.tarCount = arg_2_0.tarCount + 1
end

function var_0_0.addCountSource(arg_3_0, arg_3_1)
	arg_3_0.dic[arg_3_1] = false
	arg_3_0.tarCount = tabletool.len(arg_3_0.dic)
end

function var_0_0.reCalcCount(arg_4_0)
	local var_4_0 = ExploreMapModel.instance:getUnitDic()

	for iter_4_0 in pairs(arg_4_0.dic) do
		local var_4_1 = var_4_0[iter_4_0]:getInteractInfoMO()

		arg_4_0.dic[iter_4_0] = var_4_1:getBitByIndex(ExploreEnum.InteractIndex.ActiveState) == 1
	end

	arg_4_0:updateNowCount()
end

function var_0_0.add(arg_5_0, arg_5_1)
	arg_5_0.dic[arg_5_1] = true

	local var_5_0 = arg_5_0.nowCount

	arg_5_0:updateNowCount()

	return var_5_0 < arg_5_0.tarCount and arg_5_0.nowCount >= arg_5_0.tarCount
end

function var_0_0.reduce(arg_6_0, arg_6_1)
	arg_6_0.dic[arg_6_1] = false

	local var_6_0 = arg_6_0.nowCount

	arg_6_0:updateNowCount()

	return var_6_0 >= arg_6_0.tarCount and arg_6_0.nowCount < arg_6_0.tarCount
end

function var_0_0.updateNowCount(arg_7_0)
	arg_7_0.nowCount = 0

	for iter_7_0, iter_7_1 in pairs(arg_7_0.dic) do
		if iter_7_1 then
			arg_7_0.nowCount = arg_7_0.nowCount + 1
		end
	end
end

return var_0_0
