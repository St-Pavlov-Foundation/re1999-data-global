module("modules.logic.versionactivity2_6.dicehero.rpc.DiceHeroRpc", package.seeall)

local var_0_0 = class("DiceHeroRpc", BaseRpc)

function var_0_0.sendDiceHeroGetInfo(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = DiceHeroModule_pb.DiceHeroGetInfoRequest()

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveDiceHeroGetInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		DiceHeroModel.instance:initInfo(arg_2_2.info)
	end
end

function var_0_0.sendDiceHeroEnterStory(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = DiceHeroModule_pb.DiceHeroEnterStoryRequest()

	var_3_0.levelId = arg_3_1
	var_3_0.chapter = arg_3_2

	return arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveDiceHeroEnterStoryReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		DiceHeroModel.instance:initInfo(arg_4_2.info)
	end
end

function var_0_0.sendDiceHeroGetReward(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = DiceHeroModule_pb.DiceHeroGetRewardRequest()

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		table.insert(var_5_0.index, iter_5_1)
	end

	var_5_0.chapter = arg_5_2

	return arg_5_0:sendMsg(var_5_0, arg_5_3, arg_5_4)
end

function var_0_0.onReceiveDiceHeroGetRewardReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		DiceHeroModel.instance:initInfo(arg_6_2.info)
	end
end

function var_0_0.sendDiceHeroEnterFight(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	DiceHeroModel.instance.lastEnterLevelId = arg_7_1

	local var_7_0 = DiceHeroModule_pb.DiceHeroEnterFightRequest()

	var_7_0.levelId = arg_7_1

	return arg_7_0:sendMsg(var_7_0, arg_7_2, arg_7_3)
end

function var_0_0.onReceiveDiceHeroEnterFightReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == 0 then
		DiceHeroFightModel.instance:setGameData(arg_8_2.fight)
	end
end

function var_0_0.sendDiceHeroResetDice(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = DiceHeroModule_pb.DiceHeroResetDiceRequest()

	for iter_9_0, iter_9_1 in pairs(arg_9_1) do
		table.insert(var_9_0.diceUids, iter_9_1)
	end

	return arg_9_0:sendMsg(var_9_0, arg_9_2, arg_9_3)
end

function var_0_0.onReceiveDiceHeroResetDiceReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == 0 then
		local var_10_0 = DiceHeroHelper.instance:buildFlow(arg_10_2.steps)

		DiceHeroController.instance:dispatchEvent(DiceHeroEvent.StepStart)
		DiceHeroHelper.instance:startFlow(var_10_0)
	end
end

function var_0_0.sendDiceHeroConfirmDice(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = DiceHeroModule_pb.DiceHeroConfirmDiceRequest()

	return arg_11_0:sendMsg(var_11_0, arg_11_1, arg_11_2)
end

function var_0_0.onReceiveDiceHeroConfirmDiceReply(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 == 0 then
		DiceHeroFightModel.instance:getGameData().confirmed = true

		DiceHeroController.instance:dispatchEvent(DiceHeroEvent.ConfirmDice)

		local var_12_0 = DiceHeroHelper.instance:buildFlow(arg_12_2.steps)

		DiceHeroController.instance:dispatchEvent(DiceHeroEvent.StepStart)
		DiceHeroHelper.instance:startFlow(var_12_0)
	end
end

function var_0_0.sendDiceHeroUseSkill(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6, arg_13_7)
	local var_13_0 = DiceHeroModule_pb.DiceHeroUseSkillRequest()

	var_13_0.type = arg_13_1
	var_13_0.skillId = arg_13_2
	var_13_0.toId = arg_13_3

	for iter_13_0, iter_13_1 in ipairs(arg_13_4) do
		table.insert(var_13_0.diceUids, iter_13_1)
	end

	var_13_0.pattern = arg_13_5

	return arg_13_0:sendMsg(var_13_0, arg_13_6, arg_13_7)
end

function var_0_0.onReceiveDiceHeroUseSkillReply(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 == 0 then
		local var_14_0 = DiceHeroFightModel.instance:getGameData()

		for iter_14_0, iter_14_1 in ipairs(arg_14_2.skillId) do
			DiceHeroStatHelper.instance:addUseCard(iter_14_1)

			local var_14_1 = var_14_0.skillCardsBySkillId[iter_14_1]

			if var_14_1 then
				var_14_1.curRoundUse = var_14_1.curRoundUse + 1
			end
		end

		for iter_14_2, iter_14_3 in ipairs(arg_14_2.diceUids) do
			local var_14_2 = DiceHeroHelper.instance:getDice(iter_14_3)

			if var_14_2 then
				var_14_2:markDeleted()
			end
		end

		local var_14_3 = DiceHeroHelper.instance:buildFlow(arg_14_2.steps)

		DiceHeroController.instance:dispatchEvent(DiceHeroEvent.StepStart)
		DiceHeroHelper.instance:startFlow(var_14_3)
	end
end

function var_0_0.sendDiceHeroEndRound(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = DiceHeroModule_pb.DiceHeroEndRoundRequest()

	return arg_15_0:sendMsg(var_15_0, arg_15_1, arg_15_2)
end

function var_0_0.onReceiveDiceHeroEndRoundReply(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 == 0 then
		DiceHeroController.instance:dispatchEvent(DiceHeroEvent.StepStart)

		local var_16_0 = DiceHeroHelper.instance:buildFlow(arg_16_2.steps)

		var_16_0:addWork(DiceHeroLastStepWork.New(arg_16_2.fight))

		if #arg_16_2.afterSteps > 0 then
			local var_16_1 = DiceHeroHelper.instance:buildFlow(arg_16_2.afterSteps)

			DiceHeroHelper.instance.afterFlow = var_16_1
		end

		DiceHeroHelper.instance:startFlow(var_16_0)
	end
end

function var_0_0.sendDiceGiveUp(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = DiceHeroModule_pb.DiceGiveUpRequest()

	var_17_0.chapter = arg_17_1

	return arg_17_0:sendMsg(var_17_0, arg_17_2, arg_17_3)
end

function var_0_0.onReceiveDiceGiveUpReply(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 == 0 then
		DiceHeroStatHelper.instance:sendReset()
		GameFacade.showToast(ToastEnum.DiceHeroDiceResetSuccess)
		DiceHeroModel.instance:initInfo(arg_18_2.info)
	end
end

function var_0_0.onReceiveDiceFightSettlePush(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_1 == 0 then
		local var_19_0 = false

		if arg_19_2.status == DiceHeroEnum.GameStatu.Win then
			local var_19_1 = DiceHeroModel.instance.lastEnterLevelId
			local var_19_2 = lua_dice_level.configDict[var_19_1]

			if var_19_2 then
				local var_19_3 = DiceHeroModel.instance:getGameInfo(var_19_2.chapter)

				if var_19_3.currLevel == var_19_1 and not var_19_3.allPass then
					var_19_0 = true
				end
			end
		end

		DiceHeroModel.instance:initInfo(arg_19_2.info)

		DiceHeroFightModel.instance.finishResult = arg_19_2.status
		DiceHeroFightModel.instance.isFirstWin = var_19_0
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
