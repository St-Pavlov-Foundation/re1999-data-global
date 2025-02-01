module("modules.logic.chessgame.game.step.ChessStepBreakObstacle", package.seeall)

slot0 = class("ChessStepBreakObstacle", BaseWork)

function slot0.init(slot0, slot1)
	slot0.originData = slot1
end

function slot0.onStart(slot0)
	slot0:breakObstacle()
end

function slot0.breakObstacle(slot0)
	slot4 = ChessGameController.instance.interactsMgr:get(slot0.originData.obstacleId)

	if not ChessGameController.instance.interactsMgr:get(slot0.originData.hunterId) or not slot4 then
		slot0:onDone(true)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_1ChessGame.play_ui_wangshi_bad)
	slot2:getHandler():breakObstacle(slot4, slot0._onFlowDone, slot0)
end

function slot0._onFlowDone(slot0)
	if ChessGameModel.instance:getCatchObj() and slot1.mo.id == slot0.originData.obstacleId then
		ChessGameModel.instance:setCatchObj(nil)
	end

	ChessGameController.instance:deleteInteractObj(slot0.originData.obstacleId)
	slot0:onDone(true)
end

return slot0
