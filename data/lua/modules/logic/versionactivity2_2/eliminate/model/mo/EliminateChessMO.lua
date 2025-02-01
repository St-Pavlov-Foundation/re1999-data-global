module("modules.logic.versionactivity2_2.eliminate.model.mo.EliminateChessMO", package.seeall)

slot0 = class("EliminateChessMO")

function slot0.ctor(slot0)
	slot0.x = 1
	slot0.y = 1
	slot0.startX = 1
	slot0.startY = 1
	slot0.id = -1
	slot0._status = EliminateEnum.ChessState.Normal
	slot0._chessBoardType = EliminateEnum.ChessBoardType.Normal
end

function slot0.setXY(slot0, slot1, slot2)
	slot0.x = slot1
	slot0.y = slot2
end

function slot0.setStartXY(slot0, slot1, slot2)
	slot0.startX = slot1
	slot0.startY = slot2
end

function slot0.setChessId(slot0, slot1)
	slot0.id = slot1
end

function slot0.setStatus(slot0, slot1)
	slot0._status = slot1
end

function slot0.setChessBoardType(slot0, slot1)
	slot0._chessBoardType = slot1
end

function slot0.getChessBoardType(slot0)
	return slot0._chessBoardType
end

function slot0.getStatus(slot0)
	return slot0._status
end

function slot0.getMoveTime(slot0)
	return EliminateEnum.AniTime.Drop
end

function slot0.getInitMoveTime(slot0)
	return EliminateEnum.AniTime.InitDrop
end

function slot0.clear(slot0)
	slot0.x = 1
	slot0.y = 1
	slot0.startX = 1
	slot0.startY = 1
	slot0.id = -1
	slot0._status = EliminateEnum.ChessState.Normal
	slot0._chessBoardType = EliminateEnum.ChessBoardType.Normal
end

return slot0
