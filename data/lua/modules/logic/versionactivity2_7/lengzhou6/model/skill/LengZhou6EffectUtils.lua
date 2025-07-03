module("modules.logic.versionactivity2_7.lengzhou6.model.skill.LengZhou6EffectUtils", package.seeall)

local var_0_0 = class("LengZhou6EffectUtils")

function var_0_0.ctor(arg_1_0)
	arg_1_0._defineList = {
		[LengZhou6Enum.SkillEffect.DamageUpByIntensified] = var_0_0._damageUpByIntensified,
		[LengZhou6Enum.SkillEffect.HealUpByIntensified] = var_0_0._healUpByIntensified,
		[LengZhou6Enum.SkillEffect.EliminationDecreaseCd] = var_0_0._eliminationDecreaseCd,
		[LengZhou6Enum.SkillEffect.AddBuffByIntensified] = var_0_0._addBuffByIntensified,
		[LengZhou6Enum.SkillEffect.DamageUpByType] = var_0_0._damageUpByType,
		[LengZhou6Enum.SkillEffect.SuccessiveElimination] = var_0_0._successiveElimination,
		[LengZhou6Enum.SkillEffect.EliminationLevelUp] = var_0_0._eliminationLevelUp,
		[LengZhou6Enum.SkillEffect.EliminationCross] = var_0_0._eliminationCross,
		[LengZhou6Enum.SkillEffect.EliminationDoubleAttack] = var_0_0._eliminationDoubleAttack,
		[LengZhou6Enum.SkillEffect.EliminationRange] = var_0_0._eliminationRange,
		[LengZhou6Enum.SkillEffect.AddBuff] = var_0_0._addBuff,
		[LengZhou6Enum.SkillEffect.DealsDamage] = var_0_0._dealsDamage,
		[LengZhou6Enum.SkillEffect.Contaminate] = var_0_0._contaminate,
		[LengZhou6Enum.SkillEffect.Shuffle] = var_0_0._shuffle,
		[LengZhou6Enum.SkillEffect.FreezeEliminationBlock] = var_0_0._freezeEliminationBlock,
		[LengZhou6Enum.SkillEffect.PetrifyEliminationBlock] = var_0_0._petrifyEliminationBlock,
		[LengZhou6Enum.SkillEffect.Heal] = var_0_0._heal
	}
end

function var_0_0._damageUpByIntensified(arg_2_0)
	local var_2_0 = LengZhou6GameModel.instance:getPlayer()

	if var_2_0 ~= nil then
		var_2_0:getDamageComp():setEliminateTypeExDamage(arg_2_0[2], tonumber(arg_2_0[3]))
	end
end

function var_0_0._healUpByIntensified(arg_3_0)
	local var_3_0 = LengZhou6GameModel.instance:getPlayer()

	if var_3_0 ~= nil then
		var_3_0:getTreatmentComp():setEliminateTypeExTreatment(arg_3_0[2], tonumber(arg_3_0[3]))
	end
end

function var_0_0._eliminationDecreaseCd(arg_4_0)
	local var_4_0 = LengZhou6GameModel.instance:getPlayer()

	if var_4_0 ~= nil then
		local var_4_1 = LengZhou6GameModel.instance:getCurEliminateSpEliminateCount(arg_4_0[2]) or 0
		local var_4_2 = var_4_0:getActiveSkills()
		local var_4_3
		local var_4_4 = 0

		for iter_4_0 = 1, #var_4_2 do
			local var_4_5 = var_4_2[iter_4_0]
			local var_4_6 = var_4_5:getCd()

			if var_4_4 < var_4_6 then
				var_4_3 = var_4_5
				var_4_4 = var_4_6
			end
		end

		if var_4_3 ~= nil then
			for iter_4_1 = 1, var_4_1 do
				var_4_3:setCd(var_4_3:getCd() - tonumber(arg_4_0[3]))
			end
		end
	end
end

function var_0_0._addBuffByIntensified(arg_5_0)
	local var_5_0 = arg_5_0[2]
	local var_5_1 = LengZhou6GameModel.instance:getCurEliminateSpEliminateCount(var_5_0) or 0
	local var_5_2 = tonumber(arg_5_0[3])
	local var_5_3 = tonumber(arg_5_0[4])
	local var_5_4 = tonumber(arg_5_0[5])

	for iter_5_0 = 1, var_5_1 do
		for iter_5_1 = 1, var_5_3 do
			if var_5_4 == LengZhou6Enum.entityCamp.player then
				LengZhou6BuffSystem.instance:addBuffToPlayer(var_5_2)
			end

			if var_5_4 == LengZhou6Enum.entityCamp.enemy then
				LengZhou6BuffSystem.instance:addBuffToEnemy(var_5_2)
			end
		end
	end
