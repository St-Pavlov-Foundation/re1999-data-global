module("modules.logic.fight.model.data.FightRoundData", package.seeall)

local var_0_0 = FightDataClass("FightRoundData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	if not arg_1_1 then
		return
	end

	arg_1_0.fightStep = arg_1_0:buildFightStep(arg_1_1.fightStep)

	if arg_1_1:HasField("actPoint") then
		arg_1_0.actPoint = arg_1_1.actPoint
	end

	arg_1_0.isFinish = arg_1_1.isFinish

	if arg_1_1:HasField("moveNum") then
		arg_1_0.moveNum = arg_1_1.moveNum
	end

	arg_1_0.exPointInfo = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.exPointInfo) do
		table.insert(arg_1_0.exPointInfo, FightExPointInfoData.New(iter_1_1))
	end

	arg_1_0.aiUseCards = {}
	arg_1_0.entityAiUseCards = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.aiUseCards) do
		local var_1_0 = iter_1_3.uid
		local var_1_1 = FightCardInfoData.New(iter_1_3)

		var_1_1.clientData.custom_enemyCardIndex = iter_1_2
		arg_1_0.entityAiUseCards[var_1_0] = arg_1_0.entityAiUseCards[var_1_0] or {}

		table.insert(arg_1_0.entityAiUseCards[var_1_0], var_1_1)
		table.insert(arg_1_0.aiUseCards, var_1_1)
	end

	arg_1_0.power = arg_1_1.power
	arg_1_0.skillInfos = {}

	for iter_1_4, iter_1_5 in ipairs(arg_1_1.skillInfos) do
		table.insert(arg_1_0.skillInfos, FightPlayerSkillInfoData.New(iter_1_5))
	end

	arg_1_0.beforeCards1 = {}

	for iter_1_6, iter_1_7 in ipairs(arg_1_1.beforeCards1) do
		table.insert(arg_1_0.beforeCards1, FightCardInfoData.New(iter_1_7))
	end

	arg_1_0.teamACards1 = {}

	for iter_1_8, iter_1_9 in ipairs(arg_1_1.teamACards1) do
		table.insert(arg_1_0.teamACards1, FightCardInfoData.New(iter_1_9))
	end

	arg_1_0.beforeCards2 = {}

	for iter_1_10, iter_1_11 in ipairs(arg_1_1.beforeCards2) do
		table.insert(arg_1_0.beforeCards2, FightCardInfoData.New(iter_1_11))
	end

	arg_1_0.teamACards2 = {}

	for iter_1_12, iter_1_13 in ipairs(arg_1_1.teamACards2) do
		table.insert(arg_1_0.teamACards2, FightCardInfoData.New(iter_1_13))
	end

	arg_1_0.nextRoundBeginStep = arg_1_0:buildFightStep(arg_1_1.nextRoundBeginStep)
	arg_1_0.useCardList = {}

	for iter_1_14, iter_1_15 in ipairs(arg_1_1.useCardList) do
		table.insert(arg_1_0.useCardList, iter_1_15)
	end

	arg_1_0.curRound = arg_1_1.curRound
	arg_1_0.heroSpAttributes = {}

	for iter_1_16, iter_1_17 in ipairs(arg_1_1.heroSpAttributes) do
		table.insert(arg_1_0.heroSpAttributes, FightHeroSpAttributeInfoData.New(iter_1_17))
	end

	arg_1_0.lastChangeHeroUid = arg_1_1.lastChangeHeroUid
end

