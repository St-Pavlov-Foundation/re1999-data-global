module("modules.logic.versionactivity1_5.dungeon.rpc.VersionActivity1_5DungeonRpc", package.seeall)

slot0 = class("VersionActivity1_5DungeonRpc", BaseRpc)

function slot0.sendGet139InfosRequest(slot0, slot1, slot2)
	slot3 = Activity139Module_pb.Get139InfosRequest()
	slot3.activityId = VersionActivity1_5Enum.ActivityId.DungeonExploreTask

	return slot0:sendMsg(slot3, slot1, slot2)
end

function slot0.onReceiveGet139InfosReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	VersionActivity1_5RevivalTaskModel.instance:updateExploreTaskInfo(slot2.gainedExploreReward)
	VersionActivity1_5RevivalTaskModel.instance:updateHeroTaskInfos(slot2.heroTaskInfos)
	VersionActivity1_5DungeonModel.instance:addDispatchInfos(slot2.dispatchInfos)
end

function slot0.sendAct139DispatchRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity139Module_pb.Act139DispatchRequest()
	slot5.activityId = VersionActivity1_5Enum.ActivityId.DungeonExploreTask
	slot5.id = slot1

	for slot9, slot10 in ipairs(slot2) do
		slot5.heroIds:append(slot10)
	end

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct139DispatchReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	ServerTime.update(math.floor(tonumber(slot2.startTime) / 1000))
	VersionActivity1_5DungeonModel.instance:addOneDispatchInfo(slot2.id, slot2.endTime, slot2.heroIds)
end

function slot0.sendAct139InterruptDispatchRequest(slot0, slot1)
	slot2 = Activity139Module_pb.Act139InterruptDispatchRequest()
	slot2.activityId = VersionActivity1_5Enum.ActivityId.DungeonExploreTask
	slot2.id = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveAct139InterruptDispatchReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	VersionActivity1_5DungeonModel.instance:removeOneDispatchInfo(slot2.id)
end

function slot0.sendAct139GainSubHeroTaskRewardRequest(slot0, slot1)
	slot2 = Activity139Module_pb.Act139GainSubHeroTaskRewardRequest()
	slot2.id = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveAct139GainSubHeroTaskRewardReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	VersionActivity1_5RevivalTaskModel.instance:gainedSubTaskReward(slot2.id)
end

function slot0.sendAct139GainHeroTaskRewardRequest(slot0, slot1)
	slot2 = Activity139Module_pb.Act139GainHeroTaskRewardRequest()
	slot2.id = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveAct139GainHeroTaskRewardReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	VersionActivity1_5RevivalTaskModel.instance:gainedHeroTaskReward(slot2.id)
end

function slot0.sendAct139GainExploreRewardRequest(slot0)
	slot1 = Activity139Module_pb.Act139GainExploreRewardRequest()
	slot1.activityId = VersionActivity1_5Enum.ActivityId.DungeonExploreTask

	return slot0:sendMsg(slot1)
end

function slot0.onReceiveAct139GainExploreRewardReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	VersionActivity1_5RevivalTaskModel.instance:gainedExploreTaskReward(slot2.id)
end

function slot0.sendGet140InfosRequest(slot0, slot1, slot2)
	slot3 = Activity140Module_pb.Get140InfosRequest()
	slot3.activityId = VersionActivity1_5Enum.ActivityId.DungeonBuilding

	return slot0:sendMsg(slot3, slot1, slot2)
end

function slot0.onReceiveGet140InfosReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	VersionActivity1_5BuildModel.instance:initBuildInfoList(slot2.info)
end

function slot0.sendAct140BuildRequest(slot0, slot1)
	slot2 = Activity140Module_pb.Act140BuildRequest()
	slot2.activityId = VersionActivity1_5Enum.ActivityId.DungeonBuilding
	slot2.id = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveAct140BuildReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	VersionActivity1_5BuildModel.instance:addHadBuild(slot2.id)
end

function slot0.sendAct140SelectBuildRequest(slot0, slot1)
	Activity140Module_pb.Act140SelectBuildRequest().activityId = VersionActivity1_5Enum.ActivityId.DungeonBuilding

	for slot6, slot7 in ipairs(slot1) do
		table.insert(slot2.ids, slot7)
	end

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveAct140SelectBuildReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	VersionActivity1_5BuildModel.instance:updateSelectBuild(slot2.ids)
end

function slot0.sendAct140GainProgressRewardRequest(slot0)
	slot1 = Activity140Module_pb.Act140GainProgressRewardRequest()
	slot1.activityId = VersionActivity1_5Enum.ActivityId.DungeonBuilding

	return slot0:sendMsg(slot1)
end

function slot0.onReceiveAct140GainProgressRewardReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	VersionActivity1_5BuildModel.instance:updateGainedReward(true)
end

slot0.instance = slot0.New()

return slot0
