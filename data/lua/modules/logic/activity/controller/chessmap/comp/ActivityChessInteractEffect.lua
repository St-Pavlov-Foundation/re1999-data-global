module("modules.logic.activity.controller.chessmap.comp.ActivityChessInteractEffect", package.seeall)

slot0 = class("ActivityChessInteractEffect")

function slot0.ctor(slot0, slot1)
	slot0._target = slot1
end

function slot0.refreshSearchFailed(slot0)
	if slot0._target.originData and slot0._target.originData.data and slot0._target.avatar and slot0._target.avatar.goLostTarget then
		gohelper.setActive(slot0._target.avatar.goLostTarget, slot0._target.originData.data.lostTarget)
	end
end

function slot0.dispose(slot0)
end

function slot0.onAvatarLoaded(slot0)
	if not slot0._target.avatar.loader then
		return
	end

	slot0._target.avatar.goLostTarget = gohelper.findChild(slot1:getInstGO(), "piecea/vx_vertigo")

	slot0:refreshSearchFailed()
end

return slot0
