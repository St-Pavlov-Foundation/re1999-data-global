module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractDeductHpEnemy", package.seeall)

slot0 = class("Va3ChessInteractDeductHpEnemy", Va3ChessInteractBase)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._enableAlarm = true
end

function slot0.onDrawAlert(slot0, slot1)
	if not slot0._enableAlarm then
		return
	end

	slot2 = slot0._target.originData.posX
	slot3 = slot0._target.originData.posY

	if slot0._target.originData.data and slot0._target.originData.data.alertArea and #slot0._target.originData.data.alertArea == 1 then
		slot0:faceTo(Va3ChessMapUtils.ToDirection(slot0._target.originData.posX, slot0._target.originData.posY, slot4[1].x, slot4[1].y))
	end
end

function slot0.playDeleteObjView(slot0)
	AudioMgr.instance:trigger(AudioEnum.Role2ChessGame1_3.DeductHp)
end

function slot0.moveTo(slot0, slot1, slot2, slot3, slot4)
	slot0._enableAlarm = false

	uv0.super.moveTo(slot0, slot1, slot2, slot3, slot4)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
end

function slot0.onMoveCompleted(slot0)
	uv0.super.onMoveCompleted(slot0)

	slot0._enableAlarm = true

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
end

function slot0.onAvatarLoaded(slot0)
	uv0.super.onAvatarLoaded(slot0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
end

function slot0.dispose(slot0)
	slot0._enableAlarm = false

	uv0.super.dispose(slot0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
end

return slot0
