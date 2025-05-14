module("modules.logic.summonsimulationpick.rpc.SummonSimulationPickRpc", package.seeall)

local var_0_0 = class("SummonSimulationPickRpc", BaseRpc)

function var_0_0.getInfo(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity170Module_pb.Get170InfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet170InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	local var_2_0 = arg_2_2.info

	SummonSimulationPickModel.instance:setActInfo(var_2_0.activityId, var_2_0)
	SummonSimulationPickController.instance:dispatchEvent(SummonSimulationEvent.onGetSummonInfo, var_2_0.activityId)
end

function var_0_0.summonSimulation(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = Activity170Module_pb.Act170SummonRequest()

	var_3_0.activityId = arg_3_1

	arg_3_0:sendMsg(var_3_0, arg_3_2, arg_3_3)
end

function var_0_0.onReceiveAct170SummonReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	local var_4_0 = arg_4_2.info

	SummonSimulationPickModel.instance:setActInfo(var_4_0.activityId, var_4_0)
	SummonSimulationPickController.instance:dispatchEvent(SummonSimulationEvent.onSummonSimulation, var_4_0.activityId)
end

function var_0_0.saveResult(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = Activity170Module_pb.Act170SaveRequest()

	var_5_0.activityId = arg_5_1

	arg_5_0:sendMsg(var_5_0, arg_5_2, arg_5_3)
end

function var_0_0.onReceiveAct170SaveReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end

	local var_6_0 = arg_6_2.info

	SummonSimulationPickModel.instance:setActInfo(var_6_0.activityId, var_6_0, true)
	SummonSimulationPickController.instance:dispatchEvent(SummonSimulationEvent.onSaveResult, var_6_0.activityId)
end

function var_0_0.selectResult(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = Activity170Module_pb.Act170SelectRequest()

	var_7_0.activityId = arg_7_1
	var_7_0.select = arg_7_2

	arg_7_0:sendMsg(var_7_0, arg_7_3, arg_7_4)
end

function var_0_0.onReceiveAct170SelectReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= 0 then
		return
	end

	local var_8_0 = arg_8_2.info

	SummonSimulationPickModel.instance:setActInfo(var_8_0.activityId, var_8_0)
	SummonSimulationPickController.instance:dispatchEvent(SummonSimulationEvent.onSelectResult, var_8_0.activityId)
	CharacterModel.instance:setGainHeroViewShowState(false)
	CharacterModel.instance:setGainHeroViewNewShowState(false)
end

var_0_0.instance = var_0_0.New()

return var_0_0
