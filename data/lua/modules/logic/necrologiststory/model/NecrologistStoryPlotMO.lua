module("modules.logic.necrologiststory.model.NecrologistStoryPlotMO", package.seeall)

local var_0_0 = pureTable("NecrologistStoryPlotMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.config = NecrologistStoryConfig.instance:getPlotGroupCo(arg_1_1)
	arg_1_0.state = NecrologistStoryEnum.StoryState.Lock
	arg_1_0.situationValueDict = {}
end

function var_0_0.updateInfo(arg_2_0, arg_2_1)
	arg_2_0.state = arg_2_1.state
	arg_2_0.situationValueDict = {}

	for iter_2_0 = 1, #arg_2_1.values do
		local var_2_0 = arg_2_1.values[iter_2_0]

		arg_2_0.situationValueDict[var_2_0.key] = var_2_0.value
	end
end

function var_0_0.getState(arg_3_0)
	return arg_3_0.state
end

function var_0_0.setState(arg_4_0, arg_4_1)
	arg_4_0.state = arg_4_1
end

function var_0_0.getSituationValueTab(arg_5_0)
	return arg_5_0.situationValueDict
end

function var_0_0.setSituationValueTab(arg_6_0, arg_6_1)
	arg_6_0.situationValueDict = {}

	local var_6_0 = arg_6_0.situationValueDict

	for iter_6_0, iter_6_1 in pairs(arg_6_1) do
		var_6_0[iter_6_0] = iter_6_1
	end
end

function var_0_0.getSaveData(arg_7_0)
	local var_7_0 = NecrologistStoryModule_pb.NecrologistStoryPlotInfo()

	var_7_0.id = arg_7_0.id
	var_7_0.state = arg_7_0.state

	for iter_7_0, iter_7_1 in pairs(arg_7_0.situationValueDict) do
		local var_7_1 = NecrologistStoryModule_pb.NecrologistStorySituationValue()

		var_7_1.key = iter_7_0
		var_7_1.value = iter_7_1

		table.insert(var_7_0.values, var_7_1)
	end

	return var_7_0
end

return var_0_0
