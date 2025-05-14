module("modules.logic.explore.model.ExploreCounterModel", package.seeall)

local var_0_0 = class("ExploreCounterModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clearData()
end

function var_0_0.clearData(arg_3_0)
	arg_3_0._countDic = {}
end

function var_0_0.reCalcCount(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0._countDic) do
		iter_4_1:reCalcCount()
	end

	ExploreController.instance:dispatchEvent(ExploreEvent.CounterInitDone)
end

function var_0_0.addCountSource(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0._countDic[arg_5_1]

	if var_5_0 == nil then
		var_5_0 = ExploreCounterMO.New()

		var_5_0:init(arg_5_1)

		arg_5_0._countDic[arg_5_1] = var_5_0
	end

	var_5_0:addCountSource(arg_5_2)
end

function var_0_0.add(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0._countDic[arg_6_1]

	if var_6_0 then
		local var_6_1 = var_6_0.nowCount
		local var_6_2 = var_6_0:add(arg_6_2)

		if var_6_1 ~= var_6_0.nowCount then
			ExploreController.instance:dispatchEvent(ExploreEvent.CounterChange, var_6_0.tarUnitId, var_6_0.nowCount)
		end

		if var_6_2 then
			ExploreController.instance:dispatchEvent(ExploreEvent.TryTriggerUnit, var_6_0.tarUnitId, true)
		end
	end
end

function var_0_0.reduce(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0._countDic[arg_7_1]

	if var_7_0 then
		local var_7_1 = var_7_0.nowCount
		local var_7_2 = var_7_0:reduce(arg_7_2)

		if var_7_1 ~= var_7_0.nowCount then
			ExploreController.instance:dispatchEvent(ExploreEvent.CounterChange, var_7_0.tarUnitId, var_7_0.nowCount)
		end

		if var_7_2 then
			ExploreController.instance:dispatchEvent(ExploreEvent.TryCancelTriggerUnit, var_7_0.tarUnitId)
		end
	end
end

function var_0_0.getCount(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._countDic[arg_8_1]

	if var_8_0 then
		return var_8_0.nowCount
	else
		return 0
	end
end

function var_0_0.getTotalCount(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._countDic[arg_9_1]

	if var_9_0 then
		return var_9_0.tarCount
	else
		return 0
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
