module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.EliminateTeamChessController", package.seeall)

slot0 = class("EliminateTeamChessController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.handleTeamFight(slot0, slot1)
	EliminateTeamChessModel.instance:handleCurTeamChessWarFightInfo(slot1)
end

function slot0.handleServerTeamFight(slot0, slot1)
	EliminateTeamChessModel.instance:handleServerTeamChessWarFightInfo(slot1)
end

function slot0.handleWarChessRoundEndReply(slot0, slot1)
	EliminateTeamChessModel.instance:setCurTeamRoundStepState(EliminateTeamChessEnum.TeamChessRoundType.settlement)
	uv0.instance:handleTeamFightTurn(slot1.turn, not slot1.isFinish)
	uv0.instance:handleServerTeamFight(slot1.fight)
	EliminateLevelModel.instance:setNeedChangeTeamToEliminate(not slot1.isFinish)
end

function slot0.handleTeamFightResult(slot0, slot1)
	EliminateTeamChessModel.instance:handleTeamFightResult(slot1)
	slot0:buildSeqFlow(EliminateTeamChessStepUtil.createStep(nil, EliminateTeamChessEnum.StepWorkType.teamChessFightResult))
end

function slot0.handleTeamFightTurn(slot0, slot1, slot2)
	EliminateTeamChessModel.instance:handleTeamFightTurn(slot1)
	slot0:buildFlowByTurn()
	slot0:buildSeqFlow(EliminateTeamChessStepUtil.createStep(nil, EliminateTeamChessEnum.StepWorkType.teamChessServerDataDiff))

	if slot2 then
		slot0:buildSeqFlow(EliminateTeamChessStepUtil.createStep(nil, EliminateTeamChessEnum.StepWorkType.teamChessCheckRoundState))
	end
end

function slot0.buildFlowByTurn(slot0)
	if EliminateTeamChessModel.instance:getTeamChessStepList() == nil or #slot1 == 0 then
		return
	end

	for slot6 = 1, #slot1 do
		for slot12, slot13 in ipairs(table.remove(slot1, 1):buildSteps()) do
			slot0:buildSeqFlow(slot13)
		end
	end
end

function slot0.buildSeqFlow(slot0, slot1)
	slot0._seqStepFlow = slot0._seqStepFlow or FlowSequence.New()

	slot0._seqStepFlow:addWork(slot1)

	if slot0._seqStepFlow == nil and slot0._canStart then
		slot0:startSeqStepFlow()
	end
end

function slot0.setStartStepFlow(slot0, slot1)
	slot0._canStart = slot1
end

function slot0.startSeqStepFlow(slot0)
	if slot0._seqStepFlow ~= nil and slot0._seqStepFlow.status ~= WorkStatus.Running and #slot0._seqStepFlow:getWorkList() > 0 then
		slot0:dispatchEvent(EliminateChessEvent.TeamChessOnFlowStart)
		slot0._seqStepFlow:registerDoneListener(slot0.seqFlowDone, slot0)
		slot0._seqStepFlow:start()
	end
end

function slot0.seqFlowDone(slot0, slot1)
	slot0:dispatchEvent(EliminateChessEvent.TeamChessOnFlowEnd, slot1)

	slot0._seqStepFlow = nil
end

function slot0.sendWarChessPiecePlaceRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = EliminateTeamChessEnum.ChessPlaceType.place

	if slot2 ~= nil then
		slot7 = EliminateTeamChessEnum.ChessPlaceType.activeMove
	end

	logNormal("sendWarChessPiecePlaceRequest", slot7, slot1, slot3, slot2, slot4)
	WarChessRpc.instance:sendWarChessPiecePlaceRequest(slot7, slot1, slot3, slot2, slot4, slot5, slot6)
end

function slot0.sendWarChessRoundEndRequest(slot0, slot1, slot2)
	WarChessRpc.instance:sendWarChessRoundEndRequest(slot1, slot2)
end

function slot0.createPlaceSkill(slot0, slot1, slot2, slot3)
	slot0._soliderPlaceSkill = EliminateTeamChessModel.instance:createPlaceMo(slot1, slot2, slot3)
end

function slot0.getPlaceSkill(slot0)
	return slot0._soliderPlaceSkill
end

function slot0.setShowSkillEntityState(slot0, slot1)
	if slot0._soliderPlaceSkill then
		if slot1 then
			TeamChessUnitEntityMgr.instance:setTempShowModeAndCacheByTeamType(slot0._soliderPlaceSkill:getNeedSelectSoliderType(), EliminateTeamChessEnum.ModeType.Outline)
		else
			TeamChessUnitEntityMgr.instance:restoreTempShowModeAndCacheByTeamType(slot2)
		end
	end
end

function slot0.checkAndReleasePlaceSkill(slot0)
	if slot0._soliderPlaceSkill then
		return slot0._soliderPlaceSkill:releaseSkill(slot0.clearTemp, slot0)
	end

	return false
end

function slot0.addTempChessAndPlace(slot0, slot1, slot2, slot3)
	slot5, slot6 = EliminateTeamChessModel.instance:getStronghold(slot3):addTempPiece(EliminateTeamChessEnum.TeamChessTeamType.player, slot1)

	slot0:dispatchEvent(EliminateChessEvent.AddStrongholdChess, slot5, slot3, slot6)
	slot0:setShowSkillEntityState(true)
end

function slot0.removeTempChessAndPlace(slot0, slot1)
	slot3 = EliminateTeamChessEnum.tempPieceUid

	EliminateTeamChessModel.instance:getStronghold(slot1):removeChess(slot3)
	slot0:dispatchEvent(EliminateChessEvent.RemoveStrongholdChess, slot1, slot3)
	slot0:setShowSkillEntityState(false)
end

function slot0.clearTemp(slot0)
	slot0:clearReleasePlaceSkill()
	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.TeamChessSelectEffectEnd)
end

function slot0.clearReleasePlaceSkill(slot0)
	if slot0._soliderPlaceSkill and slot0._soliderPlaceSkill:needClearTemp() then
		slot0:removeTempChessAndPlace(slot0._soliderPlaceSkill._strongholdId)
	end

	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.TeamChessSelectEffectEnd)

	slot0._soliderPlaceSkill = nil
end

function slot0.clear(slot0)
	slot0._canStart = false

	if slot0._seqStepFlow then
		slot0._seqStepFlow:onDestroyInternal()

		slot0._seqStepFlow = nil
	end

	slot0:clearReleasePlaceSkill()
	TeamChessUnitEntityMgr.instance:clear()
	EliminateTeamChessModel.instance:clear()
end

slot0.instance = slot0.New()

return slot0
