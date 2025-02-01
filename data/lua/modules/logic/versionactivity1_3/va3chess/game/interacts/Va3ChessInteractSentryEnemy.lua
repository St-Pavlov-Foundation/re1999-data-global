module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractSentryEnemy", package.seeall)

slot0 = class("Va3ChessInteractSentryEnemy", Va3ChessInteractBase)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._enableAlarm = true
end

function slot0.onDrawAlert(slot0, slot1)
	if not slot0._enableAlarm then
		return
	end

	slot2 = nil

	if slot0._target and slot0._target.originData and slot0._target.originData.data then
		slot2 = slot0._target.originData.data.alertArea
	end

	if slot2 and Va3ChessGameModel.instance:isPosInChessBoard(slot2[1].x, slot2[1].y) and Va3ChessGameModel.instance:getBaseTile(slot3, slot4) ~= Va3ChessEnum.TileBaseType.None then
		slot1[slot3] = slot1[slot3] or {}
		slot1[slot3][slot4] = slot1[slot3][slot4] or {}

		table.insert(slot1[slot3][slot4], true)
	end

	slot3 = slot0._target.originData.posX
	slot4 = slot0._target.originData.posY

	if Activity142Helper.isCanFireKill(slot0._target) then
		slot1[slot3] = slot1[slot3] or {}
		slot1[slot3][slot4] = slot1[slot3][slot4] or {}

		table.insert(slot1[slot3][slot4], {
			showOrangeStyle = slot5
		})
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

	if slot0._target.avatar and slot0._target.avatar.loader and not gohelper.isNil(slot0._target.avatar.loader:getInstGO()) then
		slot0._animSelf = slot1:GetComponent(typeof(UnityEngine.Animator))

		if slot0._animSelf then
			slot0._animSelf:Play("open", 0, 0)
		end
	end
end

function slot0.dispose(slot0)
	slot0._enableAlarm = false

	uv0.super.dispose(slot0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
end

return slot0
