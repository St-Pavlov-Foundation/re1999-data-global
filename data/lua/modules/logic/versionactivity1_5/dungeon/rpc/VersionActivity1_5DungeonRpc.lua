module("modules.logic.versionactivity1_5.dungeon.rpc.VersionActivity1_5DungeonRpc", package.seeall)

local var_0_0 = class("VersionActivity1_5DungeonRpc", BaseRpc)

function var_0_0.sendGet139InfosRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = Activity139Module_pb.Get139InfosRequest()

	var_1_0.activityId = VersionActivity1_5Enum.ActivityId.DungeonExploreTask

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGet139InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	VersionActivity1_5RevivalTaskModel.instance:updateExploreTaskInfo(arg_2_2.gainedExploreReward)
	VersionActivity1_5RevivalTaskModel.instance:updateHeroTaskInfos(arg_2_2.heroTaskInfos)
	VersionActivity1_5DungeonModel.instance:addDispatchInfos(arg_2_2.dispatchInfos)
end

function var_0_0.sendAct139DispatchRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity139Module_pb.Act139DispatchRequest()

	var_3_0.activityId = VersionActivity1_5Enum.ActivityId.DungeonExploreTask
	var_3_0.id = arg_3_1

	for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
		var_3_0.heroIds:append(iter_3_1)
	end

	return arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveAct139DispatchReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	local var_4_0 = tonumber(arg_4_2.startTime)
	local var_4_1 = math.floor(var_4_0 / 1000)

	ServerTime.update(var_4_1)
	VersionActivity1_5DungeonModel.instance:addOneDispatchInfo(arg_4_2.id, arg_4_2.endTime, arg_4_2.heroIds)
end

function var_0_0.sendAct139InterruptDispatchRequest(arg_5_0, arg_5_1)
	local var_5_0 = Activity139Module_pb.Act139InterruptDispatchRequest()

	var_5_0.activityId = VersionActivity1_5Enum.ActivityId.DungeonExploreTask
	var_5_0.id = arg_5_1

	return arg_5_0:sendMsg(var_5_0)
end

function var_0_0.onReceiveAct139InterruptDispatchReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end

	VersionActivity1_5DungeonModel.instance:removeOneDispatchInfo(arg_6_2.id)
end

function var_0_0.sendAct139GainSubHeroTaskRewardRequest(arg_7_0, arg_7_1)
	local var_7_0 = Activity139Module_pb.Act139GainSubHeroTaskRewardRequest()

	var_7_0.id = arg_7_1

	return arg_7_0:sendMsg(var_7_0)
end

function var_0_0.onReceiveAct139GainSubHeroTaskRewardReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= 0 then
		return
	end

	VersionActivity1_5RevivalTaskModel.instance:gainedSubTaskReward(arg_8_2.id)
end

function var_0_0.sendAct139GainHeroTaskRewardRequest(arg_9_0, arg_9_1)
	local var_9_0 = Activity139Module_pb.Act139GainHeroTaskRewardRequest()

	var_9_0.id = arg_9_1

	return arg_9_0:sendMsg(var_9_0)
end

function var_0_0.onReceiveAct139GainHeroTaskRewardReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 ~= 0 then
		return
	end

	VersionActivity1_5RevivalTaskModel.instance:gainedHeroTaskReward(arg_10_2.id)
end

function var_0_0.sendAct139GainExploreRewardRequest(arg_11_0)
	local var_11_0 = Activity139Module_pb.Act139GainExploreRewardRequest()

	var_11_0.activityId = VersionActivity1_5Enum.ActivityId.DungeonExploreTask

	return arg_11_0:sendMsg(var_11_0)
end

function var_0_0.onReceiveAct139GainExploreRewardReply(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 ~= 0 then
		return
	end

	VersionActivity1_5RevivalTaskModel.instance:gainedExploreTaskReward(arg_12_2.id)
end

function var_0_0.sendGet140InfosRequest(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = Activity140Module_pb.Get140InfosRequest()

	var_13_0.activityId = VersionActivity1_5Enum.ActivityId.DungeonBuilding

	return arg_13_0:sendMsg(var_13_0, arg_13_1, arg_13_2)
end

function var_0_0.onReceiveGet140InfosReply(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 ~= 0 then
		return
	end

	VersionActivity1_5BuildModel.instance:initBuildInfoList(arg_14_2.info)
end

function var_0_0.sendAct140BuildRequest(arg_15_0, arg_15_1)
	local var_15_0 = Activity140Module_pb.Act140BuildRequest()

	var_15_0.activityId = VersionActivity1_5Enum.ActivityId.DungeonBuilding
	var_15_0.id = arg_15_1

	return arg_15_0:sendMsg(var_15_0)
end

function var_0_0.onReceiveAct140BuildReply(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 ~= 0 then
		return
	end

	VersionActivity1_5BuildModel.instance:addHadBuild(arg_16_2.id)
end

function var_0_0.sendAct140SelectBuildRequest(arg_17_0, arg_17_1)
	local var_17_0 = Activity140Module_pb.Act140SelectBuildRequest()

	var_17_0.activityId = VersionActivity1_5Enum.ActivityId.DungeonBuilding

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		table.insert(var_17_0.ids, iter_17_1)
	end

	return arg_17_0:sendMsg(var_17_0)
end

function var_0_0.onReceiveAct140SelectBuildReply(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 ~= 0 then
		return
	end

	VersionActivity1_5BuildModel.instance:updateSelectBuild(arg_18_2.ids)
end

function var_0_0.sendAct140GainProgressRewardRequest(arg_19_0)
	local var_19_0 = Activity140Module_pb.Act140GainProgressRewardRequest()

	var_19_0.activityId = VersionActivity1_5Enum.ActivityId.DungeonBuilding

	return arg_19_0:sendMsg(var_19_0)
end

function var_0_0.onReceiveAct140GainProgressRewardReply(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1 ~= 0 then
		return
	end

	VersionActivity1_5BuildModel.instance:updateGainedReward(true)
end

var_0_0.instance = var_0_0.New()

return var_0_0
