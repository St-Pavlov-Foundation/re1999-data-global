module("modules.logic.versionactivity1_7.lantern.rpc.Activity154Rpc", package.seeall)

local var_0_0 = class("Activity154Rpc", BaseRpc)

function var_0_0.sendGet154InfosRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity154Module_pb.Get154InfosRequest()

	var_1_0.activityId = arg_1_1

	return arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet154InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	LanternFestivalModel.instance:setActivity154Infos(arg_2_2)
	LanternFestivalController.instance:dispatchEvent(LanternFestivalEvent.InfosRefresh)
end

function var_0_0.sendAnswer154PuzzleRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = Activity154Module_pb.Answer154PuzzleRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.puzzleId = arg_3_2
	var_3_0.optionId = arg_3_3

	return arg_3_0:sendMsg(var_3_0, arg_3_4, arg_3_5)
end

function var_0_0.onReceiveAnswer154PuzzleReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	LanternFestivalModel.instance:updatePuzzleInfo(arg_4_2.info)
	LanternFestivalModel.instance:setCurPuzzleId(0)
	LanternFestivalController.instance:dispatchEvent(LanternFestivalEvent.PuzzleRewardGet)
end

var_0_0.instance = var_0_0.New()

return var_0_0
