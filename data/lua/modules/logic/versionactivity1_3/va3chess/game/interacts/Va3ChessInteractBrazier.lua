module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractBrazier", package.seeall)

slot0 = class("Va3ChessInteractBrazier", Va3ChessInteractBase)

function slot0.onAvatarLoaded(slot0)
	uv0.super.onAvatarLoaded(slot0)

	if not slot0._target.avatar.loader then
		return
	end

	if not gohelper.isNil(slot1:getInstGO()) then
		slot0._goFire = gohelper.findChild(slot2, "huopeng_fire")
	end

	slot0:refreshBrazier()
end

function slot0.refreshBrazier(slot0)
	slot1 = false

	if slot0._target.originData then
		slot1 = slot0._target.originData:getBrazierIsLight()
	end

	if not gohelper.isNil(slot0._goFire) then
		gohelper.setActive(slot0._goFire, slot1)
	end
end

return slot0
