module("modules.logic.toughbattle.rpc.SiegeBattleRpc", package.seeall)

local var_0_0 = class("SiegeBattleRpc", BaseRpc)

function var_0_0.sendGetSiegeBattleInfoRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = SiegeBattleModule_pb.GetSiegeBattleInfoRequest()

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGetSiegeBattleInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		ToughBattleModel.instance:onGetStoryInfo(arg_2_2.info)
	end
end

function var_0_0.sendStartSiegeBattleRequest(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = SiegeBattleModule_pb.StartSiegeBattleRequest()

	return arg_3_0:sendMsg(var_3_0, arg_3_1, arg_3_2)
end

function var_0_0.onReceiveStartSiegeBattleReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		ToughBattleModel.instance:onGetStoryInfo(arg_4_2.info)
	end
end

function var_0_0.sendAbandonSiegeBattleRequest(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = SiegeBattleModule_pb.AbandonSiegeBattleRequest()

	return arg_5_0:sendMsg(var_5_0, arg_5_1, arg_5_2)
end

function var_0_0.onReceiveAbandonSiegeBattleReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		ToughBattleModel.instance:onGetStoryInfo(arg_6_2.info)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
