module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.ResourceDataChangeStep", package.seeall)

slot0 = class("ResourceDataChangeStep", EliminateTeamChessStepBase)

function slot0.onStart(slot0)
	if slot0._data.resourceIdMap == nil then
		slot0:onDone(true)

		return
	end

	for slot6, slot7 in pairs(slot2) do
		EliminateTeamChessModel.instance:updateResourceData(slot6, slot7)
	end

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.ResourceDataChange, slot2)
	slot0:onDone(true)
end

return slot0
