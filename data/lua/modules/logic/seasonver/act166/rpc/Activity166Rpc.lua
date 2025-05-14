module("modules.logic.seasonver.act166.rpc.Activity166Rpc", package.seeall)

local var_0_0 = class("Activity166Rpc", BaseRpc)

function var_0_0.sendGet166InfosRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity166Module_pb.Get166InfosRequest()

	var_1_0.activityId = arg_1_1

	return arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet166InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	Season166Model.instance:setActInfo(arg_2_2)
end

function var_0_0.sendStartAct166BattleRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7, arg_3_8, arg_3_9, arg_3_10, arg_3_11, arg_3_12, arg_3_13)
	local var_3_0 = Activity166Module_pb.StartAct166BattleRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.episodeType = arg_3_2
	var_3_0.id = arg_3_3
	var_3_0.talentId = arg_3_4

	Season166HeroGroupUtils.buildFightGroupAssistHero(Season166HeroGroupModel.instance.heroGroupType, var_3_0.startDungeonRequest.fightGroup)
	DungeonRpc.instance:packStartDungeonRequest(var_3_0.startDungeonRequest, arg_3_5, arg_3_6, arg_3_7, arg_3_8, arg_3_9, arg_3_10, arg_3_11)

	return arg_3_0:sendMsg(var_3_0, arg_3_12, arg_3_13)
end

function var_0_0.onReceiveStartAct166BattleReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		local var_4_0 = Season166Model.instance:getBattleContext()
		local var_4_1 = Season166HeroGroupModel.instance:getEpisodeConfigId(var_4_0.episodeId)

		if var_4_0.actId == arg_4_2.activityId and var_4_1 == arg_4_2.id and var_4_0.episodeType == arg_4_2.episodeType then
			local var_4_2 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

			if var_4_2 and DungeonModel.isBattleEpisode(var_4_2) then
				DungeonFightController.instance:onReceiveStartDungeonReply(arg_4_1, arg_4_2.startDungeonReply)
			end
		end
	else
		Season166Controller.instance:dispatchEvent(Season166Event.StartFightFailed)
	end
end

function var_0_0.sendAct166AnalyInfoRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = Activity166Module_pb.Act166AnalyInfoRequest()

	var_5_0.activityId = arg_5_1
	var_5_0.infoId = arg_5_2

	return arg_5_0:sendMsg(var_5_0, arg_5_3, arg_5_4)
end

function var_0_0.onReceiveAct166AnalyInfoReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		Season166Model.instance:onReceiveAnalyInfo(arg_6_2)
		Season166Controller.instance:dispatchEvent(Season166Event.OnAnalyInfoSuccess, arg_6_2)
	end
end

function var_0_0.sendAct166ReceiveInformationBonusRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = Activity166Module_pb.Act166ReceiveInformationBonusRequest()

	var_7_0.activityId = arg_7_1

	return arg_7_0:sendMsg(var_7_0, arg_7_2, arg_7_3)
end

function var_0_0.onReceiveAct166ReceiveInformationBonusReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == 0 then
		Season166Model.instance:onReceiveInformationBonus(arg_8_2)
		Season166Controller.instance:dispatchEvent(Season166Event.OnGetInformationBonus)
	end
end

function var_0_0.sendAct166ReceiveInfoBonusRequest(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = Activity166Module_pb.Act166ReceiveInfoBonusRequest()

	var_9_0.activityId = arg_9_1
	var_9_0.infoId = arg_9_2

	return arg_9_0:sendMsg(var_9_0, arg_9_3, arg_9_4)
end

function var_0_0.onReceiveAct166ReceiveInfoBonusReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == 0 then
		Season166Model.instance:onReceiveInfoBonus(arg_10_2)
		Season166Controller.instance:dispatchEvent(Season166Event.OnGetInfoBonus)
	end
end

function var_0_0.onReceiveAct166InfoPush(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == 0 then
		Season166Model.instance:onReceiveUpdateInfos(arg_11_2)
		Season166Controller.instance:dispatchEvent(Season166Event.OnInformationUpdate)
	end
end

function var_0_0.SendAct166SetTalentSkillRequest(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = Activity166Module_pb.Act166SetTalentSkillRequest()

	var_12_0.activityId = arg_12_1
	var_12_0.talentId = arg_12_2

	for iter_12_0, iter_12_1 in ipairs(arg_12_3) do
		table.insert(var_12_0.skillIds, iter_12_1)
	end

	arg_12_0:sendMsg(var_12_0)
end

function var_0_0.onReceiveAct166SetTalentSkillReply(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == 0 then
		Season166Model.instance:onReceiveSetTalentSkill(arg_13_2)
	end
end

function var_0_0.onReceiveAct166TalentPush(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 == 0 then
		Season166Model.instance:onReceiveAct166TalentPush(arg_14_2)
		Season166Controller.instance:showToast(Season166Enum.ToastType.Talent)
	end
end

function var_0_0.sendAct166EnterBaseRequest(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = Activity166Module_pb.Act166EnterBaseRequest()

	var_15_0.activityId = arg_15_1
	var_15_0.baseId = arg_15_2

	arg_15_0:sendMsg(var_15_0)
end

function var_0_0.onReceiveAct166EnterBaseReply(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 == 0 then
		Season166Model.instance:onReceiveAct166EnterBaseReply(arg_16_2)
	end
end

function var_0_0.onReceiveAct166BattleFinishPush(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 == 0 then
		Season166Model.instance:onReceiveBattleFinishPush(arg_17_2)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
