module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.StrongHoldSettleStep", package.seeall)

slot0 = class("StrongHoldSettleStep", EliminateTeamChessStepBase)

function slot0.onStart(slot0)
	slot1 = slot0._data
	slot2 = slot1.strongholdId
	slot3 = slot1.state

	TeamChessUnitEntityMgr.instance:cacheEntityShowMode(slot2)
	EliminateTeamChessModel.instance:strongHoldSettle(slot2, slot3)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.StrongHoldSettle, slot2, slot3)

	slot4 = ""

	if EliminateTeamChessEnum.StrongHoldState.enemySide == slot3 then
		slot4 = tostring(EliminateTeamChessEnum.TeamChessTeamType.enemy)
	end

	if EliminateTeamChessEnum.StrongHoldState.mySide == slot3 then
		slot4 = tostring(EliminateTeamChessEnum.TeamChessTeamType.player)
	end

	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.SettleAndToHaveDamage, slot4)

	slot5 = EliminateTeamChessModel.instance:getStronghold(slot2)

	if slot5:getPlayerSoliderCount() > 0 or slot5:getEnemySoliderCount() > 0 then
		slot8 = 0 + EliminateTeamChessEnum.teamChessUpdateActiveMoveStepTime + EliminateTeamChessEnum.StrongHoldBattleVxTime
	end

	if slot5.enemyScore ~= slot5.myScore then
		slot8 = slot8 + math.max(EliminateTeamChessEnum.teamChessWinOpenTime, EliminateTeamChessEnum.teamChessUpdateActiveMoveStepTime)
	end

	if slot8 > 0 then
		TaskDispatcher.runDelay(slot0._onDone, slot0, slot8)
	else
		slot0:onDone(true)
	end
end

return slot0
