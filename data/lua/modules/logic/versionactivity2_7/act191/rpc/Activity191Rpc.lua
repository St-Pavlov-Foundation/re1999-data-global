module("modules.logic.versionactivity2_7.act191.rpc.Activity191Rpc", package.seeall)

local var_0_0 = class("Activity191Rpc", BaseRpc)

function var_0_0.sendGetAct191InfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity191Module_pb.GetAct191InfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGetAct191InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	local var_2_0 = arg_2_2.activityId
	local var_2_1 = arg_2_2.info

	Activity191Model.instance:setActInfo(var_2_0, var_2_1)
end

function var_0_0.sendStart191GameRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = Activity191Module_pb.Start191GameRequest()

	var_3_0.activityId = arg_3_1

	arg_3_0:sendMsg(var_3_0, arg_3_2, arg_3_3)
end

function var_0_0.onReceiveStart191GameReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	local var_4_0 = arg_4_2.activityId
	local var_4_1 = arg_4_2.gameInfo

	Activity191Model.instance:getActInfo(var_4_0):updateGameInfo(var_4_1)
end

function var_0_0.sendSelect191InitBuildRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = Activity191Module_pb.Select191InitBuildRequest()

	var_5_0.activityId = arg_5_1
	var_5_0.initBuildId = arg_5_2

	arg_5_0:sendMsg(var_5_0, arg_5_3, arg_5_4)
end

function var_0_0.onReceiveSelect191InitBuildReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end

	local var_6_0 = arg_6_2.activityId
	local var_6_1 = arg_6_2.gameInfo
	local var_6_2 = Activity191Model.instance:getActInfo(var_6_0)

	var_6_2:updateGameInfo(var_6_1)
	var_6_2:getGameInfo():autoFill()
end

function var_0_0.sendSelect191NodeRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = Activity191Module_pb.Select191NodeRequest()

	var_7_0.activityId = arg_7_1
	var_7_0.index = arg_7_2

	arg_7_0:sendMsg(var_7_0, arg_7_3, arg_7_4)
end

function var_0_0.onReceiveSelect191NodeReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= 0 then
		return
	end

	local var_8_0 = arg_8_2.activityId
	local var_8_1 = arg_8_2.gameInfo

	Activity191Model.instance:getActInfo(var_8_0):updateGameInfo(var_8_1)
end