end

function var_0_0._damageUpByType(arg_6_0)
	local var_6_0 = LengZhou6GameModel.instance:getPlayer()

	if var_6_0 ~= nil then
		local var_6_1 = var_6_0:getDamageComp()
		local var_6_2 = string.splitToNumber(arg_6_0[3], ",")

		var_6_1:setSpEliminateRate(var_6_2[1], var_6_2[2], var_6_2[3])
	end
end

function var_0_0._successiveElimination(arg_7_0)
	local var_7_0 = tonumber(arg_7_0[2]) / 1000

	LengZhou6GameModel.instance:setLineEliminateRate(var_7_0)
end

function var_0_0._eliminationLevelUp(arg_8_0)
	local var_8_0 = arg_8_0[2]
	local var_8_1 = tonumber(arg_8_0[3])
	local var_8_2 = EliminateEnum_2_7.ChessTypeToIndex[var_8_0]
	local var_8_3 = LocalEliminateChessModel.instance:getAllEliminateIdPos(var_8_2)
	local var_8_4 = {}
	local var_8_5 = {}

	if var_8_1 < #var_8_3 then
		for iter_8_0 = 1, var_8_1 do
			local var_8_6 = math.random(1, #var_8_3)

			table.insert(var_8_4, var_8_3[var_8_6].x)
			table.insert(var_8_5, var_8_3[var_8_6].y)
		end
	else
		for iter_8_1 = 1, #var_8_3 do
			table.insert(var_8_4, var_8_3[iter_8_1].x)
			table.insert(var_8_5, var_8_3[iter_8_1].y)
		end
	end

	local var_8_7 = FlowParallel.New()

	for iter_8_2 = 1, #var_8_4 do
		local var_8_8 = var_8_4[iter_8_2]
		local var_8_9 = var_8_5[iter_8_2]

		LocalEliminateChessModel.instance:changeCellState(var_8_8, var_8_9, EliminateEnum.ChessState.SpecialSkill)

		local var_8_10 = {
			x = var_8_8,
			y = var_8_9
		}
		local var_8_11 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.ChangeState, var_8_10)

		var_8_7:addWork(var_8_11)
	end

	LengZhou6EliminateController.instance:buildSeqFlow(var_8_7)
end

function var_0_0._eliminationCross(arg_9_0, arg_9_1)
	LocalEliminateChessModel.instance:eliminateCross(arg_9_0, arg_9_1)

	local var_9_0 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.CheckEliminate, false)

	LengZhou6EliminateController.instance:buildSeqFlow(var_9_0)
end

function var_0_0._eliminationDoubleAttack()
	LengZhou6GameModel.instance:setEnemySettleCount(2)
end

function var_0_0._eliminationRange(arg_11_0, arg_11_1)
	LocalEliminateChessModel.instance:eliminateRange(arg_11_0, arg_11_1, 3)

	local var_11_0 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.CheckEliminate, false)

	LengZhou6EliminateController.instance:buildSeqFlow(var_11_0)
end

function var_0_0._addBuff(arg_12_0)
	local var_12_0 = tonumber(arg_12_0[2])
	local var_12_1 = tonumber(arg_12_0[3])

	for iter_12_0 = 1, var_12_1 do
		LengZhou6BuffSystem.instance:addBuffToEnemy(var_12_0)
	end
end

function var_0_0._dealsDamage(arg_13_0, arg_13_1)
	local var_13_0 = tonumber(arg_13_0[2]) + (arg_13_1 ~= nil and arg_13_1 or 0)

	LengZhou6GameModel.instance:getPlayer():changeHp(-var_13_0)
end

function var_0_0._contaminate(arg_14_0, arg_14_1)
	local var_14_0 = tonumber(arg_14_0[2]) + (arg_14_1 ~= nil and arg_14_1 or 0)
	local var_14_1, var_14_2 = LocalEliminateChessModel.instance:getCellRowAndCol()
	local var_14_3 = var_0_0.getRandomXYSet(var_14_1, var_14_2, var_14_0, true, LengZhou6Enum.SkillEffect.Contaminate)

	for iter_14_0 = 1, #var_14_3 do
		local var_14_4 = var_14_3[iter_14_0].x
		local var_14_5 = var_14_3[iter_14_0].y

		LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.ShowEffect, var_14_4, var_14_5, EliminateEnum_2_7.ChessEffect.pollution)
	end
end

function var_0_0._shuffle()
	local var_15_0 = LocalEliminateChessModel.instance:randomCell()

	LengZhou6EliminateController.instance:updateAllItemPos(var_15_0)
end

