module("modules.logic.versionactivity1_3.va3chess.game.effect.Va3ChessNextDirectionEffect", package.seeall)

slot0 = class("Va3ChessNextDirectionEffect", Va3ChessEffectBase)

function slot0.refreshEffect(slot0)
end

function slot0.onDispose(slot0)
end

function slot0.refreshNextDirFlag(slot0)
	if slot0._target.originData.data and slot0._target.originData.data.alertArea then
		slot1 = slot0._target.originData.posX
		slot2 = slot0._target.originData.posY

		if #slot0._target.originData.data.alertArea == 1 then
			slot0._target:getHandler():faceTo(Va3ChessMapUtils.ToDirection(slot0._target.originData.posX, slot0._target.originData.posY, slot3[1].x, slot3[1].y))
		end
	end
end

function slot0.onAvatarLoaded(slot0)
	slot1 = slot0._loader

	if not slot0._loader then
		return
	end

	if not gohelper.isNil(slot1:getInstGO()) then
		slot3 = slot0._target.avatar

		for slot7, slot8 in ipairs(Va3ChessInteractObject.DirectionList) do
			slot9 = gohelper.findChild(slot2, "dir_" .. slot8)
			slot3.goNextDirection = slot2
			slot3["goMovetoDir" .. slot8] = slot9

			gohelper.setActive(slot9, false)
		end
	end

	slot0:refreshNextDirFlag()
end

return slot0
