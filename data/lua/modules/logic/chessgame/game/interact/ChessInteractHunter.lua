module("modules.logic.chessgame.game.interact.ChessInteractHunter", package.seeall)

slot0 = class("ChessInteractHunter", ChessInteractBase)

function slot0.onSelectCall(slot0)
end

function slot0.onCancelSelect(slot0)
end

function slot0.onSelectPos(slot0, slot1, slot2)
end

function slot0.onAvatarLoaded(slot0)
	uv0.super.onAvatarLoaded(slot0)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.SetAlarmAreaVisible, {
		visible = true
	})
end

function slot0.onMoveBegin(slot0)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.SetAlarmAreaVisible, {
		visible = false
	})
end

function slot0.onDrawAlert(slot0, slot1)
	slot3 = slot0._target.mo.posY
	slot1[slot2] = slot1[slot0._target.mo.posX] or {}
	slot1[slot2][slot3] = slot1[slot2][slot3] or {}

	table.insert(slot1[slot2][slot3], false)
end

function slot0.refreshAlarmArea(slot0)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.SetAlarmAreaVisible, {
		visible = true
	})
end

function slot0.breakObstacle(slot0, slot1, slot2, slot3)
	slot4, slot5 = slot1.mo:getXY()

	slot0:onMoveBegin()

	function slot8()
		uv0:refreshAlarmArea()
		uv1:getHandler():playBreakAnim(uv2, uv3)
	end

	slot0:moveTo((slot0._target.mo.posX + slot4) / 2, (slot0._target.mo.posY + slot5) / 2, function ()
		uv0:moveTo(uv0._target.mo.posX, uv0._target.mo.posY, uv1, uv0)
	end, slot0)
end

function slot0.moveTo(slot0, slot1, slot2, slot3, slot4)
	uv0.super.moveTo(slot0, slot1, slot2, slot3, slot4)
end

function slot0.setAlertActive(slot0, slot1)
end

function slot0.dispose(slot0)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.SetAlarmAreaVisible, {
		visible = false
	})
	uv0.super.dispose(slot0)
end

return slot0