function var_0_0.sendFresh191ShopRequest(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = Activity191Module_pb.Fresh191ShopRequest()

	var_9_0.activityId = arg_9_1

	arg_9_0:sendMsg(var_9_0, arg_9_2, arg_9_3)
end

function var_0_0.onReceiveFresh191ShopReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 ~= 0 then
		return
	end

	local var_10_0 = arg_10_2.activityId
	local var_10_1 = arg_10_2.nodeInfo
	local var_10_2

	var_10_2.coin, var_10_2 = arg_10_2.coin, Activity191Model.instance:getActInfo(var_10_0):getGameInfo()

	var_10_2:updateCurNodeInfo(var_10_1)
end

function var_0_0.sendBuyIn191ShopRequest(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = Activity191Module_pb.BuyIn191ShopRequest()

	var_11_0.activityId = arg_11_1
	var_11_0.index = arg_11_2

	arg_11_0:sendMsg(var_11_0, arg_11_3, arg_11_4)
end

function var_0_0.onReceiveBuyIn191ShopReply(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 ~= 0 then
		return
	end

	local var_12_0 = arg_12_2.activityId
	local var_12_1 = arg_12_2.gameInfo

	Activity191Model.instance:getActInfo(var_12_0):updateGameInfo(var_12_1)
end

function var_0_0.sendLeave191ShopRequest(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = Activity191Module_pb.Leave191ShopRequest()

	var_13_0.activityId = arg_13_1

	arg_13_0:sendMsg(var_13_0, arg_13_2, arg_13_3)
end

function var_0_0.onReceiveLeave191ShopReply(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 ~= 0 then
		return
	end

	local var_14_0 = arg_14_2.activityId
	local var_14_1 = arg_14_2.gameInfo

	Activity191Model.instance:getActInfo(var_14_0):updateGameInfo(var_14_1)
end

function var_0_0.sendSelect191EnhanceRequest(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = Activity191Module_pb.Select191EnhanceRequest()

	var_15_0.activityId = arg_15_1
	var_15_0.index = arg_15_2

	arg_15_0:sendMsg(var_15_0, arg_15_3, arg_15_4)
end

function var_0_0.onReceiveSelect191EnhanceReply(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 ~= 0 then
		return
	end

	local var_16_0 = arg_16_2.activityId
	local var_16_1 = arg_16_2.gameInfo

	Activity191Model.instance:getActInfo(var_16_0):updateGameInfo(var_16_1)
end

function var_0_0.sendFresh191EnhanceRequest(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = Activity191Module_pb.Fresh191EnhanceRequest()

	var_17_0.activityId = arg_17_1
	var_17_0.index = arg_17_2

	arg_17_0:sendMsg(var_17_0, arg_17_3, arg_17_4)
end

function var_0_0.onReceiveFresh191EnhanceReply(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 ~= 0 then
		return
	end

	local var_18_0 = arg_18_2.activityId
	local var_18_1 = arg_18_2.nodeInfo

	Activity191Model.instance:getActInfo(var_18_0):getGameInfo():updateCurNodeInfo(var_18_1)
end

function var_0_0.sendGain191RewardEventRequest(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = Activity191Module_pb.Gain191RewardEventRequest()

	var_19_0.activityId = arg_19_1

	arg_19_0:sendMsg(var_19_0, arg_19_2, arg_19_3)
end

function var_0_0.onReceiveGain191RewardEventReply(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1 ~= 0 then
		return
	end

	local var_20_0 = arg_20_2.activityId
	local var_20_1 = arg_20_2.gameInfo

	Activity191Model.instance:getActInfo(var_20_0):updateGameInfo(var_20_1)
end

function var_0_0.sendChangeAct191TeamRequest(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = Activity191Module_pb.ChangeAct191TeamRequest()

	var_21_0.activityId = arg_21_1
	var_21_0.curTeamIndex = arg_21_2
	var_21_0.teamInfo.index = arg_21_3.index
	var_21_0.teamInfo.name = arg_21_3.name

	for iter_21_0, iter_21_1 in ipairs(arg_21_3.battleHeroInfo) do
		if iter_21_1.heroId ~= 0 or iter_21_1.itemUid1 ~= 0 then
			table.insert(var_21_0.teamInfo.battleHeroInfo, iter_21_1)
		end
	end

	for iter_21_2, iter_21_3 in ipairs(arg_21_3.subHeroInfo) do
		if iter_21_3.heroId ~= 0 then
			table.insert(var_21_0.teamInfo.subHeroInfo, iter_21_3)
		end
	end

	var_21_0.teamInfo.auto = arg_21_3.auto

	arg_21_0:sendMsg(var_21_0)
end

function var_0_0.onReceiveChangeAct191TeamReply(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_1 ~= 0 then
		return
	end

	local var_22_0 = arg_22_2.activityId
	local var_22_1 = arg_22_2.curTeamIndex
	local var_22_2 = arg_22_2.teamInfo
	local var_22_3

	var_22_3.rank, var_22_3 = arg_22_2.rank, Activity191Model.instance:getActInfo(var_22_0):getGameInfo()

	var_22_3:updateTeamInfo(var_22_1, var_22_2)
	Activity191Controller.instance:dispatchEvent(Activity191Event.UpdateTeamInfo)
end

function var_0_0.sendEndAct191GameRequest(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = Activity191Module_pb.EndAct191GameRequest()

	var_23_0.activityId = arg_23_1

	arg_23_0:sendMsg(var_23_0, arg_23_2, arg_23_3)
end

function var_0_0.onReceiveEndAct191GameReply(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1 ~= 0 then
		return
	end

	local var_24_0 = arg_24_2.activityId
	local var_24_1 = arg_24_2.gameEndInfo
	local var_24_2 = Activity191Model.instance:getActInfo(var_24_0)

	var_24_2:getGameInfo().state = Activity191Enum.GameState.None

	var_24_2:setEnfInfo(var_24_1)
	Activity191Controller.instance:dispatchEvent(Activity191Event.EndGame)
end

function var_0_0.onReceiveAct191GameInfoUpdatePush(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_1 ~= 0 then
		return
	end

	local var_25_0 = arg_25_2.activityId
	local var_25_1 = arg_25_2.gameInfo

	Activity191Model.instance:getActInfo(var_25_0):updateGameInfo(var_25_1)
end

function var_0_0.onReceiveAct191TriggerEffectPush(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_1 ~= 0 then
		return
	end

	local var_26_0 = arg_26_2.activityId

	Activity191Model.instance:getActInfo(var_26_0):triggerEffectPush(arg_26_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
