module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.EliminateTeamChessStepUtil", package.seeall)

slot0 = class("EliminateTeamChessStepUtil")

function slot0.createStep(slot0, slot1)
	slot2 = slot1

	if slot0 then
		slot2 = slot0.effectType
	end

	slot3 = nil
	slot4 = uv0.createStepData(slot2, slot0)

	if slot2 == EliminateTeamChessEnum.StepWorkType.placeChess or slot2 == EliminateTeamChessEnum.StepWorkType.callChess then
		slot3 = TeamChessPlaceStep.New()
	end

	if slot2 == EliminateTeamChessEnum.StepWorkType.chessPowerChange then
		slot3 = TeamChessPowerChangeStep.New()
	end

	if slot2 == EliminateTeamChessEnum.StepWorkType.resourceChange then
		slot3 = ResourceDataChangeStep.New()
	end

	if slot2 == EliminateTeamChessEnum.StepWorkType.strongHoldPowerChange then
		slot3 = StrongHoldPowerChangeStep.New()
	end

	if slot2 == EliminateTeamChessEnum.StepWorkType.mainCharacterHpChange then
		slot3 = MainCharacterHpChangeStep.New()
	end

	if slot2 == EliminateTeamChessEnum.StepWorkType.teamChessFightResult then
		slot3 = TeamChessFightResultStep.New()
	end

	if slot2 == EliminateTeamChessEnum.StepWorkType.teamChessServerDataDiff then
		slot3 = EliminateTeamChessSyncDataStep.New()
	end

	if slot2 == EliminateTeamChessEnum.StepWorkType.teamChessCheckRoundState then
		slot3 = TeamChessCheckRoundStateStep.New()
	end

	if slot2 == EliminateTeamChessEnum.StepWorkType.strongHoldSettleFinish then
		slot3 = TeamChessPerformReductionStep.New()
	end

	if slot2 == EliminateTeamChessEnum.StepWorkType.chessDie then
		slot3 = TeamChessDieStep.New()
	end

	if slot2 == EliminateTeamChessEnum.StepWorkType.removeChess then
		slot3 = TeamChessRemoveStep.New()
	end

	if slot2 == EliminateTeamChessEnum.StepWorkType.strongHoldSettle then
		slot3 = StrongHoldSettleStep.New()
	end

	if slot2 == EliminateTeamChessEnum.StepWorkType.mainCharacterPowerChange then
		slot3 = MainCharacterPowerChangeStep.New()
	end

	if slot2 == EliminateTeamChessEnum.StepWorkType.teamChessBeginViewShow then
		slot3 = EliminateTeamChessBeginStep.New()
	end

	if slot2 == EliminateTeamChessEnum.StepWorkType.chessActiveMove then
		slot3 = EliminateTeamChessUpdateActiveMoveStep.New()
	end

	if slot2 == EliminateTeamChessEnum.StepWorkType.teamChessShowVxEffect then
		slot3 = EliminateTeamChessShowBuffEffectStep.New()
	end

	if slot2 == EliminateTeamChessEnum.StepWorkType.chessGrowUpChange then
		slot3 = TeamChessGrowUpUpdateStep.New()
	end

	if slot2 == EliminateTeamChessEnum.StepWorkType.teamChessUpdateForecast then
		slot3 = TeamChessForecastUpdateStep.New()
	end

	slot3 = slot3 or EliminateTeamChessStepBase.New()

	slot3:initData(slot4)

	return slot3
end

function slot0.createStepData(slot0, slot1)
	if slot0 == EliminateTeamChessEnum.StepWorkType.placeChess or slot0 == EliminateTeamChessEnum.StepWorkType.callChess then
		if not string.nilorempty(slot1.extraData) then
			-- Nothing
		end
	end

	if slot0 == EliminateTeamChessEnum.StepWorkType.chessPowerChange then
		slot2.uid = slot1.targetId
		slot2.diffValue = slot1.effectNum
		slot2.needShowDamage = slot1.needShowDamage or false
		slot2.reasonId = slot1.reasonId
	end

	if slot0 == EliminateTeamChessEnum.StepWorkType.resourceChange then
		slot2.resourceIdMap = cjson.decode(slot1.extraData)
	end

	if slot0 == EliminateTeamChessEnum.StepWorkType.strongHoldPowerChange then
		slot2.strongholdId = tonumber(slot1.targetId)
		slot2.diffValue = slot1.effectNum
		slot2.teamType = tonumber(slot1.extraData)
	end

	if slot0 == EliminateTeamChessEnum.StepWorkType.mainCharacterHpChange then
		slot2.diffValue = slot1.effectNum
		slot2.teamType = tonumber(slot1.targetId)
	end

	if slot0 == EliminateTeamChessEnum.StepWorkType.chessDie then
		slot2.uid = slot1.targetId
	end

	if slot0 == EliminateTeamChessEnum.StepWorkType.removeChess then
		slot2.uid = slot1.targetId
		slot2.strongholdId = tonumber(slot1.effectNum)

		if not string.nilorempty(slot1.extraData) then
			slot2.targetStrongholdId = tonumber(slot1.extraData)
		end
	end

	if slot0 == EliminateTeamChessEnum.StepWorkType.strongHoldSettle then
		slot2.strongholdId = tonumber(slot1.targetId)
		slot2.state = tonumber(slot1.effectNum)
	end

	if slot0 == EliminateTeamChessEnum.StepWorkType.mainCharacterPowerChange then
		slot2.diffValue = tonumber(slot1.effectNum)
		slot2.teamType = tonumber(slot1.targetId)
	end

	if slot0 == EliminateTeamChessEnum.StepWorkType.teamChessBeginViewShow then
		slot2.time = EliminateTeamChessEnum.beginViewShowTime
	end

	if slot0 == EliminateTeamChessEnum.StepWorkType.chessActiveMove then
		slot2.uid = slot1.targetId
		slot2.displacementState = slot1.chessPiece.displacementState
	end

	if slot0 == EliminateTeamChessEnum.StepWorkType.teamChessShowVxEffect then
		slot2.uid = slot1.uid
		slot2.vxEffectType = slot1.vxEffectType
		slot2.time = slot1.time
	end

	if slot0 == EliminateTeamChessEnum.StepWorkType.chessGrowUpChange then
		slot2.uid = slot1.targetId
		slot2.upValue = slot1.effectNum
		slot2.skillId = tonumber(slot1.extraData)
	end

	return {
		strongholdId = slot1.effectNum,
		chessPiece = slot1.chessPiece,
		sourceStrongholdId = tonumber(slot1.extraData)
	}
end

return slot0
