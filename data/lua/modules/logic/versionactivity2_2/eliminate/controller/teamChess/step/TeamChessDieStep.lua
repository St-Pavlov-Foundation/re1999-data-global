module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.TeamChessDieStep", package.seeall)

slot0 = class("TeamChessDieStep", EliminateTeamChessStepBase)

function slot0.onStart(slot0)
	slot0:onDone(true)
end

return slot0
