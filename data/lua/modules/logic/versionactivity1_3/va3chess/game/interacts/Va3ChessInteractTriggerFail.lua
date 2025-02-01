module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractTriggerFail", package.seeall)

slot0 = class("Va3ChessInteractTriggerFail", Va3ChessInteractBase)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._enableAlarm = false
	slot0._isAlertActive = true
end

function slot0.onDrawAlert(slot0, slot1)
	if not slot0._enableAlarm then
		return
	end

	if slot0._isAlertActive then
		slot0:insertToAlertMap(slot1, slot0._target.originData.posX, slot0._target.originData.posY)
	end

	if slot0._target.originData.data and slot0._target.originData.data.alertArea and #slot0._target.originData.data.alertArea == 1 then
		slot0:faceTo(Va3ChessMapUtils.ToDirection(slot0._target.originData.posX, slot0._target.originData.posY, slot4[1].x, slot4[1].y))
	end
end

function slot0.setAlertActive(slot0, slot1)
	slot0._isAlertActive = slot1
end

function slot0.insertToAlertMap(slot0, slot1, slot2, slot3)
	if Va3ChessGameModel.instance:isPosInChessBoard(slot2, slot3) and Va3ChessGameModel.instance:getBaseTile(slot2, slot3) ~= Va3ChessEnum.TileBaseType.None then
		slot1[slot2] = slot1[slot2] or {}
		slot1[slot2][slot3] = slot1[slot2][slot3] or {}

		table.insert(slot1[slot2][slot3], {
			showOrangeStyle = Activity142Helper.isCanFireKill(slot0._target)
		})
	end
end

function slot0.moveTo(slot0, slot1, slot2, slot3, slot4)
	slot0._enableAlarm = false
	slot0._moveTargetX = slot1
	slot0._moveTargetY = slot2

	uv0.super.moveTo(slot0, slot1, slot2, slot3, slot4)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
end

function slot0.onMoveCompleted(slot0)
	uv0.super.onMoveCompleted(slot0)

	slot0._enableAlarm = true

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
end

function slot0.onAvatarLoaded(slot0)
	slot0._enableAlarm = true

	uv0.super.onAvatarLoaded(slot0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)

	if not slot0._target.avatar or not slot0._target.avatar.loader then
		return
	end

	if gohelper.isNil(slot0._target.avatar.loader:getInstGO()) then
		return
	end

	slot0._animSelf = slot1:GetComponent(typeof(UnityEngine.Animator))

	if slot0._animSelf and Va3ChessGameModel.instance:getObjectDataById(slot0._target.id) and slot2:getHaveBornEff() then
		slot0._animSelf:Play(Va3ChessEnum.SWITCH_OPEN_ANIM, 0, 0)
		AudioMgr.instance:trigger(AudioEnum.chess_activity142.SwitchTrackEnemy)
		slot2:setHaveBornEff(false)
	end
end

slot1 = {
	[Va3ChessEnum.DeleteReason.Arrow] = {
		anim = "die",
		audio = AudioEnum.chess_activity142.Die
	},
	[Va3ChessEnum.DeleteReason.FireBall] = {
		anim = "die",
		audio = AudioEnum.chess_activity142.Die
	},
	[Va3ChessEnum.DeleteReason.MoveKill] = {
		anim = "die",
		audio = AudioEnum.chess_activity142.Die
	}
}

function slot0.playDeleteObjView(slot0, slot1)
	if slot0._animSelf then
		slot2 = uv0[slot1] or {}

		slot0._animSelf:Play(slot2.anim or "close", 0, 0)

		if slot2.audio then
			AudioMgr.instance:trigger(slot4)
		end
	end

	if slot0._target and slot0._target.chessEffectObj and slot0._target.chessEffectObj.isShowEffect then
		slot0._target.chessEffectObj:isShowEffect(false)
	end
end

function slot0.dispose(slot0)
	slot0._enableAlarm = false

	uv0.super.dispose(slot0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
end

return slot0
