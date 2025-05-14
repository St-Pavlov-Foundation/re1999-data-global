module("modules.logic.versionactivity1_5.aizila.rpc.Activity144Rpc", package.seeall)

local var_0_0 = class("Activity144Rpc", BaseRpc)

function var_0_0.sendGet144InfosRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity144Module_pb.Get144InfosRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet144InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		AiZiLaController.instance:getInfosReply(arg_2_2)
	end
end

function var_0_0.sendAct144EnterEpisodeRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity144Module_pb.Act144EnterEpisodeRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.episodeId = arg_3_2

	arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveAct144EnterEpisodeReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		AiZiLaController.instance:enterEpisodeReply(arg_4_2)
	end
end

function var_0_0.sendAct144SelectOptionRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = Activity144Module_pb.Act144SelectOptionRequest()

	var_5_0.activityId = arg_5_1
	var_5_0.option = arg_5_2

	arg_5_0:sendMsg(var_5_0, arg_5_3, arg_5_4)
end

function var_0_0.onReceiveAct144SelectOptionReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		AiZiLaController.instance:selectOptionReply(arg_6_2)
	end
end

function var_0_0.sendAct144NextDayRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = Activity144Module_pb.Act144NextDayRequest()

	var_7_0.activityId = arg_7_1

	arg_7_0:sendMsg(var_7_0, arg_7_2, arg_7_3)
end

function var_0_0.onReceiveAct144NextDayReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == 0 then
		AiZiLaController.instance:nextDayReply(arg_8_2)
	end
end

function var_0_0.sendAct144SettleEpisodeRequest(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = Activity144Module_pb.Act144SettleEpisodeRequest()

	var_9_0.activityId = arg_9_1

	arg_9_0:sendMsg(var_9_0, arg_9_2, arg_9_3)
end

function var_0_0.onReceiveAct144SettleEpisodeReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == 0 then
		AiZiLaController.instance:settleEpisodeReply(arg_10_2)
	end
end

function var_0_0.onReceiveAct144SettlePush(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == 0 then
		AiZiLaController.instance:settlePush(arg_11_2)
	end
end

function var_0_0.sendAct144UpgradeEquipRequest(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = Activity144Module_pb.Act144UpgradeEquipRequest()

	var_12_0.activityId = arg_12_1
	var_12_0.equipId = arg_12_2

	arg_12_0:sendMsg(var_12_0, arg_12_3, arg_12_4)
end

function var_0_0.onReceiveAct144UpgradeEquipReply(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == 0 then
		AiZiLaController.instance:upgradeEquipReply(arg_13_2)
	end
end

function var_0_0.onReceiveAct144EpisodePush(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 == 0 then
		AiZiLaController.instance:episodePush(arg_14_2)
	end
end

function var_0_0.onReceiveAct144ItemChangePush(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 == 0 then
		AiZiLaController.instance:itemChangePush(arg_15_2)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
