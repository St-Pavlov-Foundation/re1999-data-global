module("modules.logic.sp01.assassin2.rpc.AssassinOutSideRpc", package.seeall)

local var_0_0 = class("AssassinOutSideRpc", BaseRpc)

function var_0_0.sendGetAssassinOutSideInfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = AssassinOutSideModule_pb.GetAssassinOutSideInfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGetAssassinOutSideInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	AssassinController.instance:onGetAssassinOutSideInfo(arg_2_2.assassinOutSideInfo)
end

function var_0_0.sendBuildingLevelUpRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = AssassinOutSideModule_pb.BuildingLevelUpRequest()

	var_3_0.buildingId = arg_3_1

	return arg_3_0:sendMsg(var_3_0, arg_3_2, arg_3_3)
end

function var_0_0.onReceiveBuildingLevelUpReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	AssassinController.instance:updateBuildingInfo(arg_4_2.building)
	AssassinController.instance:updateCoinNum(arg_4_2.coin)
end

function var_0_0.sendInteractiveRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = AssassinOutSideModule_pb.InteractiveRequest()

	var_5_0.questId = arg_5_1

	arg_5_0:sendMsg(var_5_0, arg_5_2, arg_5_3)
end

function var_0_0.onReceiveInteractiveReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end
end

function var_0_0.sendHeroTransferCareerRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = AssassinOutSideModule_pb.HeroTransferCareerRequest()

	var_7_0.heroId = arg_7_1
	var_7_0.careerId = arg_7_2

	arg_7_0:sendMsg(var_7_0, arg_7_3, arg_7_4)
end

function var_0_0.onReceiveHeroTransferCareerReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= 0 then
		return
	end
end

function var_0_0.sendEquipHeroItemRequest(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	local var_9_0 = AssassinOutSideModule_pb.EquipHeroItemRequest()

	var_9_0.heroId = arg_9_1
	var_9_0.index = arg_9_2
	var_9_0.itemType = arg_9_3

	arg_9_0:sendMsg(var_9_0, arg_9_4, arg_9_5)
end

function var_0_0.onReceiveEquipHeroItemReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 ~= 0 then
		return
	end
end

function var_0_0.onReceiveAssassinOutSideUnlockPush(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 ~= 0 then
		return
	end

	AssassinController.instance:onUnlockQuestContent(arg_11_2.unlockMapIds, arg_11_2.items, arg_11_2.heros, arg_11_2.questIds)
	AssassinController.instance:onGetBuildingUnlockInfo(arg_11_2.unlockBuildIds)
end

function var_0_0.sendGetAssassinLibraryInfoRequest(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = AssassinOutSideModule_pb.GetAssassinLibraryInfoRequest()

	var_12_0.activityId = arg_12_1

	return arg_12_0:sendMsg(var_12_0, arg_12_2, arg_12_3)
end

function var_0_0.onReceiveGetAssassinLibraryInfoReply(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 ~= 0 then
		return
	end

	AssassinLibraryModel.instance:updateLibraryInfos(arg_13_2.unlockLibraryIds)
end

function var_0_0.onReceiveAssassinUnlockLibraryPush(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 ~= 0 then
		return
	end

	AssassinLibraryController.instance:onUnlockLibraryIds(arg_14_2.unlockLibraryIds)
end

var_0_0.instance = var_0_0.New()

return var_0_0