function var_0_0.buildFightStep(arg_2_0, arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_1 = FightStepData.New(iter_2_1)

		table.insert(var_2_0, var_2_1)
	end

	return var_2_0
end

function var_0_0.processRoundData(arg_3_0)
	arg_3_0.fightStep = arg_3_0:processStepList(arg_3_0.fightStep)
	arg_3_0.nextRoundBeginStep = arg_3_0:processStepList(arg_3_0.nextRoundBeginStep)
end

function var_0_0.processStepList(arg_4_0, arg_4_1)
	arg_4_0.stepIndex = 0
	arg_4_0.stepList = {}
	arg_4_0.effectSplitIndex = 0
	arg_4_0.effectStepDeep = 0

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		arg_4_0:addStep(iter_4_1)
	end

	return arg_4_0.stepList
end

function var_0_0.addStep(arg_5_0, arg_5_1)
	arg_5_0.stepIndex = arg_5_0.stepIndex + 1
	arg_5_1.custom_stepIndex = arg_5_0.stepIndex

	table.insert(arg_5_0.stepList, arg_5_1)
	arg_5_0:detectStepEffect(arg_5_1.actEffect)
end

function var_0_0.detectStepEffect(arg_6_0, arg_6_1)
	local var_6_0 = 1

	while arg_6_1[var_6_0] do
		local var_6_1 = arg_6_1[var_6_0]

		arg_6_0:processNuoDiKaUniqueDamage(arg_6_1, var_6_0, var_6_1)

		if var_6_1.effectType == FightEnum.EffectType.SPLITSTART then
			arg_6_0.effectSplitIndex = arg_6_0.effectSplitIndex + 1
		elseif var_6_1.effectType == FightEnum.EffectType.SPLITEND then
			arg_6_0.effectSplitIndex = arg_6_0.effectSplitIndex - 1
		end

		if var_6_1.effectType == FightEnum.EffectType.FIGHTSTEP then
			if arg_6_0.effectSplitIndex > 0 then
				table.remove(arg_6_1, var_6_0)

				var_6_0 = var_6_0 - 1
				arg_6_0.effectStepDeep = arg_6_0.effectStepDeep + 1

				arg_6_0:addStep(var_6_1.fightStep)

				arg_6_0.effectStepDeep = arg_6_0.effectStepDeep - 1
			else
				local var_6_2 = var_6_1.fightStep

				if var_0_0.needAddRoundStep(var_6_2) then
					table.remove(arg_6_1, var_6_0)

					var_6_0 = var_6_0 - 1

					arg_6_0:addStep(var_6_2)
				else
					arg_6_0:detectStepEffect(var_6_2.actEffect)
				end
			end
		elseif arg_6_0.effectSplitIndex > 0 and arg_6_0.effectStepDeep == 0 then
			table.remove(arg_6_1, var_6_0)

			var_6_0 = var_6_0 - 1

			local var_6_3 = FightStepData.New()

			var_6_3.actType = FightEnum.ActType.EFFECT
			var_6_3.fromId = "0"
			var_6_3.toId = "0"
			var_6_3.actId = 0
			var_6_3.actEffect = {
				var_6_1
			}
			var_6_3.cardIndex = 0
			var_6_3.supportHeroId = 0
			var_6_3.fakeTimeline = false

			table.insert(arg_6_0.stepList, var_6_3)
		end

		var_6_0 = var_6_0 + 1
	end
end

function var_0_0.getEnemyActPoint(arg_7_0)
	return #arg_7_0.aiUseCards
end

function var_0_0.getAIUseCardMOList(arg_8_0)
	return arg_8_0.aiUseCards
end

function var_0_0.getEntityAIUseCardMOList(arg_9_0, arg_9_1)
	return arg_9_0.entityAiUseCards[arg_9_1] or {}
end

function var_0_0.needAddRoundStep(arg_10_0)
	if FightHelper.isTimelineStep(arg_10_0) then
		return true
	end

	if arg_10_0.actType == FightEnum.ActType.CHANGEHERO then
		return true
	elseif arg_10_0.actType == FightEnum.ActType.CHANGEWAVE then
		return true
	end

	if arg_10_0.fakeTimeline then
		return true
	end
end

function var_0_0.processNuoDiKaUniqueDamage(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if (arg_11_3.effectType == FightEnum.EffectType.NUODIKARANDOMATTACK or arg_11_3.effectType == FightEnum.EffectType.NUODIKATEAMATTACK) and not arg_11_3.custom_nuoDiKaDamageSign then
		local var_11_0 = arg_11_3.configEffect

		for iter_11_0 = #arg_11_1, arg_11_2, -1 do
			local var_11_1 = arg_11_1[iter_11_0]

			if var_11_1.effectType == FightEnum.EffectType.DAMAGE and var_11_1.configEffect == var_11_0 then
				var_11_1.custom_nuoDiKaDamageSign = true
			end

			if var_11_1.effectType == FightEnum.EffectType.SHIELD and var_11_1.configEffect == var_11_0 then
				var_11_1.custom_nuoDiKaDamageSign = true
			end
		end
	end
end

return var_0_0
