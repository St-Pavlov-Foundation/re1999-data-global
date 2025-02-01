module("modules.logic.versionactivity1_6.dungeon.rpc.VersionActivity1_6DungeonRpc", package.seeall)

slot0 = class("VersionActivity1_6DungeonRpc", BaseRpc)

function slot0.sendGet149InfoRequest(slot0, slot1, slot2)
	slot3 = Activity149Module_pb.Get149InfoRequest()
	slot3.activityId = VersionActivity1_6Enum.ActivityId.DungeonBossRush

	return slot0:sendMsg(slot3, slot1, slot2)
end

function slot0.onReceiveGet149InfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	VersionActivity1_6DungeonBossModel.instance:onReceiveInfos(slot2)
	VersionActivity1_6DungeonController.instance:dispatchEvent(VersionActivity1_6DungeonEvent.DungeonBossInfoUpdated)
end

function slot0.sendAct149GetScoreRewardsRequest(slot0, slot1, slot2)
	slot3 = Activity149Module_pb.Act149GetScoreRewardsRequest()
	slot3.activityId = VersionActivity1_6Enum.ActivityId.DungeonBossRush

	return slot0:sendMsg(slot3, slot1, slot2)
end

function slot0.onReceiveAct149GetScoreRewardsReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	VersionActivity1_6DungeonBossModel.instance:onReceiveScoreInfos(slot2)
end

function slot0.sendAct149GainDailyBonusRequest(slot0, slot1, slot2)
	slot3 = Activity149Module_pb.Act149GainDailyBonusRequest()
	slot3.activityId = VersionActivity1_6Enum.ActivityId.DungeonBossRush

	return slot0:sendMsg(slot3, slot1, slot2)
end

function slot0.onReceiveAct149GainDailyBonusReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	if slot2.activityId ~= 0 then
		VersionActivity1_6DungeonBossModel.instance:SetOpenBossViewWithDailyBonus(true)
	end
end

function slot0.sendGet148InfoRequest(slot0, slot1, slot2)
	slot3 = Activity148Module_pb.Get148InfoRequest()
	slot3.activityId = VersionActivity1_6Enum.ActivityId.DungeonSkillTree

	return slot0:sendMsg(slot3, slot1, slot2)
end

function slot0.onReceiveGet148InfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	VersionActivity1_6DungeonSkillModel.instance:onReceiveInfos(slot2)
end

function slot0.sendAct148UpLevelRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity148Module_pb.Act148UpLevelRequest()
	slot4.activityId = VersionActivity1_6Enum.ActivityId.DungeonSkillTree
	slot4.type = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAct148UpLevelReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	VersionActivity1_6DungeonSkillModel.instance:onReceiveLevelUpReply(slot2)
	VersionActivity1_6DungeonController.instance:dispatchEvent(Act148Event.SkillLvUp, slot2.skillTree.level)
end

function slot0.sendAct148DownLevelRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity148Module_pb.Act148DownLevelRequest()
	slot4.activityId = VersionActivity1_6Enum.ActivityId.DungeonSkillTree
	slot4.type = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAct148DownLevelReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	VersionActivity1_6DungeonSkillModel.instance:onReceiveLevelDownReply(slot2)
	VersionActivity1_6DungeonController.instance:dispatchEvent(Act148Event.SkillLvDown, slot2.skillTree.level)
end

function slot0.sendAct148ResetRequest(slot0, slot1, slot2)
	slot3 = Activity148Module_pb.Act148ResetRequest()
	slot3.activityId = VersionActivity1_6Enum.ActivityId.DungeonSkillTree

	return slot0:sendMsg(slot3, slot1, slot2)
end

function slot0.onReceiveAct148ResetReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	VersionActivity1_6DungeonSkillModel.instance:onResetSkillInfos(slot2)
	VersionActivity1_6DungeonController.instance:dispatchEvent(Act148Event.SkillReset)
end

slot0.instance = slot0.New()

return slot0
