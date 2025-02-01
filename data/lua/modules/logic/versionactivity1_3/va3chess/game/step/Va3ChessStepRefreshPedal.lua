module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepRefreshPedal", package.seeall)

slot0 = class("Va3ChessStepRefreshPedal", Va3ChessStepBase)

function slot0.start(slot0)
	if slot0.originData.id and slot1 > 0 and Va3ChessGameController.instance.interacts and slot3:get(slot1) and slot4.originData then
		slot4.originData:setPedalStatus(slot0.originData.pedalStatus)
	end

	slot0:finish()
end

return slot0
