module("modules.logic.chessgame.game.interact.ChessInteractObstacle", package.seeall)

slot0 = class("ChessInteractObstacle", ChessInteractBase)

function slot0.playBreakAnim(slot0, slot1, slot2)
	logNormal("on playBreakAnim....")

	if slot1 and slot2 then
		slot0:showDestoryAni(slot1, slot2)
	else
		slot0:showDestoryAni(slot0.destroy, slot0)
	end
end

function slot0.destroy(slot0)
	if slot0._target.mo:isInCurrentMap() then
		ChessGameController.instance:deleteInteractObj(slot0._target.mo.id)
	end
end

function slot0.withCatch(slot0)
	if slot0._target.chessEffectObj and slot0._target.chessEffectObj:getIsLoadEffect() then
		slot0._target.chessEffectObj:hideEffect()
	end
end

return slot0
