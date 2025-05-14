module("modules.logic.versionactivity1_6.dungeon.rpc.VersionActivity1_6DungeonRpc", package.seeall)

local var_0_0 = class("VersionActivity1_6DungeonRpc", BaseRpc)

function var_0_0.sendGet149InfoRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = Activity149Module_pb.Get149InfoRequest()

	var_1_0.activityId = VersionActivity1_6Enum.ActivityId.DungeonBossRush

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGet149InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	VersionActivity1_6DungeonBossModel.instance:onReceiveInfos(arg_2_2)
	VersionActivity1_6DungeonController.instance:dispatchEvent(VersionActivity1_6DungeonEvent.DungeonBossInfoUpdated)
end

function var_0_0.sendAct149GetScoreRewardsRequest(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = Activity149Module_pb.Act149GetScoreRewardsRequest()

	var_3_0.activityId = VersionActivity1_6Enum.ActivityId.DungeonBossRush

	return arg_3_0:sendMsg(var_3_0, arg_3_1, arg_3_2)
end

function var_0_0.onReceiveAct149GetScoreRewardsReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	VersionActivity1_6DungeonBossModel.instance:onReceiveScoreInfos(arg_4_2)
end

function var_0_0.sendAct149GainDailyBonusRequest(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = Activity149Module_pb.Act149GainDailyBonusRequest()

	var_5_0.activityId = VersionActivity1_6Enum.ActivityId.DungeonBossRush

	return arg_5_0:sendMsg(var_5_0, arg_5_1, arg_5_2)
end

function var_0_0.onReceiveAct149GainDailyBonusReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end

	if arg_6_2.activityId ~= 0 then
		VersionActivity1_6DungeonBossModel.instance:SetOpenBossViewWithDailyBonus(true)
	end
end

function var_0_0.sendGet148InfoRequest(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = Activity148Module_pb.Get148InfoRequest()

	var_7_0.activityId = VersionActivity1_6Enum.ActivityId.DungeonSkillTree

	return arg_7_0:sendMsg(var_7_0, arg_7_1, arg_7_2)
end

function var_0_0.onReceiveGet148InfoReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= 0 then
		return
	end

	VersionActivity1_6DungeonSkillModel.instance:onReceiveInfos(arg_8_2)
end

function var_0_0.sendAct148UpLevelRequest(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = Activity148Module_pb.Act148UpLevelRequest()

	var_9_0.activityId = VersionActivity1_6Enum.ActivityId.DungeonSkillTree
	var_9_0.type = arg_9_1

	return arg_9_0:sendMsg(var_9_0, arg_9_2, arg_9_3)
end

function var_0_0.onReceiveAct148UpLevelReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 ~= 0 then
		return
	end

	local var_10_0 = arg_10_2.skillTree.level

	VersionActivity1_6DungeonSkillModel.instance:onReceiveLevelUpReply(arg_10_2)
	VersionActivity1_6DungeonController.instance:dispatchEvent(Act148Event.SkillLvUp, var_10_0)
end

function var_0_0.sendAct148DownLevelRequest(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = Activity148Module_pb.Act148DownLevelRequest()

	var_11_0.activityId = VersionActivity1_6Enum.ActivityId.DungeonSkillTree
	var_11_0.type = arg_11_1

	return arg_11_0:sendMsg(var_11_0, arg_11_2, arg_11_3)
end

function var_0_0.onReceiveAct148DownLevelReply(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 ~= 0 then
		return
	end

	local var_12_0 = arg_12_2.skillTree.level

	VersionActivity1_6DungeonSkillModel.instance:onReceiveLevelDownReply(arg_12_2)
	VersionActivity1_6DungeonController.instance:dispatchEvent(Act148Event.SkillLvDown, var_12_0)
end

function var_0_0.sendAct148ResetRequest(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = Activity148Module_pb.Act148ResetRequest()

	var_13_0.activityId = VersionActivity1_6Enum.ActivityId.DungeonSkillTree

	return arg_13_0:sendMsg(var_13_0, arg_13_1, arg_13_2)
end

function var_0_0.onReceiveAct148ResetReply(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 ~= 0 then
		return
	end

	VersionActivity1_6DungeonSkillModel.instance:onResetSkillInfos(arg_14_2)
	VersionActivity1_6DungeonController.instance:dispatchEvent(Act148Event.SkillReset)
end

var_0_0.instance = var_0_0.New()

return var_0_0
