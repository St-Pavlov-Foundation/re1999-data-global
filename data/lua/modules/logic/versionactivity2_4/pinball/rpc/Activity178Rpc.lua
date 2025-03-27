module("modules.logic.versionactivity2_4.pinball.rpc.Activity178Rpc", package.seeall)

slot0 = class("Activity178Rpc", BaseRpc)

function slot0.sendGetAct178Info(slot0, slot1)
	slot2 = Activity178Module_pb.GetAct178InfoRequest()
	slot2.activityId = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveGetAct178InfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		PinballModel.instance:initData(slot2.info)
	end
end

function slot0.sendAct178StartEpisode(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity178Module_pb.Act178StartEpisodeRequest()
	slot5.activityId = slot1
	slot5.episodeId = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct178StartEpisodeReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.sendAct178EndEpisode(slot0, slot1, slot2, slot3)
	PinballStatHelper.instance:sendGameFinish()

	slot4 = Activity178Module_pb.Act178EndEpisodeRequest()
	slot4.activityId = slot1
	slot4.episodeId = slot3

	for slot8, slot9 in pairs(slot2) do
		slot10 = Activity178Module_pb.Act178CurrencyNO()
		slot10.type = slot8
		slot10.num = slot9

		table.insert(slot4.currencys, slot10)
	end

	return slot0:sendMsg(slot4)
end

function slot0.onReceiveAct178EndEpisodeReply(slot0, slot1, slot2)
	if slot1 == 0 then
		ViewMgr.instance:openView(ViewName.PinballResultView, slot2)

		PinballModel.instance.oper = PinballEnum.OperType.Episode

		PinballController.instance:dispatchEvent(PinballEvent.OperChange)
		PinballModel.instance:onCurrencyChange(slot2.currencys)
		PinballController.instance:dispatchEvent(PinballEvent.OnCurrencyChange)
	else
		ViewMgr.instance:closeView(ViewName.PinballGameView)
	end
end

function slot0.sendAct178EndRound(slot0, slot1)
	slot2 = Activity178Module_pb.Act178EndRoundRequest()
	slot2.activityId = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveAct178EndRoundReply(slot0, slot1, slot2)
	if slot1 == 0 then
		slot4, slot5 = PinballModel.instance:getResNum(PinballEnum.ResType.Score)

		PinballModel.instance:initData(slot2.info)
		ViewMgr.instance:openView(ViewName.PinballDayEndView, {
			day = PinballModel.instance.day,
			nextScore = slot5,
			preScore = slot4,
			preComplaint = PinballModel.instance:getResNum(PinballEnum.ResType.Complaint),
			preMaxProsperity = PinballModel.instance.maxProsperity,
			nextScore = PinballModel.instance:getResNum(PinballEnum.ResType.Score),
			nextComplaint = PinballModel.instance:getResNum(PinballEnum.ResType.Complaint),
			nextMaxProsperity = PinballModel.instance.maxProsperity
		})
	end
end

function slot0.sendAct178Rest(slot0, slot1)
	slot2 = Activity178Module_pb.Act178RestRequest()
	slot2.activityId = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveAct178RestReply(slot0, slot1, slot2)
	if slot1 == 0 then
		PinballModel.instance.oper = PinballEnum.OperType.Rest

		PinballController.instance:dispatchEvent(PinballEvent.OperChange)
		ViewMgr.instance:openView(ViewName.PinballRestLoadingView)
	end
end

function slot0.sendAct178Reset(slot0, slot1)
	slot2 = Activity178Module_pb.Act178ResetRequest()
	slot2.activityId = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveAct178ResetReply(slot0, slot1, slot2)
	if slot1 == 0 then
		GameFacade.showToast(ToastEnum.WeekwalkResetLayer)
		MessageBoxController.instance:clearOption(MessageBoxIdDefine.PinballRestConfirm, MsgBoxEnum.optionType.NotShow)
		PinballModel.instance:initData(slot2.info)
	end
end

function slot0.sendAct178UnlockTalent(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity178Module_pb.Act178UnlockTalentRequest()
	slot5.activityId = slot1
	slot5.talentId = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct178UnlockTalentReply(slot0, slot1, slot2)
	if slot1 == 0 then
		PinballModel.instance:unlockTalent(slot2.talentId)
		PinballController.instance:dispatchEvent(PinballEvent.LearnTalent)
	end
end

function slot0.sendAct178Build(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity178Module_pb.Act178BuildRequest()
	slot5.activityId = slot1
	slot5.configId = slot2
	slot5.oper = slot3
	slot5.index = slot4

	return slot0:sendMsg(slot5)
end

function slot0.onReceiveAct178BuildReply(slot0, slot1, slot2)
	if slot1 == 0 then
		if slot2.oper == PinballEnum.BuildingOperType.Build then
			PinballModel.instance:addBuilding(slot2.configId, slot2.index)
		elseif slot2.oper == PinballEnum.BuildingOperType.Upgrade then
			PinballModel.instance:upgradeBuilding(slot2.index)
		else
			PinballModel.instance:removeBuilding(slot2.index)
		end

		PinballController.instance:dispatchEvent(PinballEvent.OperBuilding)
	end
end

function slot0.sendAct178GetReward(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity178Module_pb.Act178GetRewardRequest()
	slot5.activityId = slot1
	slot5.buildingIndex = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct178GetRewardReply(slot0, slot1, slot2)
	if slot1 == 0 then
		if slot2.buildingIndex == 0 then
			for slot6, slot7 in pairs(PinballModel.instance._buildingInfo) do
				slot7.food = 0
			end
		elseif PinballModel.instance:getBuildingInfo(slot2.buildingIndex) then
			slot3.food = 0
		end

		AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio5)
		PinballController.instance:dispatchEvent(PinballEvent.GetReward, slot2.buildingIndex)
	end
end

function slot0.sendAct178Interact(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity178Module_pb.Act178InteractRequest()
	slot5.activityId = slot1
	slot5.buildingIndex = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct178InteractReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.sendAct178GuideAddGrain(slot0, slot1)
	slot2 = Activity178Module_pb.Act178GuideAddGrainRequest()
	slot2.activityId = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveAct178GuideAddGrainReply(slot0, slot1, slot2)
	if slot1 == 0 then
		PinballModel.instance.isGuideAddGrain = true
	end
end

function slot0.onReceiveAct178CurrencyChangePush(slot0, slot1, slot2)
	if slot1 == 0 then
		PinballModel.instance:onCurrencyChange(slot2.currencys)
		PinballController.instance:dispatchEvent(PinballEvent.OnCurrencyChange)
	end
end

slot0.instance = slot0.New()

return slot0
