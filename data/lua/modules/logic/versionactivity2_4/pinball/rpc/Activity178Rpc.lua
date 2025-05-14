module("modules.logic.versionactivity2_4.pinball.rpc.Activity178Rpc", package.seeall)

local var_0_0 = class("Activity178Rpc", BaseRpc)

function var_0_0.sendGetAct178Info(arg_1_0, arg_1_1)
	local var_1_0 = Activity178Module_pb.GetAct178InfoRequest()

	var_1_0.activityId = arg_1_1

	return arg_1_0:sendMsg(var_1_0)
end

function var_0_0.onReceiveGetAct178InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		PinballModel.instance:initData(arg_2_2.info)
	end
end

function var_0_0.sendAct178StartEpisode(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity178Module_pb.Act178StartEpisodeRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.episodeId = arg_3_2

	return arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveAct178StartEpisodeReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendAct178EndEpisode(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	PinballStatHelper.instance:sendGameFinish()

	local var_5_0 = Activity178Module_pb.Act178EndEpisodeRequest()

	var_5_0.activityId = arg_5_1
	var_5_0.episodeId = arg_5_3

	for iter_5_0, iter_5_1 in pairs(arg_5_2) do
		local var_5_1 = Activity178Module_pb.Act178CurrencyNO()

		var_5_1.type = iter_5_0
		var_5_1.num = iter_5_1

		table.insert(var_5_0.currencys, var_5_1)
	end

	return arg_5_0:sendMsg(var_5_0)
end

function var_0_0.onReceiveAct178EndEpisodeReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		ViewMgr.instance:openView(ViewName.PinballResultView, arg_6_2)

		PinballModel.instance.oper = PinballEnum.OperType.Episode

		PinballController.instance:dispatchEvent(PinballEvent.OperChange)
		PinballModel.instance:onCurrencyChange(arg_6_2.currencys)
		PinballController.instance:dispatchEvent(PinballEvent.OnCurrencyChange)
	else
		ViewMgr.instance:closeView(ViewName.PinballGameView)
	end
end

function var_0_0.sendAct178EndRound(arg_7_0, arg_7_1)
	local var_7_0 = Activity178Module_pb.Act178EndRoundRequest()

	var_7_0.activityId = arg_7_1

	return arg_7_0:sendMsg(var_7_0)
end

function var_0_0.onReceiveAct178EndRoundReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == 0 then
		local var_8_0 = {
			day = PinballModel.instance.day
		}

		var_8_0.preScore, var_8_0.nextScore = PinballModel.instance:getResNum(PinballEnum.ResType.Score)
		var_8_0.preComplaint = PinballModel.instance:getResNum(PinballEnum.ResType.Complaint)
		var_8_0.preMaxProsperity = PinballModel.instance.maxProsperity

		PinballModel.instance:initData(arg_8_2.info)

		var_8_0.nextScore = PinballModel.instance:getResNum(PinballEnum.ResType.Score)
		var_8_0.nextComplaint = PinballModel.instance:getResNum(PinballEnum.ResType.Complaint)
		var_8_0.nextMaxProsperity = PinballModel.instance.maxProsperity

		ViewMgr.instance:openView(ViewName.PinballDayEndView, var_8_0)
	end
end

function var_0_0.sendAct178Rest(arg_9_0, arg_9_1)
	local var_9_0 = Activity178Module_pb.Act178RestRequest()

	var_9_0.activityId = arg_9_1

	return arg_9_0:sendMsg(var_9_0)
end

function var_0_0.onReceiveAct178RestReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == 0 then
		PinballModel.instance.oper = PinballEnum.OperType.Rest

		PinballController.instance:dispatchEvent(PinballEvent.OperChange)
		ViewMgr.instance:openView(ViewName.PinballRestLoadingView)
	end
end

function var_0_0.sendAct178Reset(arg_11_0, arg_11_1)
	local var_11_0 = Activity178Module_pb.Act178ResetRequest()

	var_11_0.activityId = arg_11_1

	return arg_11_0:sendMsg(var_11_0)
end

function var_0_0.onReceiveAct178ResetReply(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 == 0 then
		GameFacade.showToast(ToastEnum.WeekwalkResetLayer)
		MessageBoxController.instance:clearOption(MessageBoxIdDefine.PinballRestConfirm, MsgBoxEnum.optionType.NotShow)
		PinballModel.instance:initData(arg_12_2.info)
	end
end

function var_0_0.sendAct178UnlockTalent(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = Activity178Module_pb.Act178UnlockTalentRequest()

	var_13_0.activityId = arg_13_1
	var_13_0.talentId = arg_13_2

	return arg_13_0:sendMsg(var_13_0, arg_13_3, arg_13_4)
end

function var_0_0.onReceiveAct178UnlockTalentReply(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 == 0 then
		PinballModel.instance:unlockTalent(arg_14_2.talentId)
		PinballController.instance:dispatchEvent(PinballEvent.LearnTalent)
	end
end

function var_0_0.sendAct178Build(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = Activity178Module_pb.Act178BuildRequest()

	var_15_0.activityId = arg_15_1
	var_15_0.configId = arg_15_2
	var_15_0.oper = arg_15_3
	var_15_0.index = arg_15_4

	return arg_15_0:sendMsg(var_15_0)
end

function var_0_0.onReceiveAct178BuildReply(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 == 0 then
		if arg_16_2.oper == PinballEnum.BuildingOperType.Build then
			PinballModel.instance:addBuilding(arg_16_2.configId, arg_16_2.index)
		elseif arg_16_2.oper == PinballEnum.BuildingOperType.Upgrade then
			PinballModel.instance:upgradeBuilding(arg_16_2.index)
		else
			PinballModel.instance:removeBuilding(arg_16_2.index)
		end

		PinballController.instance:dispatchEvent(PinballEvent.OperBuilding)
	end
end

function var_0_0.sendAct178GetReward(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = Activity178Module_pb.Act178GetRewardRequest()

	var_17_0.activityId = arg_17_1
	var_17_0.buildingIndex = arg_17_2

	return arg_17_0:sendMsg(var_17_0, arg_17_3, arg_17_4)
end

function var_0_0.onReceiveAct178GetRewardReply(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 == 0 then
		if arg_18_2.buildingIndex == 0 then
			for iter_18_0, iter_18_1 in pairs(PinballModel.instance._buildingInfo) do
				iter_18_1.food = 0
			end
		else
			local var_18_0 = PinballModel.instance:getBuildingInfo(arg_18_2.buildingIndex)

			if var_18_0 then
				var_18_0.food = 0
			end
		end

		AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio5)
		PinballController.instance:dispatchEvent(PinballEvent.GetReward, arg_18_2.buildingIndex)
	end
end

function var_0_0.sendAct178Interact(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0 = Activity178Module_pb.Act178InteractRequest()

	var_19_0.activityId = arg_19_1
	var_19_0.buildingIndex = arg_19_2

	return arg_19_0:sendMsg(var_19_0, arg_19_3, arg_19_4)
end

function var_0_0.onReceiveAct178InteractReply(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendAct178GuideAddGrain(arg_21_0, arg_21_1)
	local var_21_0 = Activity178Module_pb.Act178GuideAddGrainRequest()

	var_21_0.activityId = arg_21_1

	return arg_21_0:sendMsg(var_21_0)
end

function var_0_0.onReceiveAct178GuideAddGrainReply(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_1 == 0 then
		PinballModel.instance.isGuideAddGrain = true
	end
end

function var_0_0.onReceiveAct178CurrencyChangePush(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1 == 0 then
		PinballModel.instance:onCurrencyChange(arg_23_2.currencys)
		PinballController.instance:dispatchEvent(PinballEvent.OnCurrencyChange)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