function var_0_0._freezeEliminationBlock(arg_16_0, arg_16_1)
	local var_16_0 = tonumber(arg_16_0[2]) + (arg_16_1 ~= nil and arg_16_1 or 0)
	local var_16_1, var_16_2 = LocalEliminateChessModel.instance:getCellRowAndCol()
	local var_16_3 = FlowParallel.New()
	local var_16_4 = var_0_0.getRandomXYSet(var_16_1, var_16_2, var_16_0, true, LengZhou6Enum.SkillEffect.FreezeEliminationBlock)

	for iter_16_0 = 1, #var_16_4 do
		local var_16_5 = var_16_4[iter_16_0].x
		local var_16_6 = var_16_4[iter_16_0].y

		LocalEliminateChessModel.instance:changeCellState(var_16_5, var_16_6, EliminateEnum.ChessState.Frost)

		local var_16_7 = {
			x = var_16_5,
			y = var_16_6
		}
		local var_16_8 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.ChangeState, var_16_7)

		var_16_3:addWork(var_16_8)
	end

	LengZhou6EliminateController.instance:buildSeqFlow(var_16_3)
	LengZhou6EliminateController.instance:setFlowEndState(true)
end

function var_0_0._petrifyEliminationBlock(arg_17_0, arg_17_1)
	local var_17_0 = tonumber(arg_17_0[2]) + (arg_17_1 ~= nil and arg_17_1 or 0)
	local var_17_1, var_17_2 = LocalEliminateChessModel.instance:getCellRowAndCol()
	local var_17_3, var_17_4 = LengZhou6Controller.instance:getFixChessPos()

	if var_17_3 then
		var_17_0 = var_17_0 - 1
	end

	local var_17_5 = var_0_0.getRandomXYSet(var_17_1, var_17_2, var_17_0, true, LengZhou6Enum.SkillEffect.PetrifyEliminationBlock)

	if var_17_3 and var_17_4 ~= nil then
		table.insert(var_17_5, {
			x = var_17_4.x,
			y = var_17_4.y
		})
	end

	local var_17_6 = FlowParallel.New()

	for iter_17_0 = 1, #var_17_5 do
		local var_17_7 = var_17_5[iter_17_0].x
		local var_17_8 = var_17_5[iter_17_0].y
		local var_17_9 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.ChessItemUpdateInfo, {
			x = var_17_7,
			y = var_17_8
		})

		var_17_6:addWork(var_17_9)
	end

	LengZhou6EliminateController.instance:buildSeqFlow(var_17_6)
	LengZhou6EliminateController.instance:setFlowEndState(true)
end

function var_0_0._heal(arg_18_0, arg_18_1)
	local var_18_0 = tonumber(arg_18_0[2]) + (arg_18_1 ~= nil and arg_18_1 or 0)

	LengZhou6GameModel.instance:getEnemy():changeHp(var_18_0)
end

function var_0_0.getRandomXYSet(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0 = {}

	for iter_19_0 = 1, 100 do
		if #var_19_0 == arg_19_2 then
			break
		end

		local var_19_1 = math.random(1, arg_19_0)
		local var_19_2 = math.random(1, arg_19_1)
		local var_19_3 = true

		if arg_19_3 then
			local var_19_4 = LocalEliminateChessModel.instance:getCell(var_19_1, var_19_2)
			local var_19_5 = LocalEliminateChessModel.instance:getSpEffect(var_19_1, var_19_2)

			if arg_19_4 == LengZhou6Enum.SkillEffect.Contaminate and var_19_5 ~= nil then
				var_19_3 = false
			end

			if arg_19_4 == LengZhou6Enum.SkillEffect.FreezeEliminationBlock and (var_19_5 ~= nil or var_19_4.id == EliminateEnum.InvalidId or var_19_4:getEliminateID() == EliminateEnum_2_7.ChessType.stone) then
				var_19_3 = false
			end

			if arg_19_4 == LengZhou6Enum.SkillEffect.PetrifyEliminationBlock and (var_19_5 ~= nil and var_19_5 == EliminateEnum_2_7.ChessEffect.frost or var_19_4.id == EliminateEnum.InvalidId) then
				var_19_3 = false
			end
		end

		if var_19_3 then
			for iter_19_1 = 1, #var_19_0 do
				local var_19_6 = var_19_0[iter_19_1].x
				local var_19_7 = var_19_0[iter_19_1].y

				if var_19_1 == var_19_6 and var_19_7 == var_19_2 then
					var_19_3 = false
				end
			end
		end

		if var_19_3 then
			table.insert(var_19_0, {
				x = var_19_1,
				y = var_19_2
			})
		end
	end

	return var_19_0
end

function var_0_0.getHandleFunc(arg_20_0, arg_20_1)
	return arg_20_0._defineList[arg_20_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
