module("modules.logic.seasonver.act166.rpc.Activity166Rpc", package.seeall)

slot0 = class("Activity166Rpc", BaseRpc)

function slot0.sendGet166InfosRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity166Module_pb.Get166InfosRequest()
	slot4.activityId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet166InfosReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Season166Model.instance:setActInfo(slot2)
end

function slot0.sendStartAct166BattleRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9, slot10, slot11, slot12, slot13)
	slot14 = Activity166Module_pb.StartAct166BattleRequest()
	slot14.activityId = slot1
	slot14.episodeType = slot2
	slot14.id = slot3
	slot14.talentId = slot4

	Season166HeroGroupUtils.buildFightGroupAssistHero(Season166HeroGroupModel.instance.heroGroupType, slot14.startDungeonRequest.fightGroup)
	DungeonRpc.instance:packStartDungeonRequest(slot14.startDungeonRequest, slot5, slot6, slot7, slot8, slot9, slot10, slot11)

	return slot0:sendMsg(slot14, slot12, slot13)
end

function slot0.onReceiveStartAct166BattleReply(slot0, slot1, slot2)
	if slot1 == 0 then
		slot3 = Season166Model.instance:getBattleContext()

		if slot3.actId == slot2.activityId and Season166HeroGroupModel.instance:getEpisodeConfigId(slot3.episodeId) == slot2.id and slot3.episodeType == slot2.episodeType and DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId) and DungeonModel.isBattleEpisode(slot5) then
			DungeonFightController.instance:onReceiveStartDungeonReply(slot1, slot2.startDungeonReply)
		end
	else
		Season166Controller.instance:dispatchEvent(Season166Event.StartFightFailed)
	end
end

function slot0.sendAct166AnalyInfoRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity166Module_pb.Act166AnalyInfoRequest()
	slot5.activityId = slot1
	slot5.infoId = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct166AnalyInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Season166Model.instance:onReceiveAnalyInfo(slot2)
		Season166Controller.instance:dispatchEvent(Season166Event.OnAnalyInfoSuccess, slot2)
	end
end

function slot0.sendAct166ReceiveInformationBonusRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity166Module_pb.Act166ReceiveInformationBonusRequest()
	slot4.activityId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAct166ReceiveInformationBonusReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Season166Model.instance:onReceiveInformationBonus(slot2)
		Season166Controller.instance:dispatchEvent(Season166Event.OnGetInformationBonus)
	end
end

function slot0.sendAct166ReceiveInfoBonusRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity166Module_pb.Act166ReceiveInfoBonusRequest()
	slot5.activityId = slot1
	slot5.infoId = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct166ReceiveInfoBonusReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Season166Model.instance:onReceiveInfoBonus(slot2)
		Season166Controller.instance:dispatchEvent(Season166Event.OnGetInfoBonus)
	end
end

function slot0.onReceiveAct166InfoPush(slot0, slot1, slot2)
	if slot1 == 0 then
		Season166Model.instance:onReceiveUpdateInfos(slot2)
		Season166Controller.instance:dispatchEvent(Season166Event.OnInformationUpdate)
	end
end

function slot0.SendAct166SetTalentSkillRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity166Module_pb.Act166SetTalentSkillRequest()
	slot4.activityId = slot1
	slot4.talentId = slot2

	for slot8, slot9 in ipairs(slot3) do
		table.insert(slot4.skillIds, slot9)
	end

	slot0:sendMsg(slot4)
end

function slot0.onReceiveAct166SetTalentSkillReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Season166Model.instance:onReceiveSetTalentSkill(slot2)
	end
end

function slot0.onReceiveAct166TalentPush(slot0, slot1, slot2)
	if slot1 == 0 then
		Season166Model.instance:onReceiveAct166TalentPush(slot2)
		Season166Controller.instance:showToast(Season166Enum.ToastType.Talent)
	end
end

function slot0.sendAct166EnterBaseRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity166Module_pb.Act166EnterBaseRequest()
	slot5.activityId = slot1
	slot5.baseId = slot2

	slot0:sendMsg(slot5)
end

function slot0.onReceiveAct166EnterBaseReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Season166Model.instance:onReceiveAct166EnterBaseReply(slot2)
	end
end

function slot0.onReceiveAct166BattleFinishPush(slot0, slot1, slot2)
	if slot1 == 0 then
		Season166Model.instance:onReceiveBattleFinishPush(slot2)
	end
end

slot0.instance = slot0.New()

return slot0
