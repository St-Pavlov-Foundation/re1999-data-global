module("modules.logic.versionactivity1_2.yaxian.rpc.Activity115Rpc", package.seeall)

slot0 = class("Activity115Rpc", BaseRpc)

function slot0.sendGetAct115InfoRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity115Module_pb.GetAct115InfoRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetAct115InfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		YaXianModel.instance:updateInfo(slot2)
	end
end

function slot0.sendAct115StartEpisodeRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity115Module_pb.Act115StartEpisodeRequest()
	slot5.activityId = slot1
	slot5.id = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct115StartEpisodeReply(slot0, slot1, slot2)
	if slot1 == 0 then
		YaXianGameController.instance:initMapByMapMsg(slot2.activityId, slot2.map)
	end
end

function slot0.sendAct115BeginRoundRequest(slot0, slot1, slot2, slot3, slot4)
	Activity115Module_pb.Act115BeginRoundRequest().activityId = slot1

	for slot9, slot10 in ipairs(slot2) do
		slot11 = slot5.operations:add()
		slot11.id = slot10.id
		slot11.moveDirection = slot10.dir
	end

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct115BeginRoundReply(slot0, slot1, slot2)
end

function slot0.onReceiveAct115StepPush(slot0, slot1, slot2)
	if slot1 == 0 and YaXianGameEnum.ActivityId == slot2.activityId and YaXianGameController.instance.stepMgr then
		slot3:insertStepList(slot2.steps)
	end
end

function slot0.sendAct115EventEndRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity115Module_pb.Act115EventEndRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAct115EventEndReply(slot0, slot1, slot2)
end

function slot0.sendAct115AbortRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity115Module_pb.Act115AbortRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAct115AbortReply(slot0)
end

function slot0.sendAct115BonusRequest(slot0, slot1)
	slot2 = Activity115Module_pb.Act115BonusRequest()
	slot2.activityId = slot1 or YaXianEnum.ActivityId

	slot0:sendMsg(slot2)
end

function slot0.onReceiveAct115BonusReply(slot0, slot1, slot2)
	if slot1 == 0 then
		YaXianModel.instance:updateGetBonusId(slot2.hasGetBonusIds)
	end
end

function slot0.sendAct115UseSkillRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity115Module_pb.Act115UseSkillRequest()
	slot5.activityId = slot1
	slot5.skillId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct115UseSkillReply(slot0, slot1, slot2)
	if slot1 == 0 then
		if YaXianGameModel.instance:updateSkillInfoAndCheckHasChange(cjson.decode(slot2.interactObject.data).skills) then
			YaXianGameController.instance:dispatchEvent(YaXianEvent.OnUpdateSkillInfo)
		end

		if YaXianGameModel.instance:updateEffectsAndCheckHasChange(slot3.effects) then
			YaXianGameController.instance:dispatchEvent(YaXianEvent.OnUpdateEffectInfo)
		end
	end
end

function slot0.sendAct115RevertRequest(slot0, slot1)
	slot2 = Activity115Module_pb.Act115RevertRequest()
	slot2.activityId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveAct115RevertReply(slot0, slot1, slot2)
	if slot1 == 0 then
		YaXianGameModel.instance:initServerDataByServerData(slot2.map)
		YaXianGameController.instance.state:setCurEvent(slot2.map.currentEvent)
		YaXianGameController.instance:stopRunningStep()
		YaXianGameController.instance:dispatchEvent(YaXianEvent.OnRevert)
	end
end

slot0.instance = slot0.New()

return slot0
