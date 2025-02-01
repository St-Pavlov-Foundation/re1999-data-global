module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractStandbyTrackEnemy", package.seeall)

slot0 = class("Va3ChessInteractStandbyTrackEnemy", Va3ChessInteractBase)
slot1 = {
	[Va3ChessEnum.DeleteReason.Arrow] = {
		anim = "die",
		audio = AudioEnum.chess_activity142.Die
	},
	[Va3ChessEnum.DeleteReason.FireBall] = {
		anim = "die",
		audio = AudioEnum.chess_activity142.Die
	},
	[Va3ChessEnum.DeleteReason.Change] = {
		anim = Activity142Enum.SWITCH_CLOSE_ANIM
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

function slot0.onDrawAlert(slot0, slot1)
	slot2 = slot0._target.originData.posX
	slot3 = slot0._target.originData.posY

	if Activity142Helper.isCanFireKill(slot0._target) then
		slot1[slot2] = slot1[slot2] or {}
		slot1[slot2][slot3] = slot1[slot2][slot3] or {}

		table.insert(slot1[slot2][slot3], {
			showOrangeStyle = slot4
		})
	end
end

function slot0.onAvatarLoaded(slot0)
	uv0.super.onAvatarLoaded(slot0)

	if slot0._target.avatar and slot0._target.avatar.loader and not gohelper.isNil(slot0._target.avatar.loader:getInstGO()) then
		slot0._animSelf = slot1:GetComponent(typeof(UnityEngine.Animator))

		if slot0._animSelf then
			slot0._animSelf:Play("open", 0, 0)
		end
	end
end

return slot0
