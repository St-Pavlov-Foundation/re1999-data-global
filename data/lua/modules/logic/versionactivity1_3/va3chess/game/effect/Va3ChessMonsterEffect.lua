module("modules.logic.versionactivity1_3.va3chess.game.effect.Va3ChessMonsterEffect", package.seeall)

slot0 = class("Va3ChessMonsterEffect", Va3ChessEffectBase)

function slot0.refreshEffect(slot0)
end

function slot0.onDispose(slot0)
end

function slot0.onAvatarLoaded(slot0)
	slot1 = slot0._loader

	if not slot0._loader then
		return
	end

	if not gohelper.isNil(slot1:getInstGO()) then
		slot3 = gohelper.findChild(slot2, "vx_tracked")
		slot4 = gohelper.findChild(slot2, "vx_number")

		gohelper.setActive(slot0._target.avatar.goTrack, false)
		gohelper.setActive(slot3, false)
		gohelper.setActive(slot4, false)
		gohelper.setActive(gohelper.findChild(slot2, "icon_tanhao"), false)

		slot0._target.avatar.goTrack = slot3
		slot0._target.avatar.goNumber = slot4
	end
end

return slot0
