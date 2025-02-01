module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.TeamChessRemoveStep", package.seeall)

slot0 = class("TeamChessRemoveStep", EliminateTeamChessStepBase)

function slot0.onStart(slot0)
	slot1 = slot0._data
	slot0.strongholdId = slot1.strongholdId
	slot0.uid = slot1.uid

	if slot1.targetStrongholdId ~= nil then
		slot3 = slot0:calMoveOtherChessTime(EliminateTeamChessEnum.soliderChessOutAniTime) + EliminateTeamChessEnum.chessShowMoveStateAniTime
		slot5 = EliminateTeamChessModel.instance:sourceStrongHoldInRight(slot0.strongholdId, slot2) and -1 or 1
		slot7, slot8, slot9 = TeamChessUnitEntityMgr.instance:getEntity(slot0.uid):getTopPosXYZ()

		EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.ShowChessEffect, EliminateTeamChessEnum.VxEffectType.Move, slot7, slot8, slot9, slot5, slot5, slot5)
		TaskDispatcher.runDelay(slot0._playRemoveChess, slot0, EliminateTeamChessEnum.chessShowMoveStateAniTime)
	else
		slot0:_playRemoveChess()
	end

	TaskDispatcher.runDelay(slot0._onDone, slot0, slot3)
end

function slot0.calMoveOtherChessTime(slot0, slot1)
	slot4 = false
	slot5 = 0
	slot6 = 0

	if EliminateTeamChessModel.instance:getStronghold(slot0.strongholdId):getChess(slot0.uid).teamType == EliminateTeamChessEnum.TeamChessTeamType.player then
		slot5 = slot2:getMySideIndexByUid(slot0.uid)
		slot6 = slot2:getPlayerSoliderCount()
	end

	if slot3.teamType == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		slot5 = slot2:getEnemySideIndexByUid(slot0.uid)
		slot6 = slot2:getEnemySoliderCount()
	end

	if slot6 > 1 and slot5 ~= slot6 then
		slot1 = slot1 + EliminateTeamChessEnum.teamChessPlaceStep
	end

	return slot1
end

function slot0._playRemoveChess(slot0)
	TaskDispatcher.cancelTask(slot0._playRemoveChess, slot0)

	slot1 = EliminateTeamChessModel.instance:getStronghold(slot0.strongholdId)

	EliminateTeamChessModel.instance:removeStrongholdChess(slot0.strongholdId, slot0.uid)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.RemoveStrongholdChess, slot0.strongholdId, slot0.uid, slot1:getMySideIndexByUid(slot0.uid), slot1:getChess(slot0.uid).teamType)
end

return slot0
