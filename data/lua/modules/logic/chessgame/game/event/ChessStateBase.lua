module("modules.logic.chessgame.game.event.ChessStateBase", package.seeall)

slot0 = class("ChessStateBase")

function slot0.init(slot0, slot1, slot2)
	slot0._stateType = slot1
	slot0.originData = slot2
end

function slot0.start(slot0)
	slot0._stateType = nil
end

function slot0.onClickPos(slot0, slot1, slot2, slot3)
end

function slot0.getStateType(slot0)
	return slot0._stateType
end

function slot0.dispose(slot0)
end

return slot0
