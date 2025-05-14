module("modules.logic.summonsimulationpick.model.SummonSimulationPickModel", package.seeall)

local var_0_0 = class("SummonSimulationPickModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._actInfo = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._actInfo = {}
end

function var_0_0.setActInfo(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_0._actInfo[arg_3_1] or SummonSimulationInfoMo.New()

	var_3_0:update(arg_3_2, arg_3_3)

	arg_3_0._actInfo[arg_3_1] = var_3_0
end

function var_0_0.getActInfo(arg_4_0, arg_4_1)
	return arg_4_0._actInfo[arg_4_1]
end

function var_0_0.isActivityOpen(arg_5_0, arg_5_1)
	local var_5_0 = ServerTime.now() * 1000

	if not arg_5_1 or not ActivityModel.instance:isActOnLine(arg_5_1) then
		return false
	end

	if var_5_0 < ActivityModel.instance:getActStartTime(arg_5_1) then
		return false
	end

	if var_5_0 >= ActivityModel.instance:getActEndTime(arg_5_1) then
		return false
	end

	return true
end

function var_0_0.getActivityMaxSummonCount(arg_6_0, arg_6_1)
	local var_6_0 = SummonSimulationPickConfig.instance:getSummonConfigById(arg_6_1)

	if var_6_0 and var_6_0.summonTimes then
		return var_6_0.summonTimes
	end

	return 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
