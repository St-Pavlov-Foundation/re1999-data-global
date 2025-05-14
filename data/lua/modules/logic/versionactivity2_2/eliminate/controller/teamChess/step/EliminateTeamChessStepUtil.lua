module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.EliminateTeamChessStepUtil", package.seeall)

local var_0_0 = class("EliminateTeamChessStepUtil")

function var_0_0.createStep(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1

	if arg_1_0 then
		var_1_0 = arg_1_0.effectType
	end

	local var_1_1
	local var_1_2 = var_0_0.createStepData(var_1_0, arg_1_0)

	if var_1_0 == EliminateTeamChessEnum.StepWorkType.placeChess or var_1_0 == EliminateTeamChessEnum.StepWorkType.callChess then
		var_1_1 = TeamChessPlaceStep.New()
	end

	if var_1_0 == EliminateTeamChessEnum.StepWorkType.chessPowerChange then
		var_1_1 = TeamChessPowerChangeStep.New()
	end

	if var_1_0 == EliminateTeamChessEnum.StepWorkType.resourceChange then
		var_1_1 = ResourceDataChangeStep.New()
	end

	if var_1_0 == EliminateTeamChessEnum.StepWorkType.strongHoldPowerChange then
		var_1_1 = StrongHoldPowerChangeStep.New()
	end

	if var_1_0 == EliminateTeamChessEnum.StepWorkType.mainCharacterHpChange then
		var_1_1 = MainCharacterHpChangeStep.New()
	end

	if var_1_0 == EliminateTeamChessEnum.StepWorkType.teamChessFightResult then
		var_1_1 = TeamChessFightResultStep.New()
	end

	if var_1_0 == EliminateTeamChessEnum.StepWorkType.teamChessServerDataDiff then
		var_1_1 = EliminateTeamChessSyncDataStep.New()
	end

	if var_1_0 == EliminateTeamChessEnum.StepWorkType.teamChessCheckRoundState then
		var_1_1 = TeamChessCheckRoundStateStep.New()
	end

	if var_1_0 == EliminateTeamChessEnum.StepWorkType.strongHoldSettleFinish then
		var_1_1 = TeamChessPerformReductionStep.New()
	end

	if var_1_0 == EliminateTeamChessEnum.StepWorkType.chessDie then
		var_1_1 = TeamChessDieStep.New()
	end

	if var_1_0 == EliminateTeamChessEnum.StepWorkType.removeChess then
		var_1_1 = TeamChessRemoveStep.New()
	end

	if var_1_0 == EliminateTeamChessEnum.StepWorkType.strongHoldSettle then
		var_1_1 = StrongHoldSettleStep.New()
	end

	if var_1_0 == EliminateTeamChessEnum.StepWorkType.mainCharacterPowerChange then
		var_1_1 = MainCharacterPowerChangeStep.New()
	end

	if var_1_0 == EliminateTeamChessEnum.StepWorkType.teamChessBeginViewShow then
		var_1_1 = EliminateTeamChessBeginStep.New()
	end

	if var_1_0 == EliminateTeamChessEnum.StepWorkType.chessActiveMove then
		var_1_1 = EliminateTeamChessUpdateActiveMoveStep.New()
	end

	if var_1_0 == EliminateTeamChessEnum.StepWorkType.teamChessShowVxEffect then
		var_1_1 = EliminateTeamChessShowBuffEffectStep.New()
	end

	if var_1_0 == EliminateTeamChessEnum.StepWorkType.chessGrowUpChange then
		var_1_1 = TeamChessGrowUpUpdateStep.New()
	end

	if var_1_0 == EliminateTeamChessEnum.StepWorkType.teamChessUpdateForecast then
		var_1_1 = TeamChessForecastUpdateStep.New()
	end

	var_1_1 = var_1_1 or EliminateTeamChessStepBase.New()

	var_1_1:initData(var_1_2)

	return var_1_1
end

function var_0_0.createStepData(arg_2_0, arg_2_1)
	local var_2_0 = {}

	if arg_2_0 == EliminateTeamChessEnum.StepWorkType.placeChess or arg_2_0 == EliminateTeamChessEnum.StepWorkType.callChess then
		var_2_0.strongholdId = arg_2_1.effectNum
		var_2_0.chessPiece = arg_2_1.chessPiece

		if not string.nilorempty(arg_2_1.extraData) then
			var_2_0.sourceStrongholdId = tonumber(arg_2_1.extraData)
		end
	end

	if arg_2_0 == EliminateTeamChessEnum.StepWorkType.chessPowerChange then
		var_2_0.uid = arg_2_1.targetId
		var_2_0.diffValue = arg_2_1.effectNum
		var_2_0.needShowDamage = arg_2_1.needShowDamage or false
		var_2_0.reasonId = arg_2_1.reasonId
	end

	if arg_2_0 == EliminateTeamChessEnum.StepWorkType.resourceChange then
		var_2_0.resourceIdMap = cjson.decode(arg_2_1.extraData)
	end

	if arg_2_0 == EliminateTeamChessEnum.StepWorkType.strongHoldPowerChange then
		var_2_0.strongholdId = tonumber(arg_2_1.targetId)
		var_2_0.diffValue = arg_2_1.effectNum
		var_2_0.teamType = tonumber(arg_2_1.extraData)
	end

	if arg_2_0 == EliminateTeamChessEnum.StepWorkType.mainCharacterHpChange then
		var_2_0.diffValue = arg_2_1.effectNum
		var_2_0.teamType = tonumber(arg_2_1.targetId)
	end

	if arg_2_0 == EliminateTeamChessEnum.StepWorkType.chessDie then
		var_2_0.uid = arg_2_1.targetId
	end

	if arg_2_0 == EliminateTeamChessEnum.StepWorkType.removeChess then
		var_2_0.uid = arg_2_1.targetId
		var_2_0.strongholdId = tonumber(arg_2_1.effectNum)

		if not string.nilorempty(arg_2_1.extraData) then
			var_2_0.targetStrongholdId = tonumber(arg_2_1.extraData)
		end
	end

	if arg_2_0 == EliminateTeamChessEnum.StepWorkType.strongHoldSettle then
		var_2_0.strongholdId = tonumber(arg_2_1.targetId)
		var_2_0.state = tonumber(arg_2_1.effectNum)
	end

	if arg_2_0 == EliminateTeamChessEnum.StepWorkType.mainCharacterPowerChange then
		var_2_0.diffValue = tonumber(arg_2_1.effectNum)
		var_2_0.teamType = tonumber(arg_2_1.targetId)
	end

	if arg_2_0 == EliminateTeamChessEnum.StepWorkType.teamChessBeginViewShow then
		var_2_0.time = EliminateTeamChessEnum.beginViewShowTime
	end

	if arg_2_0 == EliminateTeamChessEnum.StepWorkType.chessActiveMove then
		var_2_0.uid = arg_2_1.targetId
		var_2_0.displacementState = arg_2_1.chessPiece.displacementState
	end

	if arg_2_0 == EliminateTeamChessEnum.StepWorkType.teamChessShowVxEffect then
		var_2_0.uid = arg_2_1.uid
		var_2_0.vxEffectType = arg_2_1.vxEffectType
		var_2_0.time = arg_2_1.time
	end

	if arg_2_0 == EliminateTeamChessEnum.StepWorkType.chessGrowUpChange then
		var_2_0.uid = arg_2_1.targetId
		var_2_0.upValue = arg_2_1.effectNum
		var_2_0.skillId = tonumber(arg_2_1.extraData)
	end

	return var_2_0
end

return var_0_0
