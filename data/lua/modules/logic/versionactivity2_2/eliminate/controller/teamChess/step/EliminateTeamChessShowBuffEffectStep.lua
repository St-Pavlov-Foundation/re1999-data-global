module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.EliminateTeamChessShowBuffEffectStep", package.seeall)

slot0 = class("EliminateTeamChessShowBuffEffectStep", EliminateTeamChessStepBase)

function slot0.onStart(slot0)
	slot1 = slot0._data
	slot2 = slot1.vxEffectType
	slot4 = slot1.time

	if TeamChessUnitEntityMgr.instance:getEntity(slot1.uid) == nil then
		slot0:onDone(true)

		return
	end

	if string.nilorempty(EliminateTeamChessEnum.VxEffectTypeToPath[slot2]) then
		slot0:onDone(true)

		return
	end

	slot4 = slot4 or EliminateTeamChessEnum.VxEffectTypePlayTime[slot2]
	slot7, slot8, slot9 = slot5:getPosXYZ()

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.ShowChessEffect, slot2, slot7, slot8, slot9, slot4)

	if slot4 ~= nil then
		TaskDispatcher.runDelay(slot0._onDone, slot0, slot4)
	else
		slot0:onDone(true)
	end
end

return slot0
