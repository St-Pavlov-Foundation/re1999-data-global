module("modules.logic.activity.controller.chessmap.interacts.ActivityChessInteractTriggerFail", package.seeall)

slot0 = class("ActivityChessInteractTriggerFail", ActivityChessInteractBase)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._enableAlarm = true
end

function slot0.onDrawAlert(slot0, slot1)
	if not slot0._enableAlarm then
		return
	end

	uv0.insertToAlertMap(slot1, slot0._target.originData.posX, slot0._target.originData.posY)

	if slot0._target.originData.data and slot0._target.originData.data.alertArea and #slot0._target.originData.data.alertArea == 1 then
		slot0:faceTo(ActivityChessMapUtils.ToDirection(slot0._target.originData.posX, slot0._target.originData.posY, slot4[1].x, slot4[1].y))
	end
end

function slot0.insertToAlertMap(slot0, slot1, slot2)
	if ActivityChessGameModel.instance:isPosInChessBoard(slot1, slot2) and ActivityChessGameModel.instance:getBaseTile(slot1, slot2) ~= ActivityChessEnum.TileBaseType.None then
		slot0[slot1] = slot0[slot1] or {}
		slot0[slot1][slot2] = true
	end
end

function slot0.moveTo(slot0, slot1, slot2, slot3, slot4)
	slot0._enableAlarm = false
	slot0._moveTargetX = slot1
	slot0._moveTargetY = slot2

	uv0.super.moveTo(slot0, slot1, slot2, slot3, slot4)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.RefreshAlarmArea)
end

function slot0.onMoveCompleted(slot0)
	uv0.super.onMoveCompleted(slot0)

	slot0._enableAlarm = true

	if ActivityChessGameController.instance:searchInteractByPos(slot0._moveTargetX, slot0._moveTargetY, ActivityChessGameController.filterSelectable) > 0 then
		AudioMgr.instance:trigger(AudioEnum.ChessGame.SheriffCatch)
	end

	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.RefreshAlarmArea)
end

function slot0.onAvatarLoaded(slot0)
	uv0.super.onAvatarLoaded(slot0)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.RefreshAlarmArea)
end

function slot0.dispose(slot0)
	slot0._enableAlarm = false

	uv0.super.dispose(slot0)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.RefreshAlarmArea)
end

return slot0
