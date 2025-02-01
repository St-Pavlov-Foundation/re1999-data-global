module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.TeamChessPowerChangeStep", package.seeall)

slot0 = class("TeamChessPowerChangeStep", EliminateTeamChessStepBase)

function slot0.onStart(slot0)
	slot1 = slot0._data
	slot2 = slot1.needShowDamage
	slot3 = slot1.reasonId

	if slot1.uid == nil or slot1.diffValue == nil then
		slot0:onDone(true)

		return
	end

	slot4 = EliminateTeamChessEnum.teamChessPowerChangeStepTime
	slot5 = EliminateTeamChessEnum.HpDamageType.Chess

	if slot3 ~= nil and EliminateTeamChessModel.instance.chessSkillIsGrowUp(tonumber(slot3)) then
		slot4 = EliminateTeamChessEnum.teamChessGrowUpToChangePowerStepTime
		slot5 = EliminateTeamChessEnum.HpDamageType.GrowUpToChess
	end

	EliminateTeamChessModel.instance:updateChessPower(slot1.uid, slot1.diffValue)

	if slot2 and TeamChessUnitEntityMgr.instance:getEntity(slot1.uid) ~= nil then
		slot7, slot8, slot9 = slot6:getTopPosXYZ()

		EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.PlayDamageEffect, slot1.diffValue, slot7, slot8 + 0.5, slot5)
	end

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessPowerChange, slot1.uid, slot1.diffValue)
	TaskDispatcher.runDelay(slot0._onDone, slot0, slot4)
end

return slot0
