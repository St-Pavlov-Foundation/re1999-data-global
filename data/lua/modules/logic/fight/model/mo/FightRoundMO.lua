module("modules.logic.fight.model.mo.FightRoundMO", package.seeall)

local var_0_0 = pureTable("FightRoundMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0._aiUseCardMODict = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.fightStepMOs = FightHelper.buildInfoMOs(FightHelper.processRoundStep(arg_2_1.fightStep), FightStepMO)

	if arg_2_1:HasField("actPoint") then
		arg_2_0.actPoint = arg_2_1.actPoint
	end

	if arg_2_1:HasField("isFinish") then
		arg_2_0.isFinish = arg_2_1.isFinish
	end

	if arg_2_1:HasField("moveNum") then
		arg_2_0.moveNum = arg_2_1.moveNum
	end

	arg_2_0._exPointMODict = arg_2_0:_buildExPointDict(arg_2_1.exPointInfo, FightExPointInfoMO)
	arg_2_0._lastAIUseCardMODict = arg_2_0._aiUseCardMODict
	arg_2_0._lastAIUseCardMOList = arg_2_0._aiUseCardMOList
	arg_2_0._aiUseCardMODict, arg_2_0._aiUseCardMOList = arg_2_0:_buildAIUseCardInfo(arg_2_1.aiUseCards, FightCardInfoMO)

	if arg_2_1:HasField("power") then
		arg_2_0.power = arg_2_1.power
	end

	arg_2_0.beforeCards1 = FightHelper.buildInfoMOs(arg_2_1.beforeCards1, FightCardInfoMO)
	arg_2_0.teamACards1 = FightHelper.buildInfoMOs(arg_2_1.teamACards1, FightCardInfoMO)
	arg_2_0.beforeCards2 = FightHelper.buildInfoMOs(arg_2_1.beforeCards2, FightCardInfoMO)
	arg_2_0.teamACards2 = FightHelper.buildInfoMOs(arg_2_1.teamACards2, FightCardInfoMO)
	arg_2_0.nextRoundBeginStepMOs = FightHelper.buildInfoMOs(FightHelper.processRoundStep(arg_2_1.nextRoundBeginStep), FightStepMO)
	arg_2_0.lastChangeHeroUid = arg_2_1.lastChangeHeroUid

	arg_2_0:_calcMultiHpChange()
	arg_2_0:_removeSceneEntityEffect()
	arg_2_0:_markStepIndex()
end

function var_0_0.updateClothSkillRound(arg_3_0, arg_3_1)
	arg_3_0.fightStepMOs = FightHelper.buildInfoMOs(FightHelper.processRoundStep(arg_3_1.fightStep), FightStepMO)
	arg_3_0._exPointMODict = arg_3_0:_buildExPointDict(arg_3_1.exPointInfo, FightExPointInfoMO)

	if arg_3_1:HasField("actPoint") then
		arg_3_0.actPoint = arg_3_1.actPoint
	end

	if arg_3_1:HasField("isFinish") then
		arg_3_0.isFinish = arg_3_1.isFinish
	end

	if arg_3_1:HasField("moveNum") then
		arg_3_0.moveeNum = arg_3_1.moveNum
	end

	if arg_3_1:HasField("power") then
		arg_3_0.power = arg_3_1.power
	end

	arg_3_0.beforeCards1 = FightHelper.buildInfoMOs(arg_3_1.beforeCards1, FightCardInfoMO)
	arg_3_0.teamACards1 = FightHelper.buildInfoMOs(arg_3_1.teamACards1, FightCardInfoMO)
	arg_3_0.beforeCards2 = FightHelper.buildInfoMOs(arg_3_1.beforeCards2, FightCardInfoMO)
	arg_3_0.teamACards2 = FightHelper.buildInfoMOs(arg_3_1.teamACards2, FightCardInfoMO)

	arg_3_0:_markStepIndex()
end

function var_0_0._markStepIndex(arg_4_0)
	if arg_4_0.fightStepMOs then
		for iter_4_0, iter_4_1 in ipairs(arg_4_0.fightStepMOs) do
			iter_4_1.custom_stepIndex = iter_4_0
		end
	end
end

function var_0_0.clone(arg_5_0)
	local var_5_0 = var_0_0.New()

	var_5_0.fightStepMOs = arg_5_0.fightStepMOs
	var_5_0.actPoint = arg_5_0.actPoint
	var_5_0.isFinish = arg_5_0.isFinish
	var_5_0.moveNum = arg_5_0.moveNum
	var_5_0._exPointMODict = arg_5_0._exPointMODict
	var_5_0._aiUseCardMODict = arg_5_0._aiUseCardMODict
	var_5_0.power = arg_5_0.power
	var_5_0.beforeCards1 = arg_5_0.beforeCards1
	var_5_0.teamACards1 = arg_5_0.teamACards1
	var_5_0.beforeCards2 = arg_5_0.beforeCards2
	var_5_0.teamACards2 = arg_5_0.teamACards2
	var_5_0.nextRoundBeginStepMOs = arg_5_0.nextRoundBeginStepMOs

	return var_5_0
end

function var_0_0.onBeginRound(arg_6_0)
	return
end

function var_0_0._buildExPointDict(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		local var_7_1 = arg_7_2.New()

		var_7_1:init(iter_7_1)

		local var_7_2 = var_7_1.id or var_7_1.uid

		if var_7_2 then
			var_7_0[var_7_2] = var_7_1
		end
	end

	return var_7_0
end

function var_0_0._buildAIUseCardInfo(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {}
	local var_8_1 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		local var_8_2 = arg_8_2.New()

		var_8_2:init(iter_8_1)

		var_8_2.custom_enemyCardIndex = iter_8_0

		local var_8_3 = var_8_2.id or var_8_2.uid

		if var_8_3 then
			local var_8_4 = var_8_1[var_8_3]

			if not var_8_4 then
				var_8_4 = {}
				var_8_1[var_8_3] = var_8_4
			end

			table.insert(var_8_4, var_8_2)
			table.insert(var_8_0, var_8_2)
		end
	end

	return var_8_1, var_8_0
end

function var_0_0._calcMultiHpChange(arg_9_0)
	for iter_9_0 = #arg_9_0.fightStepMOs, 1, -1 do
		local var_9_0 = arg_9_0.fightStepMOs[iter_9_0]
		local var_9_1
		local var_9_2 = 1

		for iter_9_1, iter_9_2 in ipairs(var_9_0.actEffectMOs) do
			if iter_9_2.effectType == FightEnum.EffectType.MULTIHPCHANGE then
				var_9_1 = iter_9_2
				var_9_2 = iter_9_1

				break
			end
		end

		if var_9_1 then
			local var_9_3 = {}

			for iter_9_3 = #var_9_0.actEffectMOs, var_9_2 + 1, -1 do
				if var_9_0.actEffectMOs[iter_9_3].targetId == var_9_1.targetId then
					local var_9_4 = table.remove(var_9_0.actEffectMOs, iter_9_3)

					table.insert(var_9_3, 1, var_9_4)
				end
			end

			if #var_9_3 > 0 then
				local var_9_5 = FightStepMO.New()
				local var_9_6 = {
					actType = FightEnum.ActType.EFFECT,
					fromId = var_9_0.fromId,
					toId = var_9_0.toId,
					actId = var_9_0.actId,
					actEffect = {}
				}

				var_9_5:init(var_9_6)

				var_9_5.actEffectMOs = var_9_3
				var_9_5.stepUid = var_9_0.stepUid + 1

				local var_9_7 = iter_9_0 + 1

				table.insert(arg_9_0.fightStepMOs, var_9_7, var_9_5)

				for iter_9_4 = var_9_7 + 1, #arg_9_0.fightStepMOs do
					local var_9_8 = arg_9_0.fightStepMOs[iter_9_4]

					var_9_8.stepUid = var_9_8.stepUid + 1
				end
			end
		end
	end
end

local var_0_1 = {
	[FightEnum.EffectType.DAMAGE] = true,
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.BEATBACK] = true,
	[FightEnum.EffectType.DAMAGEEXTRA] = true,
	[FightEnum.EffectType.HEAL] = true,
	[FightEnum.EffectType.HEALCRIT] = true,
	[FightEnum.EffectType.BLOODLUST] = true
}

function var_0_0._removeSceneEntityEffect(arg_10_0)
	for iter_10_0 = #arg_10_0.fightStepMOs, 1, -1 do
		local var_10_0 = arg_10_0.fightStepMOs[iter_10_0]

		if var_10_0.actType == FightEnum.ActType.EFFECT then
			local var_10_1 = var_10_0.actEffectMOs

			for iter_10_1 = #var_10_1, 1, -1 do
				local var_10_2 = var_10_1[iter_10_1]

				if var_0_1[var_10_2.effectType] and (var_10_2.targetId == FightEntityScene.MySideId or var_10_2.targetId == FightEntityScene.EnemySideId) then
					table.remove(var_10_1, iter_10_1)
				end
			end
		end
	end
end

function var_0_0.getEntityAIUseCardMOs(arg_11_0, arg_11_1)
	return arg_11_0._aiUseCardMODict[arg_11_1] or {}
end

function var_0_0.getEnemyActPoint(arg_12_0)
	return arg_12_0._aiUseCardMOList and #arg_12_0._aiUseCardMOList
end

function var_0_0.getAIUseCardMOList(arg_13_0)
	return arg_13_0._aiUseCardMOList
end

function var_0_0.getEntityLastAIUseCard(arg_14_0, arg_14_1)
	if arg_14_0._lastAIUseCardMODict then
		return arg_14_0._lastAIUseCardMODict[arg_14_1]
	end

	return {}
end

function var_0_0.getAILastUseCard(arg_15_0)
	return arg_15_0._lastAIUseCardMOList
end

return var_0_0
