module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractPedal", package.seeall)

slot0 = class("Va3ChessInteractPedal", Va3ChessInteractBase)
slot1 = 0
slot2 = 1
slot3 = {
	Down = "donw",
	Up = "up",
	DownIdle = "down_idle",
	UpIdle = "up_idle"
}

function slot0.refreshPedalStatus(slot0)
	if slot0._isPress == ((slot0._target.originData:getPedalStatusInDataField() or uv0) == uv1) then
		return
	end

	slot0._isPress = slot2

	if slot0._isPress then
		slot0:playAnima(uv2.Down, 0, 0)
	else
		slot0:playAnima(uv2.Up, 0, 0)
	end
end

function slot0.onAvatarLoaded(slot0)
	uv0.super.onAvatarLoaded(slot0)

	if not slot0._target.avatar.loader then
		return
	end

	if not gohelper.isNil(slot1:getInstGO()) then
		slot0._animSelf = slot2:GetComponent(typeof(UnityEngine.Animator))
	end

	slot0:playAnima(uv1.UpIdle, 0, 1)
end

function slot0.playAnima(slot0, slot1, ...)
	if slot0._animSelf then
		slot0._animSelf:Play(slot1, ...)
	end
end

function slot0.dispose(slot0)
	uv0.super.dispose(slot0)
end

return slot0
